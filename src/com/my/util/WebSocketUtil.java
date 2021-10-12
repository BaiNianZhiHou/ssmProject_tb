//package com.my.util;
//
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.List;
//import java.util.Set;
//import java.util.concurrent.ConcurrentHashMap;
//
//import javax.websocket.EndpointConfig;
//import javax.websocket.OnClose;
//import javax.websocket.OnMessage;
//import javax.websocket.OnOpen;
//import javax.websocket.Session;
//import javax.websocket.server.PathParam;
//import javax.websocket.server.ServerEndpoint;
//
//import com.tb.pojo.TbUser;
//import com.tb.pojo.TbUserAttention;
//import com.tb.service.UserService;
//import com.tb.service.UserServiceImpl;
//
////@ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端
////注解的值使得客户端可以通过这个URL来连接到WebSocket服务器端
//@ServerEndpoint(value = "/websocket/{login_userName}")
//public class WebSocketUtil {
//	//连接到该服务器的客户端对象的用户名
//	private String login_userName;
//	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
//	private Session webSocketsession;
//	// concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
//	// 若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
//	private static ConcurrentHashMap<String, WebSocketUtil> webSocketMap = new ConcurrentHashMap<String, WebSocketUtil>();
//
//	// 使用Service层的方法
//	private UserServiceImpl userServiceImpl = new UserServiceImpl();
//
//	public static ConcurrentHashMap<String, WebSocketUtil> getWebSocketMap() {
//		return webSocketMap;
//	}
//
//	/**
//	 * 连接建立成功调用的方法
//	 *
//	 * @param session
//	 *            可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
//	 */
//	@OnOpen
//	public void onOpen(@PathParam(value = "login_userName") String param, Session webSocketsession,
//			EndpointConfig config) {
//
//		this.login_userName = param;// 接收到连接到该服务器的对象的用户名
//
//		this.webSocketsession = webSocketsession;
//
//		webSocketMap.put(login_userName, this);// 将当前这个客户端对象加入到map中
//
//		System.out.println("当前在线人数：" + webSocketMap.size());
//
//	}
//
//	/**
//	 *       连接关闭调用的方法      
//	 */
//	@OnClose
//	public void onClose() {
//		webSocketMap.remove(this.login_userName);// 从当前客户端的用户中服务器中删除
//	}
//
//	/**
//	 *      * 收到客户端消息后调用的方法      *      * @param message 客户端发送过来的消息    
//	 *  * @param session 可选的参数      
//	 */
//	@SuppressWarnings("unused")
//	@OnMessage
//	public void onMessage(String message, Session session) {
//
//		System.out.println("来自客户端的消息:");
//	}
//
//	// 服务器发送消息给客户端
//	public void countOnlineUsers() {
//		Integer num_onlineUsers = webSocketMap.size();// 得到当前在线的用户总数
//
//		for (String key : webSocketMap.keySet()) {// 遍历当前连接到服务器的所有客户端
//
//			Session session_temp = webSocketMap.get(key).webSocketsession;// 得到客户端的session
//
//			session_temp.getAsyncRemote().sendObject(num_onlineUsers);// 通过session来发消息给这些客户端
//		}
//	}
//
//	// 发送消息通知给我的粉丝
//	public void sendMessagetoMyFans(String message) throws IOException {
//		System.out.println("login_userName=" + this.login_userName);
//		// 得到我的所有粉丝
//		List<TbUserAttention> myAttentionList = userServiceImpl.gainMyAttentionsOrFans("2", this.login_userName);
//		System.out.println(myAttentionList.size());
//		for (String key : webSocketMap.keySet()) {
//			// System.out.println("当前登录的用户：" + key);
//			WebSocketUtil user_webSocketsession = webSocketMap.get(key);// 得到连接到服务器的所有客户端的WebSocketUtil
//
//			for (int i = 0; i < myAttentionList.size(); i++) {
//				System.out.println("我的粉丝：" + myAttentionList.get(i).user2_name);
//				if (user_webSocketsession.login_userName.equals(myAttentionList.get(i).user2_name)) {// 将消息只发送给我的粉丝
//					this.webSocketsession.getBasicRemote().sendText(message);// 接收客户端的信息，并将该信息传给onMessage方法，让服务器对客户端进行响应
//				}
//			}
//		}
//	}
//
//}
