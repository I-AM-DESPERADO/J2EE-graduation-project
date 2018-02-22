package com.pzy.jcook.workflow.dto;

import java.util.Date;
import java.util.List;

import org.activiti.engine.task.Attachment;

import com.pzy.jcook.sys.entity.User;


public class ActivitiHistoryTaskDTO {
	private String name;
	private User user;
	private Date startTime;
	private Date endTime;
	private String approves;
	
	private List<Attachment> attachment;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getApproves() {
		return approves;
	}
	public void setApproves(String approves) {
		this.approves = approves;
	}
	public List<Attachment> getAttachment() {
		return attachment;
	}
	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}
	
}
