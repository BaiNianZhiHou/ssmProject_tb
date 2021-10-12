package com.tb.pojo;

import java.util.Date;

public class TbComment {
	private int comment_id;
	private int tw_id;
	private Integer incomment_id;
	private String user_name;
	private String comment_context;
	private Date comment_time;
	private String str_commentTime;
	
	
	public String getStr_commentTime() {
		return str_commentTime;
	}
	public void setStr_commentTime(String str_commentTime) {
		this.str_commentTime = str_commentTime;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getTw_id() {
		return tw_id;
	}
	public void setTw_id(int tw_id) {
		this.tw_id = tw_id;
	}
	public Integer getIncomment_id() {
		return incomment_id;
	}
	public void setIncomment_id(Integer incomment_id) {
		this.incomment_id = incomment_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getComment_context() {
		return comment_context;
	}
	public void setComment_context(String comment_context) {
		this.comment_context = comment_context;
	}
	public Date getComment_time() {
		return comment_time;
	}
	public void setComment_time(Date comment_time) {
		this.comment_time = comment_time;
	}
}
