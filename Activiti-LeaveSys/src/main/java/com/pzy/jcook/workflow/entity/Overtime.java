package com.pzy.jcook.workflow.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.pzy.jcook.sys.entity.BaseEntity;
import com.pzy.jcook.sys.entity.Deptment;
import com.pzy.jcook.sys.entity.User;
/***
 * 加班表
 *
 */
@Entity
@Table(name = "t_workflow_overtime")
public class Overtime  extends BaseEntity<Long>{
	
	@ManyToOne
	private Deptment  deptment;
	
	private String username;
	
	private String chinesename;
	
	private String tel;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8") 
	private Date datefrom;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8") 
	private Date dateend;
	
	private String type;
	
	private String remark;
	
	private Integer hours;
	
	@ManyToOne(fetch = FetchType.EAGER)
	private User creater;
	
	private String state;
	
	private String approve;
	
	private Integer reject;
	
	

	public Deptment getDeptment() {
		return deptment;
	}


	public Integer getHours() {
		return hours;
	}


	public void setHours(Integer hours) {
		this.hours = hours;
	}


	public void setDeptment(Deptment deptment) {
		this.deptment = deptment;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getChinesename() {
		return chinesename;
	}


	public void setChinesename(String chinesename) {
		this.chinesename = chinesename;
	}


	public String getTel() {
		return tel;
	}


	public void setTel(String tel) {
		this.tel = tel;
	}


	public Date getDatefrom() {
		return datefrom;
	}


	public void setDatefrom(Date datefrom) {
		this.datefrom = datefrom;
	}


	public Date getDateend() {
		return dateend;
	}


	public void setDateend(Date dateend) {
		this.dateend = dateend;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getApprove() {
		return approve;
	}


	public void setApprove(String approve) {
		this.approve = approve;
	}


	public Integer getReject() {
		return reject;
	}


	public void setReject(Integer reject) {
		this.reject = reject;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public User getCreater() {
		return creater;
	}

	public void setCreater(User creater) {
		this.creater = creater;
	}
	
}
