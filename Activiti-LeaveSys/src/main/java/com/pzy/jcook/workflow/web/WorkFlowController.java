package com.pzy.jcook.workflow.web;

import java.text.ParseException;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pzy.jcook.dto.json.DataTableResponse;
import com.pzy.jcook.dto.json.Response;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.workflow.dto.ActivitDTO;
import com.pzy.jcook.workflow.service.WorkFlowService;

@Controller
@RequestMapping("workflow")
public class WorkFlowController {
	
	private static Logger log = LoggerFactory.getLogger(WorkFlowController.class);
	@Autowired
	WorkFlowService workFlowService;
	
	@Autowired
	private ProcessEngine processEngine;
	
	@RequestMapping("tasktodo")
	public String tasktodo(Model model) {
		return  "workflow/tasktodo";
	}

	@RequestMapping("taskdone")
	public String taskdone(Model model) {
		return  "workflow/taskdone";
	}
	
	@RequestMapping("tasktodolist")
	@ResponseBody
	public Response tasktodolist(Integer start, Integer length, String name) throws ParseException {
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("currentUser");
		Page<ActivitDTO> m = workFlowService.findTaskTodo(null, null, null, null, name, null,  user.getId(), start, length);
		return new DataTableResponse<ActivitDTO>( m.getContent(),(int) m.getTotalElements() );
	}
	
	@RequestMapping("taskdonelist")
	@ResponseBody
	public Response taskdonelist(Integer start, Integer length, String name) throws ParseException {
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("currentUser");
		Page<ActivitDTO> m = workFlowService.findTaskdone(null,null, null, null, name, null, null, user.getId(), start, length);
		return new DataTableResponse<ActivitDTO>( m.getContent(),(int) m.getNumberOfElements() );
	}
	
	@RequestMapping("/task/{taskid}/{processInstanceId}")
	public String task(@PathVariable String taskid,@PathVariable String processInstanceId) {
		ProcessInstance processInstance = processEngine.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		if(processInstance==null){
			log.warn("参数错误或者流程不存在，请返回！");
			throw new RuntimeException("参数错误或者流程不存在！");
		}
		Task task=processEngine.getTaskService().createTaskQuery().taskId(taskid).singleResult();
		if(task==null){
			log.warn("该任务已经完成，请返回！");
			throw new RuntimeException("该任务已经被完成或者不存在，请返回！");
		}
		String prefix=processInstance.getProcessDefinitionKey();
		return "redirect:/workflow/" +prefix+"/task/"+taskid+"/"+processInstanceId;
	}
	
	@RequestMapping("/taskhistory/{processInstanceId}")
	public String taskhistory(@PathVariable String processInstanceId) {
		HistoricProcessInstance processInstance = processEngine.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		Assert.notNull(processInstance,"参数错误或者流程不存在");
		String prefix=processEngine.getRepositoryService().getProcessDefinition(processInstance.getProcessDefinitionId()).getKey();;
		return "redirect:/workflow/" +prefix+"/taskhistory/"+processInstanceId ;	
	}
	
}
