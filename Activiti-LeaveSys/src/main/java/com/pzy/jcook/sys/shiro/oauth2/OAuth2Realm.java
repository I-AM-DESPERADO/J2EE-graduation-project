package com.pzy.jcook.sys.shiro.oauth2;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.oltu.oauth2.client.OAuthClient;
import org.apache.oltu.oauth2.client.URLConnectionClient;
import org.apache.oltu.oauth2.client.request.OAuthClientRequest;
import org.apache.oltu.oauth2.client.response.OAuthAccessTokenResponse;
import org.apache.oltu.oauth2.common.OAuth;
import org.apache.oltu.oauth2.common.exception.OAuthProblemException;
import org.apache.oltu.oauth2.common.exception.OAuthSystemException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.ShiroException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.pzy.jcook.sys.entity.Role;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.sys.service.UserService;

public class OAuth2Realm extends AuthorizingRealm {
	private static final Logger log = LoggerFactory.getLogger(OAuth2Realm.class);
	public static final String OPENID_INSESSION_KEY="openid_insession_key";
	
	private String clientId;
   
	private String clientSecret;
    
	private String accessTokenUrl;
	@Autowired
	private UserService userService; 

    @Override
    public boolean supports(AuthenticationToken token) {
    	log.info("supports"+token);
        return token instanceof OAuth2Token;//表示此Realm只支持OAuth2Token类型
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    	String currentUsername = (String) super.getAvailablePrincipal(principals);
		User user = userService.findByUsername(currentUsername);
		
		/**角色*/
		List<String> roleList = new ArrayList<String>();
		
		/**权限*/
		List<String> permissionList = new ArrayList<String>();
		if(!CollectionUtils.isNotEmpty(user.getRoles())){
			for (Role role : user.getRoles()) {
				roleList.add(role.getCode());
			}
		}
		
		SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
		simpleAuthorInfo.addRoles(roleList);
		simpleAuthorInfo.addStringPermissions(permissionList);
		return simpleAuthorInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws ShiroException {
        log.info("AuthenticationInfo___"+token);
        OAuth2Token oAuth2Token = (OAuth2Token) token;
        String code = oAuth2Token.getAuthCode();
   	    User user = null;
		try {
			user = getUser(oAuth2Token.getAuthCode());
			log.info("AuthenticationInfo--",user);
		} catch (OAuthSystemException e) {
			throw new AuthenticationException(e);
		} catch (OAuthProblemException e) {
			throw new AuthenticationException(e);
		}
		
   	    if(user == null){
   	        log.info("user is null___"+token);
   	    	throw new UnknownAccountException("user is null");
   	    }
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getChinesename(), code, getName());
        SecurityUtils.getSubject().getSession().setAttribute("currentUser", user);
        return authenticationInfo;
        
    }
    /***
     * 根据code 获取tooken 在根据tooken获取用户信息
     * @param code
     * @return
     * @throws OAuthSystemException
     * @throws OAuthProblemException
     */
    private User getUser(String code) throws OAuthSystemException, OAuthProblemException  {
        	log.info("getUser"+code);
        	OAuthClient oAuthClient = new OAuthClient(new URLConnectionClient());
        	OAuthClientRequest accessTokenRequest = OAuthClientRequest
                    .tokenLocation(accessTokenUrl)
                    .setParameter("appid", clientId)
                    .setParameter("secret", clientSecret)
                    .setCode(code)
                    .setParameter("grant_type", "authorization_code")
                    .buildQueryMessage();
        	log.info("accessTokenRequest---"+accessTokenRequest);
             
            OAuthAccessTokenResponse oAuthResponse = oAuthClient.accessToken(accessTokenRequest, OAuth.HttpMethod.POST);

            String accessToken = oAuthResponse.getAccessToken();
            String openid = oAuthResponse.getParam("openid");
            
            log.info("accessToken{}--openid{}-",accessToken,openid);
            
            log.info("openid---"+openid);
            User user = null;
            if(openid!=null){
            	 SecurityUtils.getSubject().getSession().setAttribute(OPENID_INSESSION_KEY, openid);
            	 user = userService.findByOpenid(openid);
            }
            log.info("user---"+user);
            return user;	
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }

    public void setAccessTokenUrl(String accessTokenUrl) {
        this.accessTokenUrl = accessTokenUrl;
    }
}