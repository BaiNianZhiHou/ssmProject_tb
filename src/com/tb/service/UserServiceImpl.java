package com.tb.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.tb.mapper.UserMapper;
import com.tb.pojo.TbMsg;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUser;
import com.tb.pojo.TbUserAttention;

@Service
public class UserServiceImpl implements UserService {
	private ClassPathXmlApplicationContext context;
	private UserMapper userMapper;

	@Override
	public TbUser loginAuthentication(TbUser tu) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		TbUser tu1 = userMapper.loginAuthentication(tu);

		return tu1;
	}

	@Override
	public TbUser findUserNameById(int user_id) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		TbUser tu1 = userMapper.findUserNameById(user_id);

		return tu1;
	}

	@Override
	public List<TbTw> get_my_tw(String user_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		List<TbTw> my_tbtw_list = this.userMapper.get_my_tw(user_name);

		return my_tbtw_list;
	}

	@Override
	public TbUserAttention isAttention(String user1_name, String user2_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		// Map map = new TreeMap<>();
		//
		// map.put("user1_name", user1_name);
		// map.put("user2_name", user2_name);

		// ����TbUserAttention���󣬲���Ҫ��ѯ��user_name����
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		TbUserAttention ta = this.userMapper.isAttention(tua);

		return ta;
	}

	@Override
	public String functionAttention(String user1_name, String user2_name) {
		boolean flag_doAttention = false;// �жϹ�ע��ȡ����ע�����Ƿ�ִ������
		String message = "δ��ע|-1";// ���ѹ�ע��Ϊtrue ��δ��ע��Ϊfalse

		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		// ����TbUserAttention���󣬲���Ҫ��ѯ��user_name����
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		TbUserAttention ta = this.userMapper.isAttention(tua);// �ж��Ƿ��ѹ�ע������

		// �ж���ִ�й�ע����ȡ����ע�Ĳ���
		if (ta == null) {// ˵��δ��ע������ ִ�й�ע
			flag_doAttention = this.userMapper.doAttention(tua);

			if (flag_doAttention) {
				
				int attention_id = tua.getAttention_id();//����²������ݿ������id
				message = "�ѹ�ע|"+attention_id;//ƴ��attention_id������֮���ҵ�����
			} else {
				System.out.println("��עִ��ʧ��");
			}

		} else {// ˵���ѹ�ע������ ִ��ȡ����ע
			flag_doAttention = this.userMapper.cancelAttention(tua);

			if (flag_doAttention) {
				message = "δ��ע|-1";
			} else {
				System.out.println("ȡ����עִ��ʧ��");
			}
		}

		return message;
	}

	@Override
	public List<TbUserAttention> gainMyAttentionsOrFans(String choose, String user_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		Map map = new TreeMap<>();

		map.put("choose", choose);// chooseΪ1��ʾ��ȡ�ҹ�ע�������б� Ϊ2��ʾ��ȡ�ҵķ�˿�б�
		map.put("user_name", user_name);

		List<TbUserAttention> list = this.userMapper.gainMyAttentionsOrFans(map);// ��ȡ�������й�ע���˻��������еķ�˿

		return list;
	}

	@Override
	public Map person_cancelAttention(String user1_name, String user2_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		// ����TbUserAttention���󣬲���Ҫ��ѯ��user_name����
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		this.userMapper.cancelAttention(tua);// ȡ����ע

		Map map = new TreeMap<>();
		map.put("choose", 1);// chooseΪ1��ʾ��ȡ�ҹ�ע�������б�
		map.put("user_name", user1_name);

		List<TbUserAttention> list = this.userMapper.gainMyAttentionsOrFans(map);// ��ȡ��ǰ�ҹ�ע����������

		String table_myAttentions = "<table class='table table-hover' align='center'><tr><th style='text-align: center'>�û���</th><th></th><th></th></tr>";

		for (int i = 0; i < list.size(); i++) {
			user1_name = list.get(i).getUser1_name();// �õ�ִ�й�ע�Ķ�����û���
			user2_name = list.get(i).getUser2_name();// �õ��ҹ�ע���û����û���

			table_myAttentions = table_myAttentions + "<tr>" + "<th style='text-align: center'>" + user2_name + "</th>"
					+ "<th style='text-align: center'><a href='javascript:personal(\"" + user2_name
					+ "\")';>�鿴��ҳ</a></th>"
					+ "<th style='text-align: center'><a href='javascript:person_cancelAttention(\"" + user1_name
					+ "\",\"" + user2_name + "\")'>ȡ����ע</a></th>" + "</tr>";
		}

		table_myAttentions = table_myAttentions + "</table>";

		map.clear();

		map.put("table_myAttentions", table_myAttentions);// Ҫд��table�е�����(�����ҹ�ע���˵��б�)
		map.put("count_myAttention", list.size());

		return map;
	}

	@Override
	public boolean doRegister(TbUser tu) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		boolean flag = false;

		try {
			flag = this.userMapper.doRegister(tu);
		} catch (Exception e) {
			System.out.println("ע��ʧ��");
		}

		return flag;
	}

	@Override
	public List<TbUser> searchAllUser() {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		return this.userMapper.searchAllUser();
	}

	@Override
	public Integer getComment_id(String user_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		return this.userMapper.getComment_id(user_name);
	}

	@Override
	public boolean updPerson(Map map) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		boolean flag = false;

		flag = this.userMapper.updPerson(map);// ���¸�����Ϣ

		return flag;
	}

	@Override
	public boolean existMsg(Map map) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		boolean flag = false;

		flag = this.userMapper.existMsg(map);// ������Ϣ���ѵ����ݿ���

		return flag;
	}

	@Override
	public List<TbMsg> getAllMsg(String user1_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		List<TbMsg> myAllMsg = this.userMapper.getAllMsg(user1_name);// �����ݿ��еõ��ҵ�������Ϣ

		return myAllMsg;
	}

	@Override
	public boolean delMsg(int tb_msg) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		boolean flag = this.userMapper.delMsg(tb_msg);

		return flag;
	}
}
