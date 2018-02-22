package com.pzy.jcook.sys.service;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.pzy.jcook.sys.entity.Item;
@Service
public class ItemService extends BaseService<Item, Long> {
	
	public Page<Item> findAll(final int pageNumber, final int pageSize,final String name,final Long pid){
        PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
        Specification<Item> spec = new Specification<Item>() {
             public Predicate toPredicate(Root<Item> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
             Predicate predicate = cb.conjunction();
             
             if (StringUtils.isNotBlank(name)) {
                  predicate.getExpressions().add(cb.like(root.get("name").as(String.class), "%"+name+"%"));
             }
             
             if (pid!=null) {
                 predicate.getExpressions().add(cb.equal(root.get("category").get("id").as(Integer.class),pid));
             }
             return predicate;
             }
        };
        Page<Item> result = (Page<Item>) baseRepository.findAll(spec, pageRequest);
        return result;
  } 
}
