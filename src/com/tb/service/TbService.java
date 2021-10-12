package com.tb.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import com.tb.pojo.TbComment;
import com.tb.pojo.TbTw;

public interface TbService {
	//����
	public boolean send_tb(TbTw tt);
	//�鿴��������
	public List<TbTw> showAllTw();
	//�鿴���ģ����ࣩ
	public List<TbTw> showSortTw(String tw_sort);
	//�鿴��������
	public TbTw showDetailTw(int tw_id);
	//ɾ���ҵ�����
	public boolean delTbTw(int tw_id);
	//��������
	public Integer doComment(TbComment tc);
	//�鿴ĳ�����е��������� ���������е�����   
	public Map show_allComment(int tw_id,String writer,String user_name,int showCommentPage);
	//ɾ������
	public boolean delComment(int comment_id);
	//��Ϣ��ʾ
	
}
