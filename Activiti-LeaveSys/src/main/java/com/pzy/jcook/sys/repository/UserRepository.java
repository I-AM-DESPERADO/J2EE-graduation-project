package com.pzy.jcook.sys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.pzy.jcook.sys.entity.User;

public interface UserRepository   extends BaseRepository<User ,Long>{
	
	public User findByUsername(String username);
	
	@Query("select b from User b  inner join fetch b.roles as a where a.id=?1 ")
	public List<User> findUserByRole(Long rolecode);
	
	public User findByOpenid(String openId);
}
