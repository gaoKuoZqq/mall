package com.mall.service;

import java.util.List;

import com.mall.dto.PageBean;
import com.mall.pojo.Product;

public interface ProductService {
	public PageBean findProduct(PageBean pageBean);
	
	public boolean deleteProduct(Integer product_id);
	
	public boolean modifyProduct(Product product);
	
	public boolean addProduct(Product product);
	
	//前台调用的方法
	public List<Product> findProductByCategoryId(Integer category_id);
	
	public Product findProductById(Integer product_id);
	
	public PageBean findProductByCategoryIdAndName(PageBean pageBean);
	
	Boolean modifyProductStock(Product product);
}
