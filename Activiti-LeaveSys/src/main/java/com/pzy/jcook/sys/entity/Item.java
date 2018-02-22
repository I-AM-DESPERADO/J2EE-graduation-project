package com.pzy.jcook.sys.entity;

import javax.persistence.Entity;
import javax.persistence.OneToOne;
import javax.persistence.Table;
@Entity
@Table(name = "t_sys_item")
public class Item extends BaseEntity<Long>{
	
	public String name;
	
	public String code;
	
	private String state;
	
	private String imgcode;
	
	private String format ;
	
	private String model;
	
	@OneToOne
	private Category category;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getImgcode() {
		return imgcode;
	}
	public void setImgcode(String imgcode) {
		this.imgcode = imgcode;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	
}
