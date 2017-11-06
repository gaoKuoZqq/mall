package com.mall.back.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mall.dto.PageBean;
import com.mall.pojo.Category;
import com.mall.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	@Resource(name="categoryService")
	CategoryService categoryService;
	@RequestMapping("/find")
	public ModelAndView findCategory(PageBean pageBean){
		
		if (pageBean.getPageIndex() == null || pageBean.getPageIndex() == 0) {
			pageBean.setPageIndex(1);
		}
		if (pageBean.getPageSize() == null || pageBean.getPageSize() == 0) {
			pageBean.setPageSize(4);
		}
		
		Integer pageIndex = pageBean.getPageIndex();
		Integer pageSize  = pageBean.getPageSize();
		pageBean.setLimitStart((pageIndex - 1) * pageSize);
		ModelAndView modelAndView = new ModelAndView();
		pageBean= categoryService.findCategory(pageBean);
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		modelAndView.addObject("rootCategoriesList", rootCategoriesList);
		modelAndView.addObject(pageBean);
		modelAndView.setViewName("category_find");
		return modelAndView;
	}
	/*@RequestMapping("/findroot")
	public ModelAndView findRootCategory(){
		ModelAndView modelAndView = new ModelAndView();
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		modelAndView.addObject(rootCategoriesList);
		modelAndView.setViewName("category_find");
		return modelAndView;
	}*/
	@RequestMapping("/del")
	@ResponseBody
	public boolean deleteCategory(Integer id) {
		return categoryService.deleteCategory(id);
	}
	
	@RequestMapping("/modify")
	@ResponseBody
	public boolean modifyCategory(Category category) {
		return categoryService.modifyCategory(category);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public boolean addCategory(Category category) {
		if (category.getName() == null || 
				category.getName().trim().equals("") ||
				category.getName().trim().length() > 6 || 
				(category.getSort_order() != null && category.getSort_order()>999)) {
			return false;
		}
		return categoryService.addCategory(category);
	}
	@RequestMapping("/goadd")
	public ModelAndView goAddCategory() {
		ModelAndView modelAndView = new ModelAndView();
		List<Category> rootCategoriesList = categoryService.findRootCategory();
		modelAndView.addObject("rootCategoriesList", rootCategoriesList);
		modelAndView.setViewName("category_add");
		return modelAndView;
	}
	@RequestMapping("/findCategoryByParent_id")
	@ResponseBody
	public List<Category> findCategoryByParent_id (Integer parent_id) {
		return categoryService.findCategoryByParent_id(parent_id);
	}
}
