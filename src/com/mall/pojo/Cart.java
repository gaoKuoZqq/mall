package com.mall.pojo;

import java.sql.Date;
/**本类与数据库并非对应关系,因为展示需要,添加了product对象
 * 
 * @author 6
 *
 */
public class Cart {
	public Integer id;
	public Integer user_id;
	public Integer product_id;
	public Integer quantity;
	public Integer checked;//1=已勾选,0=未勾选
	//这里我直接使用了java.sql的Date,构造方法有改动,添加了俩set
	public Date create_time;
	public Date update_time;
	public Product product;
	public Product getProduct() {
		return product;
	}
	public Cart(Integer id, Integer quantity, Product product) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.product = product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Cart() {
		super();
	}
	public Cart(Integer id, Integer user_id, Integer product_id, Integer quantity, Integer checked, java.util.Date create_time,
			java.util.Date update_time) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.checked = checked;
		this.create_time = new Date(create_time.getTime());
		this.update_time = new Date(update_time.getTime());
	}
	public Cart(Integer id, Integer user_id, Integer product_id, Integer quantity, Integer checked) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.checked = checked;
	}
	public Cart(Integer user_id, Integer product_id, Integer quantity, Integer checked) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.checked = checked;
	}
	public Cart(Integer user_id, Integer product_id, Integer quantity, Integer checked, java.util.Date create_time,
			java.util.Date update_time) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.checked = checked;
		this.create_time = new Date(create_time.getTime());
		this.update_time = new Date(update_time.getTime());
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getProduct_id() {
		return product_id;
	}
	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getChecked() {
		return checked;
	}
	public void setChecked(Integer checked) {
		this.checked = checked;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	//写一个用来设置时间的方法,是俩
	public void setCreate_time_javaUtil(java.util.Date create_time) {
		this.create_time = new java.sql.Date(create_time.getTime());
	}
	public void setUpdate_time_javaUtil(java.util.Date update_time) {
		this.update_time = new java.sql.Date(update_time.getTime());
	}
	
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	@Override
	public String toString() {
		return "Cart [id=" + id + ", user_id=" + user_id + ", product_id=" + product_id + ", quantity=" + quantity
				+ ", checked=" + checked + ", create_time=" + create_time + ", update_time=" + update_time + "]";
	}
	
}
