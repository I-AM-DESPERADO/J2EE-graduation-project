package com.pzy.jcook.sys.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pzy.jcook.sys.entity.Role;
import com.pzy.jcook.sys.entity.User;
import com.pzy.jcook.sys.repository.RoleRepository;
import com.pzy.jcook.sys.repository.UserRepository;
@Service
public class UserService extends BaseService<User, Long> {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	public User findByUsername(String username){
		return this.userRepository.findByUsername(username);
	}
	
	public User findByOpenid(String openid){
		return this.userRepository.findByOpenid(openid);
	}
	
	public List<Role> findAllRoles(){
		return (List<Role>)this.roleRepository.findAll();
	}
	
	public Role findRole(Long id){
		return this.roleRepository.findOne(id);
	}
	
	public List<User> findAll(){
		return (List<User>)this.userRepository.findAll();
	}
	
	public List<User> findUserByRole(Long roleid){
		return this.userRepository.findUserByRole(roleid);
	}
}
