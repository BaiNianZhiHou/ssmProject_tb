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

		// 创建TbUserAttention对象，并将要查询的user_name放入
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		TbUserAttention ta = this.userMapper.isAttention(tua);

		return ta;
	}

	@Override
	public String functionAttention(String user1_name, String user2_name) {
		boolean flag_doAttention = false;// 判断关注或取消关注功能是否执行正常
		String message = "未关注|-1";// 若已关注则为true 若未关注则为false

		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		// 创建TbUserAttention对象，并将要查询的user_name放入
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		TbUserAttention ta = this.userMapper.isAttention(tua);// 判断是否已关注该作者

		// 判断是执行关注还是取消关注的操作
		if (ta == null) {// 说明未关注该作者 执行关注
			flag_doAttention = this.userMapper.doAttention(tua);

			if (flag_doAttention) {
				
				int attention_id = tua.getAttention_id();//获得新插入数据库的数据id
				message = "已关注|"+attention_id;//拼接attention_id，便于之后的业务操作
			} else {
				System.out.println("关注执行失败");
			}

		} else {// 说明已关注该作者 执行取消关注
			flag_doAttention = this.userMapper.cancelAttention(tua);

			if (flag_doAttention) {
				message = "未关注|-1";
			} else {
				System.out.println("取消关注执行失败");
			}
		}

		return message;
	}

	@Override
	public List<TbUserAttention> gainMyAttentionsOrFans(String choose, String user_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		Map map = new TreeMap<>();

		map.put("choose", choose);// choose为1表示获取我关注的作者列表 为2表示获取我的粉丝列表
		map.put("user_name", user_name);

		List<TbUserAttention> list = this.userMapper.gainMyAttentionsOrFans(map);// 获取到我所有关注的人或者我所有的粉丝

		return list;
	}

	@Override
	public Map person_cancelAttention(String user1_name, String user2_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		// 创建TbUserAttention对象，并将要查询的user_name放入
		TbUserAttention tua = new TbUserAttention();
		tua.setUser1_name(user1_name);
		tua.setUser2_name(user2_name);

		this.userMapper.cancelAttention(tua);// 取消关注

		Map map = new TreeMap<>();
		map.put("choose", 1);// choose为1表示获取我关注的作者列表
		map.put("user_name", user1_name);

		List<TbUserAttention> list = this.userMapper.gainMyAttentionsOrFans(map);// 获取当前我关注的所有作者

		String table_myAttentions = "<table class='table table-hover' align='center'><tr><th style='text-align: center'>用户名</th><th></th><th></th></tr>";

		for (int i = 0; i < list.size(); i++) {
			user1_name = list.get(i).getUser1_name();// 得到执行关注的对象的用户名
			user2_name = list.get(i).getUser2_name();// 得到我关注的用户的用户名

			table_myAttentions = table_myAttentions + "<tr>" + "<th style='text-align: center'>" + user2_name + "</th>"
					+ "<th style='text-align: center'><a href='javascript:personal(\"" + user2_name
					+ "\")';>查看主页</a></th>"
					+ "<th style='text-align: center'><a href='javascript:person_cancelAttention(\"" + user1_name
					+ "\",\"" + user2_name + "\")'>取消关注</a></th>" + "</tr>";
		}

		table_myAttentions = table_myAttentions + "</table>";

		map.clear();

		map.put("table_myAttentions", table_myAttentions);// 要写入table中的数据(所有我关注的人的列表)
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
			System.out.println("注册失败");
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

		flag = this.userMapper.updPerson(map);// 更新个人信息

		return flag;
	}

	@Override
	public boolean existMsg(Map map) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		boolean flag = false;

		flag = this.userMapper.existMsg(map);// 保存消息提醒到数据库中

		return flag;
	}

	@Override
	public List<TbMsg> getAllMsg(String user1_name) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.userMapper = (UserMapper) this.context.getBean("userMapper");

		List<TbMsg> myAllMsg = this.userMapper.getAllMsg(user1_name);// 从数据库中得到我的所有消息

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
