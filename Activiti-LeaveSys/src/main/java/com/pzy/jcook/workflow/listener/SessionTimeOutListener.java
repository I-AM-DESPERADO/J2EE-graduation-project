package com.pzy.jcook.workflow.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
public class SessionTimeOutListener implements HttpSessionListener {
	 
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("==== Session is created ====");
        System.out.println("==== Session is created ===="+event.getSession().getMaxInactiveInterval());
    }
 
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        System.out.println("==== Session is destroyed ====");
    }
}
