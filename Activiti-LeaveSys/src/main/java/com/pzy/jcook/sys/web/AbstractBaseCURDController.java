package com.pzy.jcook.sys.web;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pzy.jcook.dto.json.DataTableResponse;
import com.pzy.jcook.dto.json.ObjectResponse;
import com.pzy.jcook.dto.json.Response;
import com.pzy.jcook.dto.json.SuccessResponse;
import com.pzy.jcook.sys.entity.BaseEntity;
import com.pzy.jcook.sys.service.BaseService;

public abstract  class AbstractBaseCURDController<M extends BaseEntity<?>, ID extends Serializable> implements BaseCURDController<M , ID >{
	
	@Autowired
	private BaseService<M, ID> baseService;
	
	
	public BaseService<M, ID> getBaseService() {
		return baseService;
	}

	public void setBaseService(BaseService<M, ID> baseService) {
		this.baseService = baseService;
	}

	protected abstract String getBasePath();
	
	@Override
	@RequestMapping("index")
	public String index(Model model) {
		return this.getBasePath()+"/index";
	}

	@Override
	@RequestMapping("save")
	@ResponseBody
	public Response save(M m) {
		baseService.save(m);
		return new SuccessResponse();
	}

	@Override
	@RequestMapping("update")
	@ResponseBody
	public Response update(M m) {
		baseService.save(m);
		return new SuccessResponse();
	}

	@Override
	@RequestMapping("delete")
	@ResponseBody
	public Response delete(ID id) {
		baseService.delete(id);
		return new SuccessResponse();
	}
	
	@Override
	@RequestMapping("get")
	@ResponseBody
	public Response get(ID id) {
		return new ObjectResponse<M>(baseService.find(id));
	}
	
	@Override
	@RequestMapping("list")
	@ResponseBody
	public Response list(Integer start, Integer length, String value,String columnname) {
		int pageNumber = (int) (start / length) + 1;
		int pageSize = length;
		Page<M> m = baseService.findAll(pageNumber, pageSize, value,columnname);
		return new DataTableResponse<M>( m.getContent(),(int) m.getTotalElements() );
	}

}
