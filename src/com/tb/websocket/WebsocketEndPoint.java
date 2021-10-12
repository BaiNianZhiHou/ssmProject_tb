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
	 * ά��һ���û��б�key����û�����value���һ���û���WebsocketEndPoint��
	 */
	private static Map<String, WebsocketEndPoint> users = new ConcurrentHashMap<>();
	// ��ĳ���ͻ��˵����ӻỰ����Ҫͨ���������ͻ��˷�������
	private Session webSocketsession;

	String login_user = "";// ��ŵ�ǰ��¼������û�����Ҳ��Ψһ��ʶ�룩

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
	 * @Description: �յ���Ϣ��Ĳ���
	 * @param @param
	 *            message �յ�����Ϣ
	 * @param @param
	 *            session �����ӵ�session����
	 * @throws EncodeException
	 * @throws IOException
	 */
	@OnMessage // �������յ��ͻ�����Ϣ��ִ�и÷���
	public void onMessage(String message, Session webSocketsession) throws IOException, EncodeException {
		String[] temp = message.split("\\|");// ���ͻ��˷���������Ϣ�����и�

		String action = temp[0];// ��һ������actionָ�� ����ѡ���ӦҪִ�еķ���

		if (action.equals("onlineCount")) {// ��ȡ���ߵ��û�����
			String jsonStr = "{'action':'" + action + "','message':'��ǰ����������" + users.size() + "'}";

			for (Entry<String, WebsocketEndPoint> entry : users.entrySet()) {
				WebsocketEndPoint wk = entry.getValue();

				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// ����ǰ���ߵ��û�������Ϣ���͸��ͻ���

			}
		} else if (action.equals("attention")) {// ִ�й�ע���� ������Ϣ������ע����
			String isAttention_userName = temp[1];// �ͻ��˷��͵���Ϣ�����и�-������ע���˵��û���

			String doAttention_userName = temp[2];// �ͻ��˷��͵���Ϣ�����и�-��ִ�й�ע���˵��û���
			
			String attention_id = temp[3];// �ͻ��˷��͵���Ϣ�����и�-���²������ݿ�����ݵ�id

			WebsocketEndPoint wk = users.get(isAttention_userName);// �鿴����ע�����Ƿ���������ߵ��û�������

			// String send_message = "<a
			// href=/'http://localhost:8080/ssmProject_tb/personal.action?user2_name="
			// + doAttention_userName + "/'>" + doAttention_userName +
			// "</a>��ע����";

			String send_message = doAttention_userName + "��ע����";

			// ����Ϣ��ʾ���浽���ݿ���
			usi = new UserServiceImpl();

			Map map = new HashMap<>();
			map.put("user1_name", doAttention_userName);// ��ŵõ���Ϣ���û����û���
			map.put("user2_name", isAttention_userName);// ��Ŵ�����Ϣ���͵��û����û���
			map.put("msg_contain", send_message);// �����Ϣ���ѵ�����

			boolean flag = usi.existMsg(map);

			// ׼��������Ϣ���ͻ���
			if (wk != null && flag != false) {
				String jsonStr = "{'action':'attention','message':'" + send_message + "','attention_id':"+attention_id+"}";
				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// ������Ϣ���ͻ���
			}
		}
	}

	// �ͻ���ִ�з���->����Ϣ��ʾ����˿
	public void sendTb_msgToFans(String user_name) throws IOException {// user_name:��ע����
		usi = new UserServiceImpl();

		List<TbUserAttention> fansOfList = usi.gainMyAttentionsOrFans("2", user_name);// �õ�user_name�ķ�˿

		List<String> userNameOfFans = new ArrayList<String>();// ������з�˿���û���

		// �õ����з�˿���û���
		for (int i = 0; i < fansOfList.size(); i++) {
			String fansOfName = fansOfList.get(i).getUser1_name();

			userNameOfFans.add(fansOfName);
		}

		// ����Ϣ���͸���ǰ���ӷ������ķ�˿�Ŀͻ���
		for (int j = 0; j < userNameOfFans.size(); j++) {
			String fansName = userNameOfFans.get(j);// �õ���˿���û���

			String message = user_name + ":������������";// ����Ҫ�����ͳ�ȥ���ı�

			WebsocketEndPoint wk = users.get(fansName);// �õ����ߵĿͻ��ˣ���˿��

			if (wk != null) {
				// ��ŷ���Ϣ��������Ϣ���û����û����Լ���Ϣ������
				Map map = new HashMap<>();
				map.put("user1_name", user_name);// ����Ϣ�Ķ���
				map.put("user2_name", fansName);// ����Ϣ�Ķ���
				map.put("msg_contain", message);// ��Ϣ����

				usi.existMsg(map);// ����Ϣ�������ݿ�

				String jsonStr = "{'action':'sendTb_msgToFans','message':'" + message + "'}";// ���ó�json��ʽ������js������ʹ��

				wk.webSocketsession.getBasicRemote().sendText(jsonStr);// ����Ϣ���͸���˿�Ŀͻ���
			}

		}

	}

	// ������������->����Ϣ�������ĵ�����
	public void doComment_msgToWriter(String user_name, int tw_id, String writer, String comment_contain)
			throws IOException {// user_name:��ע����
		tsi = new TbServiceImpl();
		usi = new UserServiceImpl();

		String message = user_name + "�������ҵ�����:" + comment_contain;// ���͵���Ϣ����

		// ����Ϣ���͸���ǰ���ӷ������Ķ�Ӧ���ߵĿͻ���
		WebsocketEndPoint wk = users.get(writer);// �õ����ߵĿͻ��ˣ��������ߣ�

		if (wk != null) {
			// ��ŷ���Ϣ��������Ϣ���û����û����Լ���Ϣ������
			Map map = new HashMap<>();
			map.put("user1_name", user_name);// ����Ϣ�Ķ���
			map.put("user2_name", writer);// ����Ϣ�Ķ���
			map.put("msg_contain", message);// ��Ϣ����

			System.out.println(map);

			usi.existMsg(map);// ����Ϣ�������ݿ�

			String jsonStr = "{'action':'doComment_msgToWriter','message':'" + message + "'}";// ���ó�json��ʽ������js������ʹ��

			wk.webSocketsession.getBasicRemote().sendText(jsonStr);// ����Ϣ���͸���˿�Ŀͻ���
		}
	}

	@OnClose
	public void onClose() {
		users.remove(login_user);// ���Ͽ����ӵĿͻ��˴�map���Ƴ�
	}

}
