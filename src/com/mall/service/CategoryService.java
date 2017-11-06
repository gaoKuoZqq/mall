package com.mall.service;

import java.util.List;

import com.mall.dto.PageBean;
import com.mall.pojo.Category;

public interface CategoryService {
	public PageBean findCategory(PageBean pageBean);
	
	public List<Category> findRootCategory();
	
	public boolean deleteCategory(Integer category_id);
	
	public boolean modifyCategory(Category category);
	
	public boolean addCategory(Category category);
	
	public List<Category> findCategoryByParent_id (Integer parent_id);
}
