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
import com.pzy.jcook.workflow.entity.Check;
import com.pzy.jcook.workflow.entity.DayOff;
import com.pzy.jcook.workflow.service.CheckService;
import com.pzy.jcook.workflow.service.DayoffService;
import com.pzy.jcook.workflow.service.WorkFlowService;

/***
 * 打卡相关操作
 * 
 */
@Controller
@RequestMapping("workflow/check")
public class CheckController extends AbstractBaseCURDController<Check,Long> {
	private static final Logger log = LoggerFactory.getLogger(CheckController.class);

	@Autowired
	DayoffService dayoffService;

	@Autowired
	private ProcessEngine processEngine;

	@Autowired
	private UserService userService;

	@Autowired
	private  CheckService checkService;
	
	@Autowired
	private DeptmentService deptmentService;

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm"), true));
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
	public Response listall(Integer start, Integer length,Date s,Date e) {
		
		List<CheckDTO> m = this.checkService.findChecks(s, e);
		return new DataTableResponse<CheckDTO>( m,5 );
	}
	

	@Override
	protected String getBasePath() {
		return "workflow/check";
	}

	
}
