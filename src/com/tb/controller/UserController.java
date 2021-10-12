package com.tb.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.websocket.EndpointConfig;
import javax.websocket.Session;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tb.pojo.TbTw;
import com.tb.pojo.TbUser;
import com.tb.pojo.TbUserAttention;
import com.tb.service.TbService;
import com.tb.service.TbServiceImpl;
import com.tb.service.UserService;
import com.tb.service.UserServiceImpl;

@Controller
public class UserController {
	private UserService usc;
	private TbService ts;

	// 进入登录页面
	@RequestMapping("/login")
	public String intoLoginJsp() {
		return "login";
	}

	// 登录验证
	@RequestMapping("/loginAuthentication")
	@ResponseBody
	public String loginAuthentication(String user_name, String user_pwd, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		ServletContext sct = request.getSession().getServletContext();// 获得服务器共享的空间（里面存有session等信息）

		TbUser tu = new TbUser();
		tu.setUser_name(user_name);
		tu.setUser_pwd(user_pwd);
		usc = new UserServiceImpl();

		TbUser tu1 = usc.loginAuthentication(tu);

		if (tu1 != null) {// tu1存在数据 则说明数据库中存在该用户，且输入的密码正确 可以正常登录
			HttpSession session = request.getSession(true);// 设置session
			session.setAttribute("user_name", tu1.getUser_name());// 在session中存放当前登录用户的用户名
			session.setAttribute("user_id", tu1.getUser_id());// 在session中存放用户的唯一表示：user_id
			session.setAttribute("tbuser", tu);// 放置当前登录的用户的所有信息

			ts = new TbServiceImpl();

			List<TbTw> allTw = ts.showAllTw();// 获取所有贴吧

			session.setAttribute("countTw", allTw.size());// 设置当前所有贴文的数量

			// // 统计在线人数
			// Integer numSessions = (Integer) sct.getAttribute("numSessions");
			//
			// if (numSessions == null || numSessions == 0) {// 判断是否已经有人在线
			// sct.setAttribute("numSessions", 1);
			// } else {
			// numSessions++;// 若有人在线则在当前在线人数的基础上+1
			// sct.setAttribute("numSessions", numSessions);
			// }
			return "true";
		}

		return "false";
	}

	// 退出贴吧
	@RequestMapping("/quitLogin")
	public String quitLogin(HttpServletRequest request) {
		String user_name = (String) request.getSession().getAttribute("user_name");

		ServletContext sct = request.getSession().getServletContext();
		// Integer numSessions = (Integer) sct.getAttribute("numSessions");

		// if (numSessions == null) {
		// sct.setAttribute("numSessions", 0);
		// } else {
		// numSessions--;
		// sct.setAttribute("numSessions", numSessions);

		// }

		return "login";
	}

	// 执行注册
	@RequestMapping("/doRegister")
	public @ResponseBody String doRegister(String user_name, String user_pwd, String user_sex) {
		// 字段不能为空
		if (user_name == "" || user_name == null) {
			return "注册失败，用户名不能为空,请重新输入";
		}

		if (user_pwd == "" || user_pwd == null) {
			return "注册失败，密码不能为空,请重新输入";
		}

		if (user_sex == "" || user_sex == null) {
			return "注册失败，性别不能为空,请重新输入";
		}

		TbUser tu = new TbUser();
		tu.setUser_name(user_name);
		tu.setUser_pwd(user_pwd);
		tu.setUser_sex(user_sex);

		usc = new UserServiceImpl();

		boolean flag = usc.doRegister(tu);

		if (flag) {
			return "注册成功";
		}

		return "注册失败,当前用户名已存在,请重新输入";

	}

	// 进入注册页面
	@RequestMapping("/register")
	public String register() {
		return "register";
	}

	// 进入个人主页
	@RequestMapping("/personal")
	public String personal(String user2_name, Integer showPage, Model model, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		if (showPage == null) {
			showPage = 1;
		}

		HttpSession session = request.getSession();// 得到当前登录的用户

		String user_name = (String) session.getAttribute("user_name");// user_name为当前登录的用户
		// user2_name = new String(user2_name.getBytes("iso-8859-1"),
		// "utf-8");// user2_name当前个人主页的用户

		if (!user2_name.equals(user_name)) {// 判断是否进入的是自己的主页面
			TbUserAttention ta = usc.isAttention(user_name, user2_name);// 判断是否已关注该作者

			if (ta != null) {
				model.addAttribute("isAttention", "已关注");// 数据表中存在该数据 则表示已关注
			} else {
				model.addAttribute("isAttention", "未关注");
			}
		}

		// 显示我写的贴文
		List<TbTw> my_tbtw_list = get_my_tw(user2_name);// 获取我的所有贴文

		// 设置分页
		int showNum = 3;// 一页最多显示3条贴文

		int sumPage = my_tbtw_list.size() / showNum;// 得到分页后的总页数

		if (my_tbtw_list.size() % showNum != 0) {// 无法取余，说明还有一页
			sumPage += 1;
		}

		String pagingButton = "<li><a href='#' aria-label='Next'><spanaria-hidden='true'>«</spanaria-hidden='true'></a></li>";// 拼写分页按钮

		// 设置分页之后总共有几个按钮
		for (int i = 1; i <= sumPage; i++) {
			pagingButton += "<li><a href='http://localhost:8080/ssmProject_tb/personal.action?user2_name=" + user2_name
					+ "&showPage=" + i + "'>" + i + "</a></li>";
		}

		pagingButton += "<li><a href='#' aria-label='Next'><spanaria-hidden='true'>»</spanaria-hidden='true'></a></li>";

		model.addAttribute("pagingButton", pagingButton);

		// 设置分页按钮所对应页面出现的贴文
		showPage = ((showPage - 1) * showNum);

		// 设置一页显示的贴吧数量
		List<TbTw> showPageTwList = new ArrayList<>();// 分页之后 页面实际显示的贴文
		for (int i = showPage, j = 0; j < showNum && i < my_tbtw_list.size(); i++, j++) {
			showPageTwList.add(my_tbtw_list.get(i));
		}

		model.addAttribute("action", "showTwList");// 设置是哪个方法执行该操作
		model.addAttribute("my_tbtw_list", showPageTwList);// 设置我所有贴文的列表

		// 显示我关注作者的总数
		List<TbUserAttention> list_myAttension = gainMyAttentionsOrFans("1", user2_name);
		model.addAttribute("count_myAttension", list_myAttension.size());

		// 得到我所有关注的作者
		model.addAttribute("list_myAttension", list_myAttension);

		// 显示我的粉丝总数
		List<TbUserAttention> list_myFans = gainMyAttentionsOrFans("2", user2_name);
		model.addAttribute("count_myFans", list_myFans.size());

		// 得到我所有的粉丝
		model.addAttribute("list_myFans", list_myFans);

		return "personal";
	}

	// 更新个人信息
	@RequestMapping("/updPerson")
	@ResponseBody
	public String updPerson(String loginUser, String user_name, String user_pwd, String user_sex) {
		usc = new UserServiceImpl();

		Map map = new TreeMap<>();
		map.put("user_name", user_name);
		map.put("user_pwd", user_pwd);
		map.put("user_sex", user_sex);
		map.put("loginUser", loginUser);

		boolean flag = usc.updPerson(map);

		if (flag == true) {
			return "修改成功，请重新登录";
		} else {
			return "修改失败，格式不正确或者用户名已存在，请重新输入";
		}
	}

	// 关注或取消关注作者
	@RequestMapping("/functionAttention")
	@ResponseBody
	public String functionAttention(String user1_name, String user2_name, HttpServletRequest request)
			throws UnsupportedEncodingException {
		usc = new UserServiceImpl();

		String data = usc.functionAttention(user1_name, user2_name);

		String[] strArr = data.split("\\|");

		String str_json = "{'message':'" + strArr[0] + "','attention_id':" + strArr[1] + "}";//设置成json格式进行传送数据

		return str_json;
	}

	// 个人主页 取消关注作者
	@RequestMapping("/person_cancelAttention")
	public @ResponseBody Map person_cancelAttention(String user1_name, String user2_name) {
		usc = new UserServiceImpl();

		Map map = usc.person_cancelAttention(user1_name, user2_name);// 取消关注

		return map;
	}

	// 获取我关注的所有作者和我的所有粉丝
	public List<TbUserAttention> gainMyAttentionsOrFans(String choose, String user_name) {
		usc = new UserServiceImpl();

		List<TbUserAttention> list = usc.gainMyAttentionsOrFans(choose, user_name);

		return list;
	}

	// 得到我写的贴文
	public List<TbTw> get_my_tw(String user_name) {
		usc = new UserServiceImpl();

		List<TbTw> my_tbtw_list = usc.get_my_tw(user_name);// 获取我的贴文

		// 文章内容过长，设置将过长的字段隐藏
		for (int i = 0; i < my_tbtw_list.size(); i++) {
			TbTw tt_temp = my_tbtw_list.get(i);
			String tw_temp = tt_temp.getTw_article();
			if (tw_temp.length() >= 132) {// 超过50个字则隐藏
				tt_temp.setTw_article(tw_temp.substring(0, 132) + "......");// 设置只显示贴文的前50个文字
			}
		}

		return my_tbtw_list;
	}

	// 判断是否已经关注该作者
	public boolean isAttention(String user1_name, String user2_name) {
		boolean flag = false;

		usc = new UserServiceImpl();

		TbUserAttention ta = this.usc.isAttention(user1_name, user2_name);

		// 判断数据库中是否存在该数据
		if (ta != null) {
			flag = true;
		} else {
			flag = false;
		}

		return flag;
	}

	// 保存消息提示到数据库中
	public String existMsg(String user1_name, String user2_name, String msg_contain) {

		usc = new UserServiceImpl();

		Map map = new HashMap<String, String>();
		map.put("user1_name", user1_name);// 接收消息的对象
		map.put("user2_name", user1_name);// 引发消息的对象
		map.put("msg_contain", msg_contain);// 消息内容

		boolean flag = usc.existMsg(map);

		if (flag) {// 消息保存成功
			return "保存成功";
		} else {// 消息保存失败
			return "保存失败";
		}

	}

	@RequestMapping("delMsg")
	@ResponseBody
	public String delMsg(int tb_msg) {
		usc = new UserServiceImpl();

		boolean flag = usc.delMsg(tb_msg);

		if (flag) {
			return "删除成功";
		} else {
			return "删除失败";
		}
	}
}
