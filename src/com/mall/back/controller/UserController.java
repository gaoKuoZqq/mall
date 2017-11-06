package com.mall.back.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mall.back.responce.ServerResponse;
import com.mall.pojo.User;
import com.mall.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource(name="userService")
	UserService userService;
	
	@RequestMapping("goLogin")
	public ModelAndView goLogin(){
		ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("login");
		return modelAndView;
	}
	
	
	@RequestMapping("checkLogin")
	@ResponseBody
	public ServerResponse login(User user,HttpServletRequest request){
		if (userService.checkLogin(user)) {
			if (userService.checkRole(user.getUsername())) {
				HttpSession session = request.getSession(true);
				session.setAttribute("username", user.getUsername());
				return ServerResponse.createSuccess();
			}else {
				return ServerResponse.createError("权限不足","权限不足");
			}
		}else {
			return ServerResponse.createError("帐号或密码错误","帐号或密码错误");
		}
		
	}
	
	@RequestMapping("logOut")
	@ResponseBody
	public void logOut(HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("username", null);
	}
}
