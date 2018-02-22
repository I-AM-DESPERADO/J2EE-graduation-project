package com.pzy.jcook.workflow.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.pzy.jcook.sys.entity.BaseEntity;
import com.pzy.jcook.sys.entity.User;
/***
 * 打卡表
 *
 *
 */
@Entity
@Table(name = "t_workflow_check")
public class Check  extends BaseEntity<Long>{
	
	
	@ManyToOne
	private User  user;
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8") 
	private Date checkDate;
	
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8") 
	private Date checkTime;
	
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8") 
	private Date checkoutTime;
	
	private Double hours;
	
	public Date getCheckoutTime() {
		return checkoutTime;
	}


	public void setCheckoutTime(Date checkoutTime) {
		this.checkoutTime = checkoutTime;
	}


	public Double getHours() {
		return hours;
	}


	public void setHours(Double hours) {
		this.hours = hours;
	}


	private String type;


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Date getCheckDate() {
		return checkDate;
	}


	public Date getCheckTime() {
		return checkTime;
	}


	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}


	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}
	
	

	
}
