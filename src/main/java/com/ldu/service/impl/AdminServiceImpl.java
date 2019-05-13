package com.ldu.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ldu.dao.AdminMapper;
import com.ldu.pojo.Admin;
import com.ldu.service.AdminService;

@Service(value="adminService")
public class AdminServiceImpl implements AdminService {
	@Resource
	private AdminMapper am;


	public Admin findAdmin(String username, String password) {
		// TODO Auto-generated method stub
		return am.findAdmin(username,password);
	}


	public Admin findAdminById(Integer id) {
		// TODO Auto-generated method stub
		return am.findAdminById(id);
	}


	public void updateAdmin(Admin admins) {
		 am.updateAdmin(admins);
	}


	

}
