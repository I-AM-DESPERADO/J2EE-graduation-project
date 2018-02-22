package com.pzy.jcook.sys.shiro.oauth2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

public class OAuth2AuthenticationFilter extends AuthenticatingFilter {
	
	private static final Logger log = LoggerFactory.getLogger(OAuth2AuthenticationFilter.class);
	
    private String authcCodeParam = "code";
    
    private String failureUrl;
    
    private String unbindUrl;
    
    public static final  Map<String,String> successUrlMap = new HashMap<String, String>(){
		private static final long serialVersionUID = 72282409246202317L;
		{
    		put("/oauth2/tasktodo","/workflow/tasktodo");
    		put("/oauth2/taskdone","/workflow/taskdone");
    		put("/oauth2/taskcreate","/workitem/create");
    	}
    };
    
    public void setAuthcCodeParam(String authcCodeParam) {
        this.authcCodeParam = authcCodeParam;
    }

    public void setFailureUrl(String failureUrl) {
        this.failureUrl = failureUrl;
    }

    public String getUnbindUrl() {
		return unbindUrl;
	}

	public void setUnbindUrl(String unbindUrl) {
		this.unbindUrl = unbindUrl;
	}

	@Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String code = httpRequest.getParameter(authcCodeParam);
        return new OAuth2Token(code);
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        return false;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {

    	log.info("onAccessDenied____");
        String error = request.getParameter("error");
        String errorDescription = request.getParameter("error_description");
        if(!StringUtils.isEmpty(error)) {//如果服务端返回了错误
            WebUtils.issueRedirect(request, response, failureUrl + "?error=" + error + "error_description=" + errorDescription);
            return false;
        }
        Subject subject = getSubject(request, response);
        if(!subject.isAuthenticated()) {
            if(StringUtils.isEmpty(request.getParameter(authcCodeParam))) {
            	log.info("redirecttologin ________");
            	saveRequestAndRedirectToLogin(request, response);
                return false;
            }
        }

        return executeLogin(request, response);
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
                                     ServletResponse response) throws Exception {
    	
		
    	 HttpServletRequest httpServletRequest= (HttpServletRequest)request;
    	 String key = "/oauth2/"+StringUtils.getFilename(httpServletRequest.getRequestURI());
    	 log.info("onLoginSuccess-key{}-",key);
    	 WebUtils.redirectToSavedRequest(request, response,successUrlMap.get(key));
    	 return false;
    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException ae, ServletRequest request,
                                     ServletResponse response) {
    	log.info("onLoginFailure executeLogin____________"+ae.getClass().getName());
    	log.info("onLoginFailure instanceof_______________"+(ae instanceof UnknownAccountException) );
    	log.info("onLoginFailure getStackTrace___________"+ae.getStackTrace() );
    	log.info("onLoginFailure getMessage_______________"+ae.getMessage());
    	Subject subject = getSubject(request, response);
    	
    	/**未绑定用户*/
    	if(true){
    		try {
    			log.info("onLoginFailure _unbind-->"+unbindUrl);
				WebUtils.redirectToSavedRequest(request, response,unbindUrl);
				return false;
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    	if (subject.isAuthenticated() || subject.isRemembered()) {
            try {
                issueSuccessRedirect(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                WebUtils.issueRedirect(request, response, failureUrl);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

}