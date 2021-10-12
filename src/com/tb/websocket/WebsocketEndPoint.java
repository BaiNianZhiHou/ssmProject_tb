package com.tb.websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.EncodeException;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.my.util.ServerEncoder;
import com.tb.pojo.TbTw;
import com.tb.pojo.TbUserAttention;
import com.tb.pojo.WebSocketMessage;
import com.tb.service.TbServiceImpl;
import com.tb.service.UserServiceImpl;

@ServerEndpoint(value = "/websocket/{login_userName}", encoders = { ServerEncoder.class })
public class WebsocketEndPoint {
	/**
	 * 维护一个用户列表（key存放用户名，value存放一个用户的WebsocketEndPoint）
	 */
	private static Map<String, WebsocketEndPoint> users = new ConcurrentHashMap<>();
	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session webSocketsession;

	String login_user = "";// 存放当前登录对象的用户名（也是唯一标识码）

	private UserServiceImpl usi;
	private TbServiceImpl tsi;

	@OnOpen
	public void onOpen(@PathParam(value = "login_userName") String param, Session webSocketsession,
			EndpointConfig config) {

		login_user = param;

		this.webSocketsession = webSocketsession;

		users.put(login_user, this);

	}

	/**
	 * @Title: onMessage
	 * @Description: 收到消息后的操作
	 * @param @param
	 *            message 收到的消息
	 * @param @param
	 *            session 该连接的session属性
	 * @throws EncodeException
	 * @throws IOException
	 */
	@OnMessage // 服务器收到客户端消息后执行该方法
	public void onMessage(String message, Session webSocketsession) throws IOException, EncodeException {
		String[] temp = message.split("\\|");// 将客户端发送来的消息进行切割

		String action = temp[0];// 第一部分是action指令 用来选择对应要执行的方法

		if (action.equals("onlineCount")) {// 获取在线的用户总数
			String jsonStr = "{'action':'" + action + "','message':'当前在线人数：" + users.size() + "'}";

			for (Entry<String, WebsocketEndPoint> entry : users.entrySet()) {
				WebsocketEndPoint wk = entry.getValue();

				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// 将当前在线的用户数量信息发送给客户端

			}
		} else if (action.equals("attention")) {// 执行关注功能 发送消息给被关注的人
			String isAttention_userName = temp[1];// 客户端发送的消息进行切割-》被关注的人的用户名

			String doAttention_userName = temp[2];// 客户端发送的消息进行切割-》执行关注的人的用户名
			
			String attention_id = temp[3];// 客户端发送的消息进行切割-》新插入数据库的数据的id

			WebsocketEndPoint wk = users.get(isAttention_userName);// 查看被关注的人是否存在在在线的用户队列中

			// String send_message = "<a
			// href=/'http://localhost:8080/ssmProject_tb/personal.action?user2_name="
			// + doAttention_userName + "/'>" + doAttention_userName +
			// "</a>关注了我";

			String send_message = doAttention_userName + "关注了我";

			// 将消息提示保存到数据库中
			usi = new UserServiceImpl();

			Map map = new HashMap<>();
			map.put("user1_name", doAttention_userName);// 存放得到消息的用户的用户名
			map.put("user2_name", isAttention_userName);// 存放触发消息发送的用户的用户名
			map.put("msg_contain", send_message);// 存放消息提醒的内容

			boolean flag = usi.existMsg(map);

			// 准备发送消息给客户端
			if (wk != null && flag != false) {
				String jsonStr = "{'action':'attention','message':'" + send_message + "','attention_id':"+attention_id+"}";
				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// 发送消息给客户端
			}
		}
	}

	// 客户端执行发帖->发消息提示给粉丝
	public void sendTb_msgToFans(String user_name) throws IOException {// user_name:关注的人
		usi = new UserServiceImpl();

		List<TbUserAttention> fansOfList = usi.gainMyAttentionsOrFans("2", user_name);// 得到user_name的粉丝

		List<String> userNameOfFans = new ArrayList<String>();// 存放所有粉丝的用户名

		// 得到所有粉丝的用户名
		for (int i = 0; i < fansOfList.size(); i++) {
			String fansOfName = fansOfList.get(i).getUser1_name();

			userNameOfFans.add(fansOfName);
		}

		// 将消息发送给当前连接服务器的粉丝的客户端
		for (int j = 0; j < userNameOfFans.size(); j++) {
			String fansName = userNameOfFans.get(j);// 得到粉丝的用户名

			String message = user_name + ":发表了新贴文";// 设置要被发送出去的文本

			WebsocketEndPoint wk = users.get(fansName);// 得到在线的客户端（粉丝）

			if (wk != null) {
				// 存放发消息、接收消息的用户的用户名以及消息的内容
				Map map = new HashMap<>();
				map.put("user1_name", user_name);// 发消息的对象
				map.put("user2_name", fansName);// 收消息的对象
				map.put("msg_contain", message);// 消息内容

				usi.existMsg(map);// 将消息存入数据库

				String jsonStr = "{'action':'sendTb_msgToFans','message':'" + message + "'}";// 设置成json格式，便于js函数的使用

				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// 将消息发送给粉丝的客户端
			}

		}

	}

	// 有人评论贴文->发消息给该贴文的作者
	public void doComment_msgToWriter(String user_name, int tw_id, String writer, String comment_contain)
			throws IOException {// user_name:关注的人
		tsi = new TbServiceImpl();
		usi = new UserServiceImpl();

		String message = user_name + "评论了我的贴文:" + comment_contain;// 发送的消息内容

		// 将消息发送给当前连接服务器的对应作者的客户端
		WebsocketEndPoint wk = users.get(writer);// 得到在线的客户端（贴文作者）

		if (wk != null) {
			// 存放发消息、接收消息的用户的用户名以及消息的内容
			Map map = new HashMap<>();
			map.put("user1_name", user_name);// 发消息的对象
			map.put("user2_name", writer);// 收消息的对象
			map.put("msg_contain", message);// 消息内容

			System.out.println(map);

			usi.existMsg(map);// 将消息存入数据库

			String jsonStr = "{'action':'doComment_msgToWriter','message':'" + message + "'}";// 设置成json格式，便于js函数的使用

			wk.webSocketsession.getBasicRemote().sendText(jsonStr);// 将消息发送给粉丝的客户端
		}
	}

	@OnClose
	public void onClose() {
		users.remove(login_user);// 将断开连接的客户端从map中移除
	}

}
