package com.tb.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.tb.pojo.TbComment;
import com.tb.pojo.TbTw;

public interface TbService {
	//发帖
	public boolean send_tb(TbTw tt);
	//查看所有贴文
	public List<TbTw> showAllTw();
	//查看贴文（分类）
	public List<TbTw> showSortTw(String tw_sort);
	//查看贴文详情
	public TbTw showDetailTw(int tw_id);
	//删除我的贴文
	public boolean delTbTw(int tw_id);
	//发表评论
	public Integer doComment(TbComment tc);
	//查看某贴吧中的所有评论 包括评论中的评论   
	public Map show_allComment(int tw_id,String writer,String user_name,int showCommentPage);
	//删除评论
	public boolean delComment(int comment_id);
	//消息提示
	
}
