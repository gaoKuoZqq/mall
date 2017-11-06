package com.mall.back.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mall.dto.PageBean;
import com.mall.pojo.Product;
import com.mall.service.Order_itemService;

@Controller
@RequestMapping("/order_item")
public class Order_itemController {
	@Resource(name="order_itemService")
	Order_itemService order_itemService;
	@RequestMapping("/find")
	public ModelAndView findOrder(PageBean pageBean) {
		if (pageBean.getPageIndex() == null || pageBean.getPageIndex() == 0) {
			pageBean.setPageIndex(1);
		}
		if (pageBean.getPageSize() == null || pageBean.getPageSize() == 0) {
			pageBean.setPageSize(4);
		}
		if (pageBean.getProduct() == null ) {
			pageBean.setProduct(new Product());
		}
		Integer pageIndex = pageBean.getPageIndex();
		Integer pageSize  = pageBean.getPageSize();
		pageBean.setLimitStart((pageIndex - 1) * pageSize);
		ModelAndView modelAndView = new ModelAndView();
		pageBean= order_itemService.findOrder_item(pageBean);
		modelAndView.addObject(pageBean);
		modelAndView.setViewName("order_item_find");
		return modelAndView;
	}
}
