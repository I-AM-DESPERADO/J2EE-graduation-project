package com.pzy.jcook.workflow.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pzy.jcook.dto.json.DataTableResponse;
import com.pzy.jcook.dto.json.Response;
import com.pzy.jcook.dto.json.SuccessResponse;
import com.pzy.jcook.sys.dto.DeptmentSelect;
import com.pzy.jcook.sys.entity.Deptment;
import com.pzy.jcook.sys.entity.Role;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.sys.service.DeptmentService;
import com.pzy.jcook.sys.service.UserService;
import com.pzy.jcook.sys.web.AbstractBaseCURDController;
import com.pzy.jcook.workflow.dto.CheckDTO;
import com.pzy.jcook.workflow.entity.DayOff;
import com.pzy.jcook.workflow.service.DayoffService;
import com.pzy.jcook.workflow.service.WorkFlowService;

/***
 * 任务单据的相关操作
 * 
 *
 */
@Controller
@RequestMapping("workflow/dayoff")
public class DayoffController extends AbstractBaseCURDController<DayOff,Long> {
	private static final Logger log = LoggerFactory.getLogger(DayoffController.class);

	@Autowired
	DayoffService dayoffService;

	@Autowired
	private ProcessEngine processEngine;

	@Autowired
	private UserService userService;

	@Autowired
	private WorkFlowService workFlowService;
	
	@Autowired
	private DeptmentService deptmentService;

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm"), true));
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Model model) {
		List<Deptment> deptments = deptmentService.queryRootList();
		List<DeptmentSelect> deptmentselect = new ArrayList<DeptmentSelect>();
		for(Deptment dept:deptments){
			DeptmentSelect.convertToSelectDto(dept,deptmentselect);
		}
		model.addAttribute("deptmentselects",deptmentselect);
		return "workflow/dayoff/create";
	}
	
	@RequestMapping("reportindex")
	public String reportindex() {
		return "workflow/dayoff/reportindex";
	}
	
	@RequestMapping("report")
	@ResponseBody
	public Response report(Integer start, Integer length,Date s,Date e) {
		
		List<CheckDTO> m = this.dayoffService.findChecks(s, e);
		return new DataTableResponse<CheckDTO>( m,5 );
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(DayOff ship,Model model) {
		
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
		ship.setCreater(user);
		ship.setCreateDate(new Date());
		dayoffService.save(ship);
		/** 发起流程 */
		Map<String, Object> activtiMap = new HashMap<String, Object>();
		activtiMap.put("title", ship.getCreater().getChinesename()+"于"+DateFormatUtils.format(new Date(), "yyyy-MM-dd")+"发起的请假单");
		activtiMap.put("creater", user.getId());
		activtiMap.put("deptLeader", 5);
		activtiMap.put("leader", 1);
		activtiMap.put("type", ship.getType());
		ProcessInstance processInstance = processEngine.getRuntimeService().startProcessInstanceByKey("dayoff",
				ship.getId().toString(), activtiMap);
		/** 完成第一步（提交申请） */
		String sn = "请假单" + DateFormatUtils.format(new Date(), "_yyyy_MM_") + processInstance.getId();

		processEngine.getRuntimeService().setVariable(processInstance.getProcessInstanceId(), "sn", sn);

		List<Task> tasks = processEngine.getTaskService().createTaskQuery().processInstanceId(processInstance.getId())
				.list();
		processEngine.getTaskService().complete(tasks.get(0).getId(), activtiMap);

		model.addAttribute("response", new SuccessResponse("单据提交成功！"));
		model.addAttribute("users", userService.findAll());
		return "workflow/dayoff/create";
	}
	
	/***
	 * 跳转到表单详情
	 * 
	 * @param taskid
	 * @param prcessInstanceid
	 * @return
	 */
	@RequestMapping("/task/{taskid}/{prcessInstanceid}")
	public ModelAndView task(@PathVariable String taskid, @PathVariable String prcessInstanceid) {
		ProcessInstance processInstance = processEngine.getRuntimeService().createProcessInstanceQuery()
				.processInstanceId(prcessInstanceid).singleResult();
		Task task = processEngine.getTaskService().createTaskQuery().taskId(taskid).singleResult();
		/** 找task key用于页面跳转 */
		String taskkey = "";

		if (task == null) {
			HistoricTaskInstance historicTaskInstance = processEngine.getHistoryService()
					.createHistoricTaskInstanceQuery().taskId(taskid).singleResult();

			taskkey = historicTaskInstance.getTaskDefinitionKey();
		} else {
			taskkey = task.getTaskDefinitionKey();
		}

		String businessKey = "";
		if (processInstance == null)
			businessKey = processEngine.getHistoryService().createHistoricProcessInstanceQuery()
					.processInstanceId(prcessInstanceid).singleResult().getBusinessKey();
		else
			businessKey = processInstance.getBusinessKey();

		ModelAndView mav = new ModelAndView("workflow/dayoff/" + taskkey);

		/**
		 * task ,assignee，prcessInstanceid，processDefinitionId用于审批页面顶部提示以及流程图显示
		 */
		mav.addObject("task", task);
		mav.addObject("processDefinitionId", processInstance.getProcessDefinitionId());
		mav.addObject("taskhistory", workFlowService.findHistoryTask(prcessInstanceid));
		mav.addObject("prcessInstanceid", prcessInstanceid);
		mav.addObject("users", userService.findAll());
		mav.addObject("bean", dayoffService.find(Long.valueOf(businessKey)));
		mav.addObject("sn", processEngine.getRuntimeService().getVariable(prcessInstanceid, "sn"));
		return mav;
	}

	@RequestMapping("/taskhistory/{prcessInstanceid}")
	public ModelAndView taskhistory(@PathVariable String prcessInstanceid) {
		HistoricProcessInstance processInstance = processEngine.getHistoryService().createHistoricProcessInstanceQuery()
				.processInstanceId(prcessInstanceid).singleResult();
		Assert.notNull(processInstance, "参数错误或者流程不存在");
		String bussnessid = processEngine.getHistoryService().createHistoricProcessInstanceQuery()
				.processInstanceId(prcessInstanceid).singleResult().getBusinessKey();

		ModelAndView mav = new ModelAndView("workflow/dayoff/history");
		mav.addObject("taskhistory", workFlowService.findHistoryTask(prcessInstanceid));
		mav.addObject("bean", dayoffService.find(Long.valueOf(bussnessid)));
		mav.addObject("sn", processEngine.getHistoryService().createHistoricVariableInstanceQuery()
				.processInstanceId(prcessInstanceid).variableName("sn").singleResult().getValue().toString());
		/**
		 * task ,assignee，prcessInstanceid，processDefinitionId用于审批页面顶部提示以及流程图显示
		 */
		Task currentTask = workFlowService.getCurrentTask(prcessInstanceid);
		mav.addObject("task", currentTask);
		mav.addObject("prcessInstanceid", prcessInstanceid);
		mav.addObject("processDefinitionId", processInstance.getProcessDefinitionId());
		return mav;
	}
	
	@RequestMapping("/doapprove/{taskid}/{prcessInstanceid}")
	public String doapprove(@PathVariable String taskid, @PathVariable String prcessInstanceid, Boolean pass,
			String approvals, DayOff ship,
			RedirectAttributes redirectAttributes) {
		ProcessInstance processInstance = processEngine.getRuntimeService().createProcessInstanceQuery()
				.processInstanceId(prcessInstanceid).singleResult();
		Task task = processEngine.getTaskService().createTaskQuery().taskId(taskid).singleResult();
		Map<String, Object> activtiMap = new HashMap<String, Object>();
		ship = this.dayoffService.find(ship.getId());
		ship.setReject(pass?1:0);
		/** TODO 判断当前登录人是不是任务的拥有者 ***/
		if ("usertask2".equals(task.getTaskDefinitionKey())) {
			activtiMap.put("pass", pass);
			activtiMap.put("deptLeader", 5);
			processEngine.getTaskService().addComment(task.getId(), processInstance.getId(), approvals);
			processEngine.getTaskService().complete(task.getId(), activtiMap);
			ship.setApprove(approvals);
			this.dayoffService.save(ship);
		} else if ("usertask3".equals(task.getTaskDefinitionKey())) {
			activtiMap.put("pass", pass);
			activtiMap.put("deptLeader", 1);
			processEngine.getTaskService().addComment(task.getId(), processInstance.getId(), approvals);
			processEngine.getTaskService().complete(task.getId(), activtiMap);
			this.dayoffService.save(ship);
		}

		redirectAttributes.addFlashAttribute("response", new SuccessResponse("操作成功"));
		return "redirect:/workflow/dayoff/taskhistory/" + prcessInstanceid;
	}
	
	

	@Override
	@RequestMapping("index")
	public String index(Model model) {
		List<Deptment> deptments = this.deptmentService.queryRootList();
		List<DeptmentSelect> deptmentselect = new ArrayList<DeptmentSelect>();
		for(Deptment dept:deptments){
			DeptmentSelect.convertToSelectDto(dept,deptmentselect);
		}
		model.addAttribute("deptmentselects",deptmentselect);
		return this.getBasePath()+"/index";
	}
	
	
	@RequestMapping("listall")
	@ResponseBody
	public Response listall(Integer start, Integer length, Long deptment,String username,Date datefrom,Date dateend) {
		int pageNumber = (int) (start / length) + 1;
		int pageSize = length;
		Page<DayOff> m = this.dayoffService.findAll(pageNumber, pageSize, deptment,username,datefrom,dateend);
		return new DataTableResponse<DayOff>( m.getContent(),(int) m.getTotalElements() );
	}
	
	
	@Override
	protected String getBasePath() {
		return "workflow/dayoff";
	}

	@ModelAttribute
	public DayOff preget(@RequestParam(required=false) Long id,@RequestParam(required=false) String role) {
		DayOff user = new DayOff();
		if (id!=null){
			user = this.getBaseService().find(id);
		}
		return user;
	}
}
