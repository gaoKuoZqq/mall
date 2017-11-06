package com.mall.front.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mall.pojo.Carousel;
import com.mall.pojo.Category;
import com.mall.pojo.Product;
import com.mall.service.CarouselService;
import com.mall.service.CategoryService;
import com.mall.service.ProductService;

@Controller
@RequestMapping("/home")
public class HomeController {
	@Resource(name="productService")
	ProductService productService;
	
	@Resource(name="categoryService")
	CategoryService categoryService;
	
	@Resource(name="carouselService")
	CarouselService carouselService;
	
	@RequestMapping("gohome")
	public ModelAndView goHome() {
		ModelAndView modelAndView = new ModelAndView();
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		List<Carousel> carouselsList = carouselService.findCarousel();
		modelAndView.addObject("carouselsList",carouselsList);
		modelAndView.addObject("rootCategoriesList",rootCategoriesList);
		modelAndView.setViewName("home");
		return modelAndView;
	}
	
	@RequestMapping("findcategory")
	@ResponseBody
	public List<Category> findCategoryByParent_id(Integer parent_id) {
		List<Category> categoriesList = categoryService.findCategoryByParent_id(parent_id);
		return categoriesList;
	}
	
	@RequestMapping("findproductbycategoryid")
	public ModelAndView findProductByCategoryId(Integer category_id) {
		ModelAndView modelAndView = new ModelAndView();
		List<Product> productsList = productService.findProductByCategoryId(category_id);
		modelAndView.addObject("productsList",productsList);
		modelAndView.setViewName("product_search");
		return modelAndView;
	}
}
