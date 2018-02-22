package com.pzy.jcook.workflow.dto;

public class ShortUrlDTO {
	private String longurl;
	private String tinyurl;
	private String status;
	private String err_msg;
	public String getLongurl() {
		return longurl;
	}
	public void setLongurl(String longurl) {
		this.longurl = longurl;
	}
	public String getTinyurl() {
		return tinyurl;
	}
	public void setTinyurl(String tinyurl) {
		this.tinyurl = tinyurl;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getErr_msg() {
		return err_msg;
	}
	public void setErr_msg(String err_msg) {
		this.err_msg = err_msg;
	}
	@Override
	public String toString() {
		return "ShortUrlDTO [longurl=" + longurl + ", tinyurl=" + tinyurl + ", status=" + status + ", err_msg="
				+ err_msg + "]";
	}
	
}
