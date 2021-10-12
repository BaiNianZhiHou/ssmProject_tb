package com.tb.mapper;

import java.util.List;
import java.util.Map;

import com.tb.pojo.TbMsg;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUser;
import com.tb.pojo.TbUserAttention;

public interface UserMapper {
	//登录验证
	public TbUser loginAuthentication(TbUser tu);
	//注册
	public boolean doRegister(TbUser tu);
	//修改个人信息
	public boolean updPerson(Map map);
	//查找所有用户
	public List<TbUser> searchAllUser();
	//通过user_id查找作者名
	public TbUser findUserNameById(int user_id);
	//得到我写的贴文
	public List<TbTw> get_my_tw(String user_name);
	//判断是否已经关注该作者
	public TbUserAttention isAttention(TbUserAttention tua);
	//关注作者
	public boolean doAttention(TbUserAttention tua);
	//取消关注作者
	public boolean cancelAttention(TbUserAttention tua);
	//获取我关注的所有作者和我的所有粉丝
	public List<TbUserAttention> gainMyAttentionsOrFans(Map map);
	//获得comment_id
	public Integer getComment_id(String user_name);
	//判断当前用户名是否已存在数据库中
	public int ifExistByUserName(String user_name);
	//保存消息提示到数据库中
	public boolean existMsg(Map map);
	//得到我的所有消息
	public List<TbMsg> getAllMsg(String user1_name);
	//删除消息
	public boolean delMsg(int tb_msg);
	
}
