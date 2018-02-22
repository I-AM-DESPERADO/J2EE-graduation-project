package com.pzy.jcook.workflow.service;
import java.util.Date;
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

import com.pzy.jcook.sys.service.BaseService;
import com.pzy.jcook.workflow.dto.CheckDTO;
import com.pzy.jcook.workflow.entity.Overtime;
import com.pzy.jcook.workflow.entity.Overtime;
import com.pzy.jcook.workflow.repository.OvertimeRepository;

@Service
public class OvertimeService extends BaseService< Overtime, Long> {
	
	@Autowired
	private OvertimeRepository overtimeRepository;
	
	

	public Page<Overtime> findAll(int pageNumber, int pageSize, final Long deptment,final String username,final Date datefrom,
			final Date dateend) {
		PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
        Specification<Overtime> spec = new Specification<Overtime>() {
             public Predicate toPredicate(Root<Overtime> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
             Predicate predicate = cb.conjunction();
             if (deptment!=null) {
                  predicate.getExpressions().add(cb.equal(root.get("deptment").get("id"),deptment));
             }
             if (!StringUtils.isBlank(username)) {
                 predicate.getExpressions().add(cb.equal(root.get("username").as(String.class),username));
             }
             if (datefrom!=null) {
                 predicate.getExpressions().add(cb.greaterThan(root.get("datefrom").as(Date.class),datefrom));
             }
             if (dateend!=null) {
                 predicate.getExpressions().add(cb.lessThan(root.get("datefrom").as(Date.class),dateend));
             }
             return predicate;
             }
        };
        Page<Overtime> result = (Page<Overtime>) baseRepository.findAll(spec, pageRequest);
        return result;
	} 
	
	public List<CheckDTO> findChecks(Date s, Date e) {
		return this.overtimeRepository.findRank(s, e);
	} 
	
	
}
