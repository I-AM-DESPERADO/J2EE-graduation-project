package com.pzy.jcook.workflow.service.nofy;

import java.util.HashMap;
import java.util.Map;

public class WeixinTemplateMsg {
	public String touser;
	public String template_id;
	public String url;
	
	public Map<String,MsgItem> data =new HashMap<String,MsgItem>();
	
	
	public WeixinTemplateMsg() {
		super();
	}


	public WeixinTemplateMsg(String touser, String template_id, String url) {
		super();
		this.touser = touser;
		this.template_id = template_id;
		this.url = url;
	}


	public String getTouser() {
		return touser;
	}


	public void setTouser(String touser) {
		this.touser = touser;
	}


	public String getTemplate_id() {
		return template_id;
	}


	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public Map<String, MsgItem> getData() {
		return data;
	}


	public void setData(Map<String, MsgItem> data) {
		this.data = data;
	}
}
class MsgItem{
	public String value;
	public String color;
	
	public MsgItem(String value, String color) {
		super();
		this.value = value;
		this.color = color;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
}
