package com.tb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.tb.pojo.TbMsg;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUser;
import com.tb.pojo.TbUserAttention;

public interface UserService {
	// ��¼��֤
	public TbUser loginAuthentication(TbUser tu);

	// ע��
	public boolean doRegister(TbUser tu);

	// �޸ĸ�����Ϣ
	public boolean updPerson(Map map);

	// ���������û�
	public List<TbUser> searchAllUser();

	// ͨ��user_id����������
	public TbUser findUserNameById(int user_id);

	// �õ���д������
	public List<TbTw> get_my_tw(String user_name);

	// �ж��Ƿ��Ѿ���ע������
	public TbUserAttention isAttention(String user1_name, String user2_name);

	// ��ע��ȡ����ע����
	public String functionAttention(String user1_name, String user2_name);

	// ����ҳ����ȡ����ע����
	public Map person_cancelAttention(String user1_name, String user2_name);

	// ��ȡ�ҹ�ע���������ߺ��ҵ����з�˿ choose=1 ����user_name�ķ�˿ choose=2 ����user_name�Ĺ�ע
	public List<TbUserAttention> gainMyAttentionsOrFans(String choose, String user_name);

	// ���comment_id
	public Integer getComment_id(String user_name);

	// ������Ϣ��ʾ�����ݿ���
	public boolean existMsg(Map map);

	// �õ��ҵ�������Ϣ
	public List<TbMsg> getAllMsg(String user1_name);

	public boolean delMsg(int tb_msg);
}
