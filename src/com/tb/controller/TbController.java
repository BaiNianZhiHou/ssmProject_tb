package com.tb.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tb.pojo.TbComment;
import com.tb.pojo.TbMsg;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUserAttention;
import com.tb.service.TbService;
import com.tb.service.TbServiceImpl;
import com.tb.service.UserService;
import com.tb.service.UserServiceImpl;
import com.tb.websocket.WebsocketEndPoint;

import net.sf.json.JSONObject;
import redis.clients.jedis.Jedis;

@Controller
public class TbController {
	private TbService ts;
	private UserService usc;
	private WebsocketEndPoint we;

	// 进入主界面
	@RequestMapping("/main")
	public String main(Model model, HttpServletRequest request) throws IOException {
		ts = new TbServiceImpl();
		usc = new UserServiceImpl();

		List<TbTw> allTw = ts.showAllTw();

		HttpSession session = request.getSession();

		String user_name = (String) session.getAttribute("user_name");// 得到当前登录用户的用户名

		// // 统计当前所有的在线人数
		// Jedis jedis = new Jedis("localhost");// 将在线人数储存在缓存中
		// // System.out.println(jedis.ping());
		// jedis.sadd("onlinePeopel", user_name);//
		// 将当前登录的用户添加到redis中key为onlinePeopel的set中
		//
		// Long count_onlinePeopel = jedis.scard("onlinePeopel");//
		// 得到redis缓存中的在线人数
		// System.out.println("当前在线人数：" + wk.);
		// model.addAttribute("count_onlinePeopel", wk.countOnlineUsers());

		session.setAttribute("countTw", allTw.size());// 设置当前所有贴文的数量

		List<TbMsg> myMsgList = usc.getAllMsg(user_name);// 得到当前登录用户的所有消息

		session.setAttribute("myMsgCount", myMsgList.size());// 设置我所有消息的数量

		session.setAttribute("myMsgList", myMsgList);// 设置得到我所有消息的所有内容

		return "main";
	}

	// 进入发帖页面
	@RequestMapping("/send_tb_main")
	public String send_tb_main() {
		return "send_tb";
	}

	// 发帖
	@RequestMapping("/send_tb")
	public String send_tb(MultipartFile file, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String tw_title = request.getParameter("tw_title");
		String tw_article = request.getParameter("tw_article");
		String tw_sort = request.getParameter("tw_sort");

		// 进行字符转移，将文本编辑中输入的空格转换成空字符串" "
		tw_article = tw_article.replace("\b", " ");
		System.out.println(tw_article);

		HttpSession session = request.getSession();// 获得session
		String user_name = (String) (session.getAttribute("user_name"));// 得到session里面存放的当前登录对象的用户名
		TbTw tt = new TbTw();
		tt.setUser_name(user_name);// 设置当前登录的用户名
		tt.setTw_title(tw_title);
		tt.setTw_article(tw_article);

		/*
		 * 上传图片 图片成功上传到服务器中的指定路径后 将图片的地址上传到数据库中
		 */
		// 保存图片的路径(tomcat中有配置)
		String filePath = "D:\\eclipse\\tb_img";
		// 获取原始图片的拓展名
		String originalFilename = file.getOriginalFilename();

		if (originalFilename != "") {// 判断是否有图片准备上上传
			// 新的文件名，使用uuid随机生成数+原始图片名字，这样不会重复
			String newFileName = UUID.randomUUID() + originalFilename;

			// 封装上传文件位置的全路径，就是服务器的硬盘路径+文件名
			File targetFile = new File(filePath, newFileName);
			// 把本地文件上传到已经封装好的文件位置（服务器中的）的全路径就是上面的targetFile
			file.transferTo(targetFile);
			// 文件名保存到实体类对应属性上
			tt.setTw_img("/images/" + newFileName);
		}

		tt.setTw_sort(tw_sort);// 设置分类

		Date date = new Date();// 获得系统当前时间
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 对时间进行格式化
		String nowTime = sdf.format(date);// 获得系统当前时间(包含时分秒)
		Date tw_time = sdf.parse(nowTime);
		tt.setTw_time(tw_time);// 设置时间

		ts = new TbServiceImpl();
		boolean sendTw_flag = ts.send_tb(tt);// 将贴文的内容写入到数据库中

		model.addAttribute("action", "send_tb");// 设置是哪个方法执行该操作
		model.addAttribute("sendTw_flag", sendTw_flag);

		if (sendTw_flag) {// 贴文发表成功 则向服务器发送消息
			we = new WebsocketEndPoint();

			we.sendTb_msgToFans(user_name);
			// wk.sendMessagetoMyFans(user_name + ":粉丝们，我刚刚发表了一个新贴文");//
			// 对服务器发送信息
		}

		return "send_tb";
	}

	// 搜索贴文（根据分类搜索）
	@RequestMapping("/showSortTw") // showPage 跳转到第几页
	public String showSortTw(String tw_sort, int showPage, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");// 设置request用UTF-8来编译

		ts = new TbServiceImpl();

		List<TbTw> tbtw = ts.showSortTw(tw_sort);// 得到该分类中的所有贴文

		for (int i = 0; i < tbtw.size(); i++) {

		}

		// 设置分页
		int showNum = 4;// 一页最多显示showNum条贴文

		int sumPage = tbtw.size() / showNum;// 得到分页后的总页数

		if (tbtw.size() % showNum != 0) {// 无法取余，说明还有一页
			sumPage += 1;
		}

		// 设置分页按钮
		String pagingButton = "<li><a href='#' aria-label='Next'><spanaria-hidden='true'>«</spanaria-hidden='true'></a></li>";// 拼写分页按钮

		// 设置分页之后总共有几个按钮
		for (int i = 1; i <= sumPage; i++) {
			pagingButton += "<li><a href='http://localhost:8080/ssmProject_tb/showSortTw.action?tw_sort=" + tw_sort
					+ "&showPage=" + i + "'>" + i + "</a></li>";
		}

		pagingButton += "<li><a href='#' aria-label='Next'><spanaria-hidden='true'>»</spanaria-hidden='true'></a></li>";

		model.addAttribute("pagingButton", pagingButton);

		// 设置分页按钮所对应页面出现的贴文
		showPage = ((showPage - 1) * showNum);

		// 设置一页显示的贴吧数量
		List<TbTw> showPageTwList = new ArrayList<>();// 分页之后 页面实际显示的贴文
		for (int i = showPage, j = 0; j < showNum && i < tbtw.size(); i++, j++) {
			showPageTwList.add(tbtw.get(i));
		}

		// 文章内容过长，设置将过长的字段隐藏
		for (int i = 0; i < tbtw.size(); i++) {
			TbTw tt_temp = tbtw.get(i);
			String tw_temp = tt_temp.getTw_article();
			if (tw_temp.length() >= 132) {// 超过50个字则隐藏
				tt_temp.setTw_article(tw_temp.substring(0, 132) + "......");// 设置只显示贴文的前50个文字
			}
		}

		model.addAttribute("action", "showTwList");// 设置是哪个方法执行该操作
		model.addAttribute("tbtw", showPageTwList);

		return "show_tb";
	}

	// 查看贴文详情
	@RequestMapping("/showDetailTw")
	public String showDetailTw(int tw_id, String user_name, int showCommentPage, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ts = new TbServiceImpl(); // url中的user_name为当前贴吧的作者
		usc = new UserServiceImpl();

		TbTw tt = ts.showDetailTw(tw_id);// 得到该贴文的所有信息

		List<TbTw> tbtw = new ArrayList<>();

		tbtw.add(tt);

		HttpSession session = request.getSession();
		String user1_name = (String) session.getAttribute("user_name");// 获取当前登录的用户名

		String writer = tt.getUser_name();// 获取当前贴吧的作者

		TbUserAttention ta = usc.isAttention(user1_name, writer);// 判断是否已关注该作者

		// 判断是否关注了该贴文作者
		if (ta != null) {
			model.addAttribute("isAttention", "已关注");// 数据表中存在该数据，则表示已关注
		} else {
			model.addAttribute("isAttention", "未关注");
		}

		// 得到该贴文对应的所有评论
		Map data_map = ts.show_allComment(tw_id, writer, user1_name, showCommentPage);// 从数据库中得到该贴文对应的所有评论的相关数据

		String show_allComment = (String) data_map.get("str_allComment");// 获取该贴文的所有评论

		// 设置评论分页
		int sumPageComment = (int) data_map.get("sumPageComment");// 得到评论分页之后的总页数

		String pagingCommentButton = "<li><a href='#' aria-label='Previous'><spanaria-hidden='true'>«</spanaria-hidden='true'></a></li>";// 拼写分页按钮

		for (int i = 1; i <= sumPageComment; i++) {// 设置评论分页之后总共有几个按钮
			pagingCommentButton += "<li><a href='http://localhost:8080/ssmProject_tb/showDetailTw.action?tw_id=" + tw_id
					+ "&user_name=" + writer + "&showCommentPage=" + i + "'><spanaria-hidden='true'>" + i
					+ "</spanaria-hidden='true'></a></li>";
		}

		pagingCommentButton += "<li><a href='#' aria-label='Next'><spanaria-hidden='true'>»</spanaria-hidden='true'></a></li>";

		model.addAttribute("pagingCommentButton", pagingCommentButton);// 设置页面上评论的分页按钮
		model.addAttribute("action", "showDetailTw");// 设置是哪个方法执行该操作
		model.addAttribute("tbtw", tbtw);// 获取贴文内容
		model.addAttribute("show_allComment", show_allComment);// 得到当前贴文下的所有评论包括评论中的评论

		return "show_tb";
	}

	// 删除我的贴文
	@RequestMapping("/delTbTw")
	public String delTbTw(int tw_id, Model model, HttpServletRequest request) {
		ts = new TbServiceImpl();

		// 删除服务器中对应储存的图片
		TbTw tt = ts.showDetailTw(tw_id);// 得到所删除的贴文的对应信息

		String img_path = tt.getTw_img();// 得到该贴文中图片在数据库中的绝对路径

		if (img_path != null) {// 存在图片才执行删除图片的操作
			String[] splitImg_path = img_path.split("/");// 切割得到图片的名字
			String imgUrl = "D:\\eclipse\\tb_img\\" + splitImg_path[2];// 得到图片在服务器中储存的绝对路径

			File file = new File(imgUrl);

			if (file.exists()) {// 判断是否存在
				if (file.delete()) {// 判断是否删除成功
					ts.delTbTw(tw_id);// 图片删除成功后 再把数据库中的数据删除掉
				} else
					System.out.println("删除失败");
			} else {
				System.out.println("该图片并不存在在服务器中的" + imgUrl + "路径");
				ts.delTbTw(tw_id);
			}
		} else {
			ts.delTbTw(tw_id);// 直接删除该贴吧
		}

		return "show_tb";
	}

	// 发表评论
	@RequestMapping("/doComment")
	@ResponseBody
	public JSONObject doComment(int tw_id, String user_name, Integer incomment_id, String comment_context, TbComment tc,
			HttpServletRequest request) throws ParseException, IOException {
		String message = "";
		JSONObject jsondata = null;
		Map dataMap = null;// 存放要发送的数据

		ts = new TbServiceImpl();

		tc = new TbComment();
		tc.setTw_id(tw_id);// 评论的贴文id
		tc.setUser_name(user_name);// 发表该评论的用户名
		tc.setComment_context(comment_context);// 评论内容
		tc.setIncomment_id(incomment_id);// 间接评论的id

		// 时间的设置
		Date comment_time = new Date();// 获得系统当前时间

		tc.setComment_time(comment_time);// 将获得的系统当前时间赋值给TbComment对象

		// 对日期时间进行格式化
		SimpleDateFormat dateFm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 设置格式化的格式
		String str_commentTime = dateFm.format(tc.getComment_time());// 将data类型格式化成String类型

		ts.doComment(tc);// 执行评论
		Integer comment_id = tc.getComment_id();// 获取新评论的id

		if (comment_id != null) {

			if (incomment_id == 0) {// 说明是直接评论
				message = "<li id='show_comment" + comment_id
						+ "'><div><a href='http://localhost:8080/ssmProject_tb/personal.action?user2_name=" + user_name
						+ "\' target='_Blank'>" + user_name + ":</a>" + comment_context
						+ "<a href='javascript:insert_inputComment(" + tw_id + "," + comment_id + ",\"" + user_name
						+ "\"," + incomment_id + ")'>回复评论</a>" + str_commentTime + "<a href='javascript:delComment("
						+ comment_id
						+ ")' id='del_a' onclick='return cf_delComment()'>删除</a><div id=\'insert_inputComment"
						+ comment_id + "\'></div></div><hr></li>";
			} else {// 回复评论
				message = "<a href='http://localhost:8080/ssmProject_tb/personal.action?user2_name=" + user_name
						+ "\' target='_Blank'>" + user_name + ":</a>" + comment_context + "" + str_commentTime
						+ "<a href='javascript:delComment(" + comment_id
						+ ")' id='del_a' onclick='return cf_delComment()'>删除</a><div id=\'insert_inputComment"
						+ comment_id + "\'>";
			}

			dataMap = new HashMap<>();
			dataMap.put("message", message);
			dataMap.put("comment_id", comment_id);

			// 评论成功，使用websocket发送消息给对应作者的客户端
			// 得到该贴文的作者名
			TbTw tt = ts.showDetailTw(tw_id);
			String writer = tt.getUser_name();

			if (!writer.equals(user_name)) {// 若执行评论的对象不是该贴吧的作者，才使用websocket发送评论
				we = new WebsocketEndPoint();
				we.doComment_msgToWriter(user_name, tw_id, writer, comment_context);
			}

		} else {
			message = "发表评论失败";
			dataMap.put("message", message);
		}

		jsondata = JSONObject.fromObject(dataMap);

		return jsondata;
	}

	// 删除评论
	@RequestMapping("/delComment")
	public @ResponseBody String delComment(int comment_id) {
		String meg = "";

		ts = new TbServiceImpl();

		boolean flag = ts.delComment(comment_id);// 执行删除评论

		return meg;
	}

}
