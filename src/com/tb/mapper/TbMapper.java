package com.tb.mapper;

import java.util.List;
import java.util.Map;

import com.tb.pojo.TbComment;
import com.tb.pojo.TbTw;

public interface TbMapper {
	//发送贴文
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
	public int doComment(TbComment tc);
	//查看某贴吧中的所有评论 包括评论中的评论   int tw_id,int incomment_id
	public List<TbComment> show_allComment(Map map);//incomment_id为null则得到评论 不为null则得到评论中的评论
	//刪除评论
	public boolean delComment(int comment_id);
	
}
