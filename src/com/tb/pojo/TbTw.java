package com.tb.pojo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.mysql.jdbc.Blob;

public class TbTw {
	private int tw_id;
	private String user_name;
	private String tw_title;
	private String tw_article;
	private String tw_img;
	private String tw_sort;
	private Date tw_time;

	public int getTw_id() {
		return tw_id;
	}

	public void setTw_id(int tw_id) {
		this.tw_id = tw_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getTw_title() {
		return tw_title;
	}

	public void setTw_title(String tw_title) {
		this.tw_title = tw_title;
	}

	public String getTw_article() {
		return tw_article;
	}

	public void setTw_article(String tw_article) {
		this.tw_article = tw_article;
	}

	public String getTw_img() {
		return tw_img;
	}

	public void setTw_img(String tw_img) {
		this.tw_img = tw_img;
	}

	public String getTw_sort() {
		return tw_sort;
	}

	public void setTw_sort(String tw_sort) {
		this.tw_sort = tw_sort;
	}

	public Date getTw_time() {
		return tw_time;
	}

	public void setTw_time(Date tw_time) {
		this.tw_time = tw_time;
	}

}
