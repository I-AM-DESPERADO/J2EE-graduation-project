package com.pzy.jcook.sys.repository;
import java.util.List;

import com.pzy.jcook.sys.entity.Deptment;

public interface DeptmentRepository   extends BaseRepository<Deptment ,Long>{
	public List<Deptment> queryByParent(Deptment dept);
}
