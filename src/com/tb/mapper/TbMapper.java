package com.tb.mapper;

import java.util.List;
import java.util.Map;

import com.tb.pojo.TbComment;
import com.tb.pojo.TbTw;

public interface TbMapper {
	//��������
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
	public int doComment(TbComment tc);
	//�鿴ĳ�����е��������� ���������е�����   int tw_id,int incomment_id
	public List<TbComment> show_allComment(Map map);//incomment_idΪnull��õ����� ��Ϊnull��õ������е�����
	//�h������
	public boolean delComment(int comment_id);
	
}
