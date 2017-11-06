package com.mall.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mall.dao.CartDao;
import com.mall.pojo.Cart;
import com.mall.service.CartService;
@Service("cartService")
public class CartServiceImpl implements CartService{
	@Resource(name="cartDao")
	CartDao cartDao;

	@Override
	public Boolean addCart(Cart cart) {
		return cartDao.addCart(cart) > 0;
	}

	@Override
	public Boolean deleteCart(Integer cart_id) {
		return cartDao.deleteCart(cart_id) > 0;
	}

	@Override
	public Boolean modifyCart(Cart cart) {
		return cartDao.modifyCart(cart) > 0;
	}

	@Override
	public List<Cart> findCart(Integer user_id) {
		return cartDao.findCart(user_id);
	}

	@Override
	public void modifyCartChecked(Integer user_id) {
		cartDao.modifyCartChecked(user_id);
	}

	@Override
	public List<Cart> findCartByCartIdSet(Set<Integer> cart_idsSet) {
		List<Cart> cartsList = new ArrayList<Cart>();
		for (Integer cart_id : cart_idsSet) {
			cartsList.add(cartDao.findCartByCartId(cart_id));
		}
		return cartsList;
	}

	@Override
	public Cart findCartByNewCart(Cart cart) {
		return cartDao.findCartByNewCart(cart);
	}

	@Override
	public void modifyCartCheckedTrue(Cart cart) {
		cartDao.modifyCartCheckedTrue(cart);
	}
	

}
