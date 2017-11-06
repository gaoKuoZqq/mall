package com.mall.front.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mall.pojo.Cart;
import com.mall.pojo.Product;
import com.mall.service.CartService;
import com.mall.service.ProductService;
import com.mall.service.UserService;
import com.mall.vo.CartVO;
import com.mall.vo.Cart_itemVO;
@Controller
@RequestMapping("/cart")
public class CartController {
	@Resource(name="cartService")
	CartService cartService;
	@Resource(name="productService")
	ProductService productService;
	@Resource(name="userService")
	UserService userService;
	
	@RequestMapping("gocart")
	public ModelAndView goCart(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("cart");
		HttpSession session = request.getSession(true);
		if (session.getAttribute("username") == null) {
			Cookie[] cookies = request.getCookies();
			CartVO cartVO = null;
			if (cookies == null) {
				return modelAndView;
			}
			for (Cookie cookie : cookies) {
				if ("cart_cookie".equals(cookie.getName())) {
					//springmvc
					ObjectMapper objectMapper = new ObjectMapper();
					//只有对象里面不是null的才转换
					objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
					String value = cookie.getValue();
					try {
						cartVO = objectMapper.readValue(value, CartVO.class);
					} catch (IOException e) {
						e.printStackTrace();
					}
					List<Cart> cartsList = new ArrayList<Cart>();
					for (Cart_itemVO cart_itemVO : cartVO.getCart_itemVOsList()) {
						Product product = productService.findProductById(cart_itemVO.getProduct().getId());
						cartsList.add(new Cart(product.getId(),cart_itemVO.getQuantity(),product));
					}
					modelAndView.addObject("cartsList",cartsList);
				}
			}
			return modelAndView;
		}else{
			Integer user_id = userService.queryUser_idByUsername((String)session.getAttribute("username"));
			List<Cart> cartsList = cartService.findCart(user_id);
			//因为展示需要,往里面塞了个product,但是同时塞了很多没用的东西,因为懒
			for (Cart cart : cartsList) {
				Product product = productService.findProductById(cart.getProduct_id());
				cart.setProduct(product);
			}
			modelAndView.addObject("cartsList",cartsList);
		}
		return modelAndView;
	}
	
	@RequestMapping("add")
	@ResponseBody
	public Boolean addCart(Cart cart,HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		Integer product_id = cart.getProduct_id();
		//获得产品库存
		Product product = productService.findProductById(product_id);
		Integer product_stock = product.getStock();
		if (session.getAttribute("username") != null) {
			String username = (String) session.getAttribute("username");
			Integer user_id = userService.queryUser_idByUsername(username);
			cart.setUser_id(user_id);
			cart.setChecked(1);
			//判断是否存在重复cart
			Cart oldCart = cartService.findCartByNewCart(cart);
			//如果已存在同产品cart 叠加,否则添加新cart
			if (oldCart == null) {
				//如果需求量大于库存,操作失败
				if (cart.getQuantity() > product_stock) {
					return false;
				}else {
					return cartService.addCart(cart);
				}
			}else {
				//如果需求量大于库存,操作失败
				if ((oldCart.getQuantity() + cart.getQuantity()) > product_stock) {
					return false;
				}else{
					oldCart.setQuantity(oldCart.getQuantity() + cart.getQuantity());
					return cartService.modifyCart(oldCart);
				}
			}
		}else{//如果没在登录状态,使用cookies储存购物车信息
			//----------------------------------
			//springmvc
			ObjectMapper objectMapper = new ObjectMapper();
			//只有对象里面不是null的才转换
			objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
			CartVO cartVO = null;
			Cookie[] cookies = request.getCookies();
			//1.如果cookie有这个购物车对象，那就从cookie里面取出这个购物车对象
			if (null != cookies && cookies.length > 0) {
				for (Cookie cookie : cookies) {
					if ("cart_cookie".equals(cookie.getName())) {
						//之前已经有购物车
						String value = cookie.getValue();
						try {
							cartVO = objectMapper.readValue(value, CartVO.class);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
			//2.如果cookie没有这个购物车对象,才需要new BuyCartVO
			if (cartVO == null) {
				cartVO = new CartVO();
			}
			
			//把购物项放到购物车里面
			if (null != product_id) {
				Product productInCart_itemVO = new Product();
				productInCart_itemVO.setId(product_id);
				productInCart_itemVO.setStock(product_stock);
				Cart_itemVO cartItemVO = new Cart_itemVO();
				cartItemVO.setProduct(productInCart_itemVO);
				cartItemVO.setQuantity(cart.getQuantity());
				
				cartVO.addCart_itemVO(cartItemVO);
				cartVO.setProduct_id(product_id);
				
				//把购物车对象BuyCartVO以json形式写到cookie里面
				StringWriter stringWriter = new StringWriter();
			    try {
					objectMapper.writeValue(stringWriter, cartVO);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				//将购物车json数据放到cookie里面
				Cookie cookie = new Cookie("cart_cookie", stringWriter.toString());
				//默认关闭浏览器cookie销毁
				cookie.setMaxAge(60 * 60 * 24);
				
				cookie.setPath("/");
				
				//将cookie发送给浏览器
				response.addCookie(cookie);
			}
			//----------------------------------
			return true;
		}
		
	}
	
	@RequestMapping("modify")
	@ResponseBody
	public Boolean modifyCart(Cart cart,HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		if (session.getAttribute("username") == null) {
			Cookie[] cookies = request.getCookies();
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
					for (Cart_itemVO cart_itemVO : cartVO.getCart_itemVOsList()) {
						if (cart_itemVO.getProduct().getId() == cart.id) {
							cart_itemVO.setQuantity(cart.getQuantity());
							//把购物车对象BuyCartVO以json形式写到cookie里面
							StringWriter stringWriter = new StringWriter();
						    try {
								objectMapper.writeValue(stringWriter, cartVO);
							} catch (IOException e) {
								e.printStackTrace();
							}
						    cookie.setValue(stringWriter.toString());
						    //cookie.setMaxAge(60 * 60 * 24);
						    cookie.setPath("/");
						    response.addCookie(cookie);
							break;
						}
					}
				}
			}
			return true;
		}else{
			return cartService.modifyCart(cart);
		}
	}
	
	@RequestMapping("del")
	@ResponseBody
	public Boolean deleteCart(String ids){
		String[] idsList = ids.trim().split(" ");
		for (String idStr : idsList) {
			if (!idStr.trim().equals("")) {
				cartService.deleteCart(Integer.parseInt(idStr.trim()));
			}
		}
		return true;
	}
}
