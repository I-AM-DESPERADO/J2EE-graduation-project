package com.pzy.jcook.sys.service;

import java.io.Serializable;

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

import com.pzy.jcook.sys.entity.BaseEntity;
import com.pzy.jcook.sys.repository.BaseRepository;


public class BaseService <M extends BaseEntity<?>, ID extends Serializable> {
	@Autowired
    protected BaseRepository<M, ID> baseRepository; 
	
	public M save(M m) {
	    return baseRepository.save(m);
	}
	
	public void delete(M m){
		baseRepository.delete(m);
	}
	
	public M find(ID id){
		  return baseRepository.findOne(id);
	}
	
	public Page<M> findAll(final int pageNumber, final int pageSize,final String name,final String targerAttr){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<M> spec = new Specification<M>() {
              public Predicate toPredicate(Root<M> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (StringUtils.isNotBlank(name)) {
                   predicate.getExpressions().add(cb.like(root.get(targerAttr).as(String.class), "%"+name+"%"));
              }
              return predicate;
              }
         };
         Page<M> result = (Page<M>) baseRepository.findAll(spec, pageRequest);
         return result;
     	} 
	
	public void delete(ID id){
		baseRepository.delete(id);
	}
}
