package com.tb.mapper;

import java.util.List;
import java.util.Map;

import com.tb.pojo.TbMsg;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUser;
import com.tb.pojo.TbUserAttention;

public interface UserMapper {
	//��¼��֤
	public TbUser loginAuthentication(TbUser tu);
	//ע��
	public boolean doRegister(TbUser tu);
	//�޸ĸ�����Ϣ
	public boolean updPerson(Map map);
	//���������û�
	public List<TbUser> searchAllUser();
	//ͨ��user_id����������
	public TbUser findUserNameById(int user_id);
	//�õ���д������
	public List<TbTw> get_my_tw(String user_name);
	//�ж��Ƿ��Ѿ���ע������
	public TbUserAttention isAttention(TbUserAttention tua);
	//��ע����
	public boolean doAttention(TbUserAttention tua);
	//ȡ����ע����
	public boolean cancelAttention(TbUserAttention tua);
	//��ȡ�ҹ�ע���������ߺ��ҵ����з�˿
	public List<TbUserAttention> gainMyAttentionsOrFans(Map map);
	//���comment_id
	public Integer getComment_id(String user_name);
	//�жϵ�ǰ�û����Ƿ��Ѵ������ݿ���
	public int ifExistByUserName(String user_name);
	//������Ϣ��ʾ�����ݿ���
	public boolean existMsg(Map map);
	//�õ��ҵ�������Ϣ
	public List<TbMsg> getAllMsg(String user1_name);
	//ɾ����Ϣ
	public boolean delMsg(int tb_msg);
	
}
