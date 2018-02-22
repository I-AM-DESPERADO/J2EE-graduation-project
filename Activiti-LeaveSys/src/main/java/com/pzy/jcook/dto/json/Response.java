package com.pzy.jcook.dto.json;

public interface Response {
 	public static final String CODE_FAILED = "0"; 
    public static final String MSG_FAILED = "failed"; 
    public static final String CODE_SUCCESS = "1"; 
    public static final String MSG_SUCCESS = "success";
    public static final String CODE_EMPTY = "-1";
    public static final String MSG_EMPTY = "empty";
	
    String getCode();

	String getMsg();
}
