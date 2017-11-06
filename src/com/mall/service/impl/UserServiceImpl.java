package com.mall.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mall.dao.UserDao;
import com.mall.pojo.User;
import com.mall.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource(name="userDao")
	UserDao userDao;
	@Override
	public boolean addUser(User user) {
		return userDao.addUser(user) > 0;
	}

	@Override
	public boolean modifyUser(User user) {
		return userDao.modifyUser(user) > 0;
	}

	@Override
	public boolean checkName(String username) {
		return userDao.checkName(username) > 0;
	}

	@Override
	public boolean checkLogin(User user) {
		return userDao.checkLogin(user) > 0;
	}

	@Override
	public boolean checkRole(String username) {
		return userDao.checkRole(username) == 0;
	}

	@Override
	public Integer queryUser_idByUsername(String username) {
		return userDao.queryUser_idByUsername(username);
	}

}
