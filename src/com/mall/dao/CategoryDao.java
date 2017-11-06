package com.mall.dao;

import java.util.List;

import com.mall.dto.PageBean;
import com.mall.pojo.Category;

public interface CategoryDao {
	List<Category> findCategory(PageBean pageBean);
	
	Integer totalCategories(PageBean pageBean);
	
	List<Category> findRootCategory();
	
	Integer deleteCategory(Integer category_id);
	
	Integer modifyCategory(Category category);
	
	Integer addCategory(Category category);
	
	List<Category> findCategoryByParent_id(Integer parent_id);
}