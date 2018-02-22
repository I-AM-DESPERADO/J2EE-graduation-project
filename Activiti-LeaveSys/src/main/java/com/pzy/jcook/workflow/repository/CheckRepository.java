package com.pzy.jcook.workflow.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.pzy.jcook.sys.repository.BaseRepository;
import com.pzy.jcook.workflow.dto.CheckDTO;
import com.pzy.jcook.workflow.entity.Check;

public interface CheckRepository   extends BaseRepository<Check ,Long>{
	public List<Check> findByUserIdAndCheckDate(Long id,Date date);
	

	@Query(value=" SELECT new com.pzy.jcook.workflow.dto.CheckDTO(t1.user.chinesename,t1.user.deptment.name,COUNT(*),SUM(hours)) FROM Check t1  WHERE  t1.checkDate>=?1 AND t1.checkDate<?2 GROUP BY  user ORDER BY SUM(hours) DESC ")
	public List<CheckDTO> findRank( Date startDate, Date endDate);
}
