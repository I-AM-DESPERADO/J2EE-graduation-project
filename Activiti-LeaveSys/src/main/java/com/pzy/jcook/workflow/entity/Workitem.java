package com.pzy.jcook.workflow.entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.pzy.jcook.sys.entity.BaseEntity;
import com.pzy.jcook.sys.entity.User;

@Entity
@Table(name = "t_workitem")
public class Workitem  extends BaseEntity<Long>{
	private String title;
	private String remark;
	private Date beginDate;
	private Date endDate;
	
	@ManyToOne(fetch = FetchType.EAGER)
	private User creater;
	
	@ManyToOne(fetch = FetchType.EAGER)
	private User leader;
	
	@OneToMany
	private Set<User> applyusers;
	
	@OneToMany
	private Set<User> handleusers;
	
	@OneToMany
	private Set<User> users;
	
	private String[] files;
	
	private String state;
	
	private String approve;
	
	private Integer reject;

	public String getApprove() {
		return approve;
	}


	public void setApprove(String approve) {
		this.approve = approve;
	}


	public Integer getReject() {
		return reject;
	}


	


	public String[] getFiles() {
		return files;
	}


	public void setFiles(String[] files) {
		this.files = files;
	}


	public void setReject(Integer reject) {
		this.reject = reject;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Date getBeginDate() {
		return beginDate;
	}


	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}


	public Set<User> getApplyusers() {
		return applyusers;
	}


	public void setApplyusers(Set<User> applyusers) {
		this.applyusers = applyusers;
	}


	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public User getLeader() {
		return leader;
	}


	public void setLeader(User leader) {
		this.leader = leader;
	}


	

	public Set<User> getUsers() {
		return users;
	}


	public void setUsers(Set<User> users) {
		this.users = users;
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


	public Set<User> getHandleusers() {
		return handleusers;
	}


	public void setHandleusers(Set<User> handleusers) {
		this.handleusers = handleusers;
	}

	
}
