package com.pzy.jcook.sys.shiro.oauth2;

import org.apache.shiro.authc.AuthenticationToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class OAuth2Token implements AuthenticationToken {  
    /**
	 * 
	 */
	private static final Logger log = LoggerFactory.getLogger(OAuth2Realm.class);
	
	private static final long serialVersionUID = 5076281233323510095L;
	private String authCode;  
    private String principal;  
    public OAuth2Token(String authCode) {
    	 log.info("created OAuth2Token______________"+authCode);
        this.authCode = authCode;  
    }
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getPrincipal() {
		return principal;
	}
	public void setPrincipal(String principal) {
		this.principal = principal;
	}
	@Override
	public Object getCredentials() {
		return authCode;
	}  
    
}   