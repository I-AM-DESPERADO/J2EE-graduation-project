package com.pzy.jcook.sys.repository;
import java.util.List;

import com.pzy.jcook.sys.entity.Category;

public interface CategoryRepository   extends BaseRepository<Category,Long>{
	public List<Category> queryByParent(Category dept);
}
