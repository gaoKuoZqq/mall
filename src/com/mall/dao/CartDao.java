package com.mall.dao;

import java.util.List;

import com.mall.pojo.Cart;

public interface CartDao {
	
	Integer addCart(Cart cart);
	
	Integer deleteCart(Integer cart_id);
	
	Integer modifyCart(Cart cart);
	
	List<Cart> findCart(Integer user_id);
	
	//注销时将勾选状态变为未勾选
	void modifyCartChecked(Integer user_id);
	
	void modifyCartCheckedTrue(Cart cart);
	
	Cart findCartByCartId(Integer cart_id);
	
	//为了把同样的商品归为一条,先查一下有没有
	Cart findCartByNewCart(Cart cart);
}
