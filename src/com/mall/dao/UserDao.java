package com.mall.dao;

import com.mall.pojo.User;

public interface UserDao {
	//注册
	Integer addUser(User user);
	
	//Integer deleteUser(Integer user_id);
	
	Integer modifyUser(User user);
	
	//Integer findUser();
	
	//用于注册验证用户名
	Integer checkName(String username);
	
	//登陆时用于验证用户名和密码
	Integer checkLogin(User user);
	
	//使用后台功能时验证权限
	Integer checkRole(String username);
	
	Integer queryUser_idByUsername(String username);
}
