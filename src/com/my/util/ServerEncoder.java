package com.my.util;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import com.tb.pojo.WebSocketMessage;

import net.sf.json.JSONArray;

public class ServerEncoder implements Encoder.Text<WebSocketMessage> {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init(EndpointConfig arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public String encode(WebSocketMessage messagepojo) throws EncodeException {

		JSONArray jsonObject = JSONArray.fromObject(messagepojo);

		return jsonObject.toString();

	}

}
