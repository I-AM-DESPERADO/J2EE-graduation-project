package com.pzy.jcook.sys.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pzy.jcook.dto.json.FailedResponse;
import com.pzy.jcook.dto.json.ObjectResponse;
import com.pzy.jcook.dto.json.Response;
import com.pzy.jcook.dto.json.SuccessResponse;
import com.pzy.jcook.sys.dto.DeptmentSelect;
import com.pzy.jcook.sys.entity.Deptment;
import com.pzy.jcook.sys.entity.Role;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.sys.service.DeptmentService;
import com.pzy.jcook.sys.service.UserService;
import com.pzy.jcook.workflow.entity.Check;
import com.pzy.jcook.workflow.service.CheckService;

@Controller
@RequestMapping("sys/user")
public class UserController extends AbstractBaseCURDController<User,Long>  {
	
	@Autowired
	private DeptmentService deptmentService;
	
	@Autowired
	private  CheckService checkService;
	@Override
	public UserService getBaseService() {
		return (UserService)super.getBaseService();
	}
	
	@RequestMapping("check")
	@ResponseBody
	public Response check() {
		User sessionUser = (User)SecurityUtils.getSubject().getSession().getAttribute("currentUser");
		User user = this.getBaseService().find(sessionUser.getId());
		if(checkService.isCheckedToday(user.getId())){
			return new SuccessResponse("今天已经签到，无需重复签到！");
		}
		
		Check check = new Check();
		check.setCheckTime(new Date());
		check.setCheckDate(DateUtils.truncate(new Date(), Calendar.DAY_OF_MONTH));
		check.setUser(user);
		
		checkService.save(check);
		return new SuccessResponse("签到成功！");
	}
	
	
	@RequestMapping("checkout")
	@ResponseBody
	public Response checkout() {
		User sessionUser = (User)SecurityUtils.getSubject().getSession().getAttribute("currentUser");
		User user = this.getBaseService().find(sessionUser.getId());
		Check check = checkService.getCheck(user.getId());
		if(check == null){
			return new SuccessResponse("错误，您还未签到！不能进行签退操作！");
		}
		
		check.setCheckoutTime(new Date());
		check.setHours(new Double((check.getCheckoutTime().getTime()-check.getCheckTime().getTime())/(1000*60*60)));
		check.setCheckTime(new Date());
		checkService.save(check);
		return new SuccessResponse("签退成功！");
	}
	
	@RequestMapping("center")
	public String center(Model model) {
		return this.getBasePath()+"/center";
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
		model.addAttribute("roles", this.getBaseService().findAllRoles());
		return this.getBasePath()+"/index";
	}
	@RequestMapping(value = "changepw", method = RequestMethod.GET)
	public String changepw(Model model) {
		model.addAttribute("user", (User)SecurityUtils.getSubject().getSession().getAttribute("currentUser"));
		return this.getBasePath()+"/changepw";
	}
	
	@RequestMapping(value = "/changepw", method = RequestMethod.POST)
	public String changepw(Model model,String newpw,String oldpw) {
		Long userid = ((User)SecurityUtils.getSubject().getSession().getAttribute("currentUser")).getId();
		User user = this.getBaseService().find(userid);
		if(!user.getPassword().equals( DigestUtils.md5Hex(oldpw))){
			model.addAttribute("response",new FailedResponse("原始密码不正确"));
		}else{
			user.setPassword( DigestUtils.md5Hex(newpw));
			this.getBaseService().save(user);
			model.addAttribute("response",new SuccessResponse());
		}
		
		return this.getBasePath()+"/changepw";
	}
	@Override
	protected String getBasePath() {
		return "sys/user";
	}
	
	@ModelAttribute
	public User preget(@RequestParam(required=false) Long id,@RequestParam(required=false) String role) {
		User user = new User();
		if (id!=null){
			user = this.getBaseService().find(id);
		}else{
			user.setPassword( DigestUtils.md5Hex(User.DEFAULT_PASSWORD));
		}
		if(StringUtils.isNotBlank(role)){
			String[] ids = role.split(",");
			List<Role> roles = new ArrayList<Role>();
			for(int i=0;i<ids.length;i++){
				roles.add(this.getBaseService().findRole(Long.valueOf(ids[i])));
			}
			user.setRoles(roles);
		}
		return user;
	}
}
