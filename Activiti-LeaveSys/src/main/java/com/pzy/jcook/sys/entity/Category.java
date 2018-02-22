package com.pzy.jcook.sys.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
@Entity
@Table(name = "t_sys_category")
public class Category extends BaseEntity<Long>{
	
	private String name;
	
	private String code;
	
	private String shortName;
	

	@ManyToOne
    @JoinColumn(name = "parent_id")
	private  Category parent;
	
	@OneToMany(mappedBy = "parent")
	@JsonIgnore
	private List<Category> childrens;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public  Category getParent() {
		return parent;
	}

	public void setParent( Category parent) {
		this.parent = parent;
	}

	

	public List<Category> getChildrens() {
		return childrens;
	}

	public void setChildrens(List<Category> childrens) {
		this.childrens = childrens;
	}


	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
}
