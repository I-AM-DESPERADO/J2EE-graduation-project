package com.pzy.jcook.workflow.dto;

public class CheckDTO {
	private String user;
	
	private String deptment;
	
	private Long num;
	
	private Double hours;

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getDeptment() {
		return deptment;
	}

	public void setDeptment(String deptment) {
		this.deptment = deptment;
	}

	public Long getNum() {
		return num;
	}

	public void setNum(Long num) {
		this.num = num;
	}

	public Double getHours() {
		return hours;
	}

	public void setHours(Double hours) {
		this.hours = hours;
	}

	public CheckDTO(String user, String deptment, Long num, Double hours) {
		super();
		this.user = user;
		this.deptment = deptment;
		this.num = num;
		this.hours = hours;
	}
	
	public CheckDTO(String user, String deptment, Long num, Long hours) {
		super();
		this.user = user;
		this.deptment = deptment;
		this.num = num;
		this.hours = new Double(hours);
	}
}
