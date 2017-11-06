package com.mall.dao;

import java.util.List;

import com.mall.dto.PageBean;
import com.mall.pojo.Product;;

public interface ProductDao {
	List<Product> findProduct(PageBean pageBean);
	
	Integer totalProduct(PageBean pageBean);
	
	Integer deleteProduct(Integer product_id);
	
	Integer modifyProduct(Product product);
	
	Integer addProduct(Product product);
	
	Product findProductById(Integer product_id);
	
	List<Product> findProductByCategoryId(Integer category_id);
	
	List<Product> findProductByCategoryIdAndName(PageBean pageBean);
	
	Integer totalProductByCategoryIdAndName(PageBean pageBean);
	
	Integer modifyProductStock(Product product);
}
