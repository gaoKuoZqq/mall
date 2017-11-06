package com.mall.pojo;

import java.sql.Date;

public class User {
	Integer id;
	String username;
	String password;
	String email;
	String phone;
	String Question;
	String answer;
	Integer role;//角色0-管理员,1-普通用户
	//这里我直接使用了java.sql的Date,构造方法有改动,添加了java.util.Date的set
	Date create_time;
	Date update_time;
	public User() {
		super();
	}
	public User(Integer id, String username, String password, String email, String phone, String question,
			String answer, Integer role, java.util.Date create_time, java.util.Date update_time) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone = phone;
		Question = question;
		this.answer = answer;
		this.role = role;
		this.create_time = new Date(create_time.getTime());
		this.update_time = new Date(update_time.getTime());
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getQuestion() {
		return Question;
	}
	public void setQuestion(String question) {
		Question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Integer getRole() {
		return role;
	}
	public void setRole(Integer role) {
		this.role = role;
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
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", phone="
				+ phone + ", Question=" + Question + ", answer=" + answer + ", role=" + role + ", create_time="
				+ create_time + ", update_time=" + update_time + "]";
	}
	//写一个用来设置时间的方法,是俩
	public void setCreate_time_javaUtil(java.util.Date create_time) {
		this.create_time = new java.sql.Date(create_time.getTime());
	}
	public void setUpdate_time_javaUtil(java.util.Date update_time) {
		this.update_time = new java.sql.Date(update_time.getTime());
	}
}
