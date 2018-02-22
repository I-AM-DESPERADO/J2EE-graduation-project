package com.pzy.jcook.sys.web;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pzy.jcook.dto.json.FailedResponse;
import com.pzy.jcook.dto.json.SuccessResponse;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.sys.service.UserService;
import com.pzy.jcook.sys.shiro.oauth2.OAuth2Realm;

@Controller
public class LoginController {
	
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Value("${spring.weixin.authorizeurl}")
	public  String authorizeurl;
	
	@Autowired
	public UserService userService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		Subject subject = SecurityUtils.getSubject();
		if(subject.isAuthenticated()||subject.isRemembered()){
			return "login";
		} 
		  return "login";
	}
	/***
	 * 登陆的逻辑已经被shiro过滤器处理，这里只要读取shiro处理后得到的结果
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String dologin(HttpServletRequest req,Model model) {
		   String exceptionClassName = (String)req.getAttribute("shiroLoginFailure");  
	       log.info("登录失败{}",exceptionClassName); 
		   model.addAttribute("tip", "用户名/密码错误");  
		return "login";
	}
	
	@RequestMapping(value = "/loginout", method = RequestMethod.GET)
	public String loginout(Model model) {
		SecurityUtils.getSubject().logout();
		return "login";
	}
	
	@RequestMapping(value = {"/","","index"}, method = RequestMethod.GET)
	public String  index(Model model) {
		Subject subject = SecurityUtils.getSubject();
		 log.info("index----------isAuthenticated------------"+subject.isAuthenticated());
		 User user = (User)SecurityUtils.getSubject().getSession().getAttribute("currentUser");
    	 log.info("index----------oauth2-----------inde get---"+user);
		return "redirect:/workflow/tasktodo";
	}
	
	@RequestMapping(value = "/binduser", method = RequestMethod.GET)
	public String  binduser(Model model) {
		 String openid = (String)SecurityUtils.getSubject().getSession().getAttribute(OAuth2Realm.OPENID_INSESSION_KEY);
    	 log.info("binduser---openid---"+openid);
		 return "binduser";
	}
	
	@RequestMapping(value = "/dobinduser", method = RequestMethod.POST)
	public String  dobinduser(Model model,String username, RedirectAttributes redirectAttributes) {
		 String openid = (String)SecurityUtils.getSubject().getSession().getAttribute(OAuth2Realm.OPENID_INSESSION_KEY);
		 
		 User user = userService.findByUsername(username);
		 
		 if(openid==null){
			 log.info("dobinduser--openid---is  null---");
			 model.addAttribute("response", new FailedResponse("openidb存在！")); 
			 return "binduser";
		 }
		 if(user==null){
			 log.info("dobinduser--user---is null ---");
			 model.addAttribute("response", new FailedResponse("该用户不存在，请联系管理员开通用户！")); 
			 return "binduser";
		 }
		 
		 if(StringUtils.isNotBlank(user.getOpenid())){
			 log.info("dobinduser--user---is null ---");
			 model.addAttribute("response", new FailedResponse("已经被绑定！！")); 
			 return "binduser";	
		 }else{
			 log.info("dobinduser--user---is setOpenid ---");
			 user.setOpenid(openid);
			 userService.save(user);
			 redirectAttributes.addAttribute("response", new SuccessResponse("绑定成功！"));
			return "redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa34b86e23638e4b4&redirect_uri=http://gsj.icecn.net/oauth2/tasktodo&response_type=code&scope=snsapi_base&state=STATE";
		 }

		
	}
	public  String getAuthorizeurl() {
		return authorizeurl;
	}
	public  void setAuthorizeurl(String authorizeurl) {
		this.authorizeurl = authorizeurl;
	}
}
