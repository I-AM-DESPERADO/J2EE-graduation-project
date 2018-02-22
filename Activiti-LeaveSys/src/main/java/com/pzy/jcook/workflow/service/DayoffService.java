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
import com.pzy.jcook.workflow.entity.DayOff;
import com.pzy.jcook.workflow.repository.DayoffRepository;

@Service
public class DayoffService extends BaseService< DayOff, Long> {
	
	@Autowired
	private DayoffRepository dayoffRepository;
	
	

	public Page<DayOff> findAll(int pageNumber, int pageSize, final Long deptment,final String username,final Date datefrom,
			final Date dateend) {
		PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
        Specification<DayOff> spec = new Specification<DayOff>() {
             public Predicate toPredicate(Root<DayOff> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
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
        Page<DayOff> result = (Page<DayOff>) baseRepository.findAll(spec, pageRequest);
        return result;
	}



	public List<CheckDTO> findChecks(Date s, Date e) {
		return this.dayoffRepository.findRank(s, e);
	} 
	
}
