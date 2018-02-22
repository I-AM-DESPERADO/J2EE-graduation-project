package com.pzy.jcook.workflow.service;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pzy.jcook.sys.service.BaseService;
import com.pzy.jcook.workflow.dto.CheckDTO;
import com.pzy.jcook.workflow.entity.Check;
import com.pzy.jcook.workflow.repository.CheckRepository;

@Service
public class CheckService extends BaseService<Check, Long> {
	
	
	@Autowired
	private CheckRepository checkRepository;
	
	public Boolean isCheckedToday(Long userid){
		List<Check> list = checkRepository.findByUserIdAndCheckDate(userid, DateUtils.truncate(new Date(),Calendar.DAY_OF_MONTH));
		return !org.apache.commons.collections.CollectionUtils.isEmpty(list);
	}
	
	public Check getCheck(Long userid){
		List<Check> list = checkRepository.findByUserIdAndCheckDate(userid, DateUtils.truncate(new Date(),Calendar.DAY_OF_MONTH));
		if( org.apache.commons.collections.CollectionUtils.isEmpty(list))
			return null;
		else return list.get(0);
	}
	
	public List<CheckDTO> findChecks(Date s,Date e){
		return this.checkRepository.findRank(s, e);
	}
}
