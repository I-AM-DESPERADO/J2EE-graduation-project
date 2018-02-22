package com.pzy.jcook.workflow.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.pzy.jcook.sys.repository.BaseRepository;
import com.pzy.jcook.workflow.dto.CheckDTO;
import com.pzy.jcook.workflow.entity.DayOff;

public interface DayoffRepository   extends BaseRepository<DayOff ,Long>{
	
	@Query(value=" SELECT new com.pzy.jcook.workflow.dto.CheckDTO(t1.creater.chinesename,t1.creater.deptment.name,COUNT(*),SUM(hours)) FROM DayOff t1  WHERE  t1.datefrom>=?1 AND t1.datefrom<?2 GROUP BY  creater ORDER BY SUM(hours) DESC ")
	public List<CheckDTO> findRank( Date startDate, Date endDate);
}
