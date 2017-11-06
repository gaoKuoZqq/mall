package com.mall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mall.dao.CategoryDao;
import com.mall.dto.PageBean;
import com.mall.pojo.Category;
import com.mall.service.CategoryService;
@Service("categoryService")
public class CategoryServiceImpl implements CategoryService{
	@Resource(name="categoryDao")
	CategoryDao categoryDao;
	@Override
	public PageBean findCategory(PageBean pageBean) {
		
		Integer totalCategories = categoryDao.totalCategories(pageBean);
		Integer totalPage = (int) Math.ceil(1.0*totalCategories/pageBean.getPageSize());
		//避免出现页码超范围
		if (totalPage < pageBean.getPageIndex()) {
			pageBean.setPageIndex(totalPage);
			if (totalPage > 0) {
				pageBean.setLimitStart((totalPage - 1) * pageBean.getPageSize());
			}else {
				pageBean.setLimitStart(0);
			}
			
		}
		List<Category> categoriesList = categoryDao.findCategory(pageBean);
		
		pageBean.setObjList(categoriesList);
		pageBean.setTotalObj(totalCategories);
		pageBean.setTotalPage(totalPage);
		return pageBean;
	}
	@Override
	public List<Category> findRootCategory() {
		return categoryDao.findRootCategory();
	}
	
	public boolean deleteCategory(Integer category_id){
		return categoryDao.deleteCategory(category_id) > 0;
	}
	
	@Override
	public boolean modifyCategory(Category category) {
		return categoryDao.modifyCategory(category) > 0;
	}
	@Override
	public boolean addCategory(Category category) {
		return categoryDao.addCategory(category) > 0;
	}
	@Override
	public List<Category> findCategoryByParent_id(Integer parent_id) {
		return categoryDao.findCategoryByParent_id(parent_id);
	}
}
