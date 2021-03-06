package com.mall.front.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mall.pojo.Cart;
import com.mall.pojo.User;
import com.mall.service.CartService;
import com.mall.service.ProductService;
import com.mall.service.UserService;
import com.mall.vo.CartVO;
import com.mall.vo.Cart_itemVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource(name="userService")
	UserService userService;
	@Resource(name="cartService")
	CartService cartService;
	@Resource(name="productService")
	ProductService productService;
	
	@RequestMapping("add")
	@ResponseBody
	public Boolean addUser(User user) {
		if (user == null || user.getUsername() == null || user.getUsername().trim().equals("")
				|| user.getPassword() == null || user.getPassword().trim().equals("")
				|| user.getEmail() == null || user.getEmail().trim().equals("") 
				|| user.getQuestion() == null || user.getQuestion().trim().equals("") 
				|| user.getAnswer() == null || user.getAnswer().trim().equals("") ) {
			return false;
		}
		if (user.getRole() == null || user.getRole() != 0) {
			user.setRole(1);
		}
		return userService.addUser(user);
	}
	@RequestMapping("goadd")
	public ModelAndView goAddUser(){
		ModelAndView modelAndView = new ModelAndView("register");
		return modelAndView;
	}
	
	@RequestMapping("modifyuser")
	@ResponseBody
	public Boolean modifyUser(User user) {
		return userService.addUser(user);
	}
	
	@RequestMapping("checkname")
	@ResponseBody
	public Boolean checkName(String username) {
		return userService.checkName(username);
	}
	
	@RequestMapping("login")
	@ResponseBody
	public Boolean checkLogin(User user, String cart_ids, HttpServletRequest request) {
		if (user.getUsername() == null || user.getUsername().trim().equals("") || 
				user.getPassword() == null || user.getPassword().trim().equals("")) {
			return false;
		}
		Boolean isSuccess = userService.checkLogin(user);
		if(isSuccess){
			HttpSession session = request.getSession(true);
			session.setAttribute("username", user.getUsername());
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("cart_cookie".equals(cookie.getName())) {
						//springmvc
						ObjectMapper objectMapper = new ObjectMapper();
						//只有对象里面不是null的才转换
						objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
						CartVO cartVO = new CartVO();
						String value = cookie.getValue();
						try {
							cartVO = objectMapper.readValue(value, CartVO.class);
						} catch (IOException e) {
							e.printStackTrace();
						}
						List<Cart_itemVO> cart_itemVOsList = cartVO.getCart_itemVOsList();
						Cart cart = new Cart();
						cart.setUser_id(userService.queryUser_idByUsername(user.getUsername()));
						for (Cart_itemVO cart_itemVO : cart_itemVOsList) {
							Integer product_id = cart_itemVO.getProduct().getId();
							Integer product_stock = productService.findProductById(product_id).getStock();
							cart.setProduct_id(product_id);
							cart.setQuantity(cart_itemVO.getQuantity());
							cart.setChecked(0);
							//判断是否存在重复cart
							Cart oldCart = cartService.findCartByNewCart(cart);
							//如果已存在同产品cart 叠加,否则添加新cart
							if (oldCart != null) {
								cartService.deleteCart(oldCart.getId());
							}
							//如果需求量大于库存,设置需求量为库存
							if (cart.getQuantity() > product_stock) {
								cart.setQuantity(product_stock);
								cartService.addCart(cart);
							}else {
								cartService.addCart(cart);
							}
						}
						//把刚刚添加的勾选状态设置为1
						String[] cart_idsList = cart_ids.trim().split(" ");
						Cart cartCheckTrue = new Cart();
						if (cart_idsList != null) {
							for (String cart_id : cart_idsList) {
								if (cart_id.matches("[0-9]+")) {
									cartCheckTrue.setUser_id(userService.queryUser_idByUsername(user.getUsername()));
									cartCheckTrue.setProduct_id(Integer.parseInt(cart_id));
									cartService.modifyCartCheckedTrue(cartCheckTrue);
								}
							}
						}
						break;
					}
				}
			}
 		}
		return isSuccess;
	}
	@RequestMapping("gologin")
	public ModelAndView goLogin(){
		ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("login");
		return modelAndView;
	}
	
	@RequestMapping("logout")
	@ResponseBody
	public Boolean logout(String username,HttpServletRequest request){
		HttpSession session = request.getSession(true);
		session.setAttribute("username", null);
		Integer user_id = userService.queryUser_idByUsername(username);
		cartService.modifyCartChecked(user_id);
		return true;
	}
	
	public Boolean checkRole(String username) {
		return userService.checkRole(username);
	}
}
