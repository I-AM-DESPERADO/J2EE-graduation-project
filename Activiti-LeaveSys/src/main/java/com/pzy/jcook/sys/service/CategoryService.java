package com.pzy.jcook.sys.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.pzy.jcook.sys.entity.Category;
import com.pzy.jcook.sys.repository.CategoryRepository;


@Service
public class CategoryService  extends BaseService<Category, Long> {
	@Autowired
	public CategoryRepository categoryRepository;
	
	public List<Category> queryRootList(){
		return this.categoryRepository.queryByParent(null);
	}
	
	public List<Category> findAll(){
		return (List<Category>)this.categoryRepository.findAll();
	}
	
	public Page<Category> findAll(final int pageNumber, final int pageSize,final String name,final Long pid){
        PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
        Specification<Category> spec = new Specification<Category>() {
             public Predicate toPredicate(Root<Category> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
             Predicate predicate = cb.conjunction();
             
             if (StringUtils.isNotBlank(name)) {
                  predicate.getExpressions().add(cb.like(root.get("name").as(String.class), "%"+name+"%"));
             }
             
             if (pid!=null) {
                 predicate.getExpressions().add(cb.equal(root.get("parent").get("id").as(Integer.class),pid));
             }
             return predicate;
             }
        };
        Page<Category> result = (Page<Category>) baseRepository.findAll(spec, pageRequest);
        return result;
  } 
}
