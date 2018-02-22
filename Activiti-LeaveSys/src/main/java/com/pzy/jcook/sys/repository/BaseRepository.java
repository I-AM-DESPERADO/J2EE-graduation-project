package com.pzy.jcook.sys.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.PagingAndSortingRepository;
@NoRepositoryBean
public interface BaseRepository<M, ID extends Serializable> extends PagingAndSortingRepository<M, ID>,JpaSpecificationExecutor<M> {
}
