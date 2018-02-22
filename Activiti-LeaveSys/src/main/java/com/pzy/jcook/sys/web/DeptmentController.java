package com.pzy.jcook.sys.web;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pzy.jcook.dto.json.DataTableResponse;
import com.pzy.jcook.dto.json.Response;
import com.pzy.jcook.sys.dto.DeptmentSelect;
import com.pzy.jcook.sys.dto.DeptmentTree;
import com.pzy.jcook.sys.entity.Deptment;
import com.pzy.jcook.sys.service.DeptmentService;
import com.pzy.jcook.sys.service.UserService;


@Controller
@RequestMapping("sys/deptment")
public class DeptmentController extends AbstractBaseCURDController<Deptment,Long>  {
	
	@Override
	public DeptmentService getBaseService() {
		return (DeptmentService)super.getBaseService();
	}
	
	
	@Override
	public String getBasePath() {
		return "sys/deptment";
	}
	
	@RequestMapping("alldeptments")
	@ResponseBody
	public List<DeptmentTree> allDeptments(){
		List<Deptment> deptements = this.getBaseService().findAll();
		List<DeptmentTree> deptmentTrees = new ArrayList<DeptmentTree>();
		for(Deptment dept:deptements){
			deptmentTrees.add(new DeptmentTree(dept));
		}
		return deptmentTrees;
	}
	
	@Override
	@RequestMapping("index")
	public String index(Model model) {
		List<Deptment> deptments = this.getBaseService().queryRootList();
		List<DeptmentSelect> deptmentselect = new ArrayList<DeptmentSelect>();
		for(Deptment dept:deptments){
			DeptmentSelect.convertToSelectDto(dept,deptmentselect);
		}
		model.addAttribute("deptmentselects",deptmentselect);
		return this.getBasePath()+"/index";
	}
	
	@RequestMapping("listall")
	@ResponseBody
	public Response listall(Integer start, Integer length, String name,Long deptid) {
		int pageNumber = (int) (start / length) + 1;
		int pageSize = length;
		Page<Deptment> m = this.getBaseService().findAll(pageNumber, pageSize, name,deptid);
		return new DataTableResponse<Deptment>( m.getContent(),(int) m.getTotalElements() );
	}
}
