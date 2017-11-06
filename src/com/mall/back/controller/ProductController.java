package com.mall.back.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mall.dto.PageBean;
import com.mall.pojo.Category;
import com.mall.pojo.Product;
import com.mall.service.CategoryService;
import com.mall.service.IStaticPageService;
import com.mall.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Resource(name="productService")
	ProductService productService;
	//还是要用到
	@Resource(name="categoryService")
	CategoryService categoryService;
	@Autowired
	IStaticPageService staticPageService;
	@RequestMapping("/find")
	public ModelAndView findProduct(PageBean pageBean) {
		if (pageBean.getPageIndex() == null || pageBean.getPageIndex() == 0) {
			pageBean.setPageIndex(1);
		}
		if (pageBean.getPageSize() == null || pageBean.getPageSize() == 0) {
			pageBean.setPageSize(3);
		}
		if (pageBean.getProduct() != null && pageBean.getProduct().getCategory_id() == 0) {
			pageBean.getProduct().setCategory_id(null);
		}
		Integer pageIndex = pageBean.getPageIndex();
		Integer pageSize  = pageBean.getPageSize();
		pageBean.setLimitStart((pageIndex - 1) * pageSize);
		ModelAndView modelAndView = new ModelAndView();
		pageBean= productService.findProduct(pageBean);
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		modelAndView.addObject("rootCategoriesList", rootCategoriesList);
		modelAndView.addObject(pageBean);
		modelAndView.setViewName("product_find");
		return modelAndView;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public boolean addProduct(Product product) {
		System.out.println(product);
		if ((product.getName() == null || "".equals(product.getName().trim()) || product.getName().length()>40) || 
				(product.getPrice() <= 0)) {
			return false;
		}
		return productService.addProduct(product);
	}
	@RequestMapping("/goadd")
	public ModelAndView goAddProduct() {
		ModelAndView modelAndView = new ModelAndView();
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		modelAndView.addObject("rootCategoriesList", rootCategoriesList);
		modelAndView.setViewName("product_add");
		return modelAndView;
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public boolean deleteProduct(Integer id) {
		return productService.deleteProduct(id);
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	public boolean modifyProduct(Product product) {
		return productService.modifyProduct(product);
	}
	@RequestMapping("/goModify")
	public ModelAndView goModifyProduct(Integer id) {
		ModelAndView modelAndView = new ModelAndView();
		if (id != null) {
			Product thisProduct = productService.findProductById(id);
			modelAndView.addObject("product",thisProduct);
			String[] sub_images = thisProduct.getSub_images().split(",");
			modelAndView.addObject("sub_images",sub_images);
		}
		modelAndView.setViewName("product_modify");
		return modelAndView;
	}
	
	@RequestMapping("/tostatic")
	@ResponseBody
	public Boolean toStatic(Integer product_id) {
		Product product = productService.findProductById(product_id);
		Map<String, Object> map = new HashMap<>();
		map.put("product", product);
		String[] sub_images = product.getSub_images().split(",");
		map.put("sub_images", sub_images);
		staticPageService.productIndex(map, product_id);
		return true;
	}
}
