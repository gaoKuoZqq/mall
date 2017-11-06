package com.mall.pojo;

import java.sql.Date;
//类别
public class Category {
	public Integer id;
	public Integer parent_id;//父类id,id=0着无父类
	public String name;
	public Integer status;//类别状态1-正常,2-已废弃
	public Integer sort_order;//排序编号,同类展示顺序,数值相等则自然排序
	public Category(Integer parent_id, String name, Integer status, Integer sort_order) {
		super();
		this.parent_id = parent_id;
		this.name = name;
		this.status = status;
		this.sort_order = sort_order;
	}
	public Category(Date create_time, Date update_time) {
		super();
		this.create_time = create_time;
		this.update_time = update_time;
	}
	public Category(Integer id, Integer parent_id, String name, Integer status, Integer sort_order) {
		super();
		this.id = id;
		this.parent_id = parent_id;
		this.name = name;
		this.status = status;
		this.sort_order = sort_order;
	}
	//这里我直接使用了java.sql的Date,构造方法有改动,添加了俩set
	public Date create_time;
	public Date update_time;
	public Category() {
		super();
	}
	public Category(Integer id, Integer parent_id, String name, Integer status, Integer sort_order, java.util.Date create_time,
			java.util.Date update_time) {
		super();
		this.id = id;
		this.parent_id = parent_id;
		this.name = name;
		this.status = status;
		this.sort_order = sort_order;
		this.create_time = new Date(create_time.getTime());
		this.update_time = new Date(update_time.getTime());
	}
	public Category(Integer parent_id, String name, Integer status, Integer sort_order, java.util.Date create_time,
			java.util.Date update_time) {
		super();
		this.parent_id = parent_id;
		this.name = name;
		this.status = status;
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
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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
	//写一个用来设置时间的方法,是俩
	public void setCreate_time_javaUtil(java.util.Date create_time) {
		this.create_time = new java.sql.Date(create_time.getTime());
	}
	public void setUpdate_time_javaUtil(java.util.Date update_time) {
		this.update_time = new java.sql.Date(update_time.getTime());
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
	@Override
	public String toString() {
		return "Category [id=" + id + ", parent_id=" + parent_id + ", name=" + name + ", status=" + status
				+ ", sort_order=" + sort_order + ", create_time=" + create_time + ", update_time=" + update_time + "]";
	}
	
}
