package com.mall.pojo;

import java.sql.Date;

public class Carousel {
	Integer id;
	String name;
	Integer product_id;
	Integer sort_order;
	Date create_time;
	Date update_time;
	public Carousel() {
		super();
	}
	public Carousel(Integer id, String name, Integer product_id, Integer sort_order, java.util.Date create_time,
			java.util.Date update_time) {
		super();
		this.id = id;
		this.name = name;
		this.product_id = product_id;
		this.sort_order = sort_order;
		this.create_time = new Date(create_time.getTime());
		this.update_time = new Date(update_time.getTime());
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getProduct_id() {
		return product_id;
	}
	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}
	public Integer getSort_order() {
		return sort_order;
	}
	public void setSort_order(Integer sort_order) {
		this.sort_order = sort_order;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	//写一个用来设置时间的方法,是俩
		public void setCreate_time_javaUtil(java.util.Date create_time) {
			this.create_time = new java.sql.Date(create_time.getTime());
		}
		public void setUpdate_time_javaUtil(java.util.Date update_time) {
			this.update_time = new java.sql.Date(update_time.getTime());
		}
		@Override
		public String toString() {
			return "Carousel [id=" + id + ", name=" + name + ", product_id=" + product_id + ", sort_order=" + sort_order
					+ ", create_time=" + create_time + ", update_time=" + update_time + "]";
		}
		
	
}
