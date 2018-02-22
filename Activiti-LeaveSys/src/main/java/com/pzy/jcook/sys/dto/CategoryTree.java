package com.pzy.jcook.sys.dto;

import com.pzy.jcook.sys.entity.Category;

public class CategoryTree {
	
	public String id;
	
	public String parent;
	
	public String text;
	
	public CategoryTree(Category dept){
		this.id=dept.getId().toString();
		this.parent=dept.getParent()==null?"#":dept.getParent().getId().toString();
		this.text="["+dept.getCode()+"]"+dept.getName();
		
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
}
