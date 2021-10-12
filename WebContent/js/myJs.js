var websocket = null;

// 页面一打开就执行WebSocket连接
function connect_webSocket(login_userName, action) {
	// alert("login_userName=" + login_userName)
	if ('WebSocket' in window) {
		websocket = new WebSocket(
				"WS://localhost:8080/ssmProject_tb/websocket/" + login_userName);// 注意此处的ws要加上项目名JavaWebSocket再加@ServerEndpoint注解的值websocket

		// 客户端与服务器握手成功 调用该方法
		websocket.onopen = function(evnt) {
			// 发送消息给服务器
			if (action == 'onlineCount') {
				websocket.send("onlineCount|");// 获得在线用户总数
			}
		};

	} else {
		alert('当前浏览器 Not support websocket')
	}
}

// main.jsp页面打开时自动执行的方法
function jsp_main(login_userName) {
	connect_webSocket(login_userName, 'onlineCount');// 连接WebSocket,第二个参数用来指定使用的方法

	// 客户端收到服务器的消息时调用该方法
	websocket.onmessage = function(evnt) {
		var map = eval("(" + evnt.data + ")");// 解析服务器发送的json对象;

		var action = map.action;// 指定要执行的action命令
		var message = map.message;// 得到服务器发送的数据

		if (action == 'onlineCount') {// 得到当前在线的用户总数,并从服务器中将得到的在线人数总数写入到jsp页面中
			document.getElementById("show_sum_tb").innerHTML = message;
		} else if (action == 'attention') {// 被关注执行该方法
			document.getElementById("newMessage").innerHTML = message// 在弹窗中写入消息

			// 将当前页面的消息总数+1,并写入jsp页面
			var myMsgCount = parseInt(document.getElementById("messageBox").innerHTML);
			var newMsgCount = myMsgCount + 1;
			document.getElementById("messageBox").innerHTML = newMsgCount;

			var attention_id = map.attention_id;//得到新插入数据库的数据的id
			
			insertMsgBox(message,attention_id)// 把消息写入主页面的消息盒子中

			// 设置消息弹窗
			tips_pop();

		} else if (action == 'sendTb_msgToFans') {// 客户端执行发帖->服务器发消息提示给粉丝的客户端
			document.getElementById("newMessage").innerHTML = message// 设置弹窗内容

			// 将当前页面的消息总数+1
			var myMsgCount = parseInt(document.getElementById("messageBox").innerHTML);
			var newMsgCount = myMsgCount + 1;
			document.getElementById("messageBox").innerHTML = newMsgCount;// 将新的消息总数写入jsp页面

			insertMsgBox(message)// 把消息写入主页面的消息盒子中

			// 设置消息弹窗
			tips_pop();
		} else if (action == 'doComment_msgToWriter') {// 有人评论贴文->发消息给该贴文的作者
			document.getElementById("newMessage").innerHTML = message// 设置弹窗内容

			// 将当前页面的消息总数+1
			var myMsgCount = parseInt(document.getElementById("messageBox").innerHTML);
			var newMsgCount = myMsgCount + 1;
			document.getElementById("messageBox").innerHTML = newMsgCount;// 将新的消息总数写入jsp页面

			insertMsgBox(message)// 把消息写入主页面的消息盒子中

			// 设置消息弹窗
			tips_pop();
		}
	};
}

// 将新消息写入消息盒子中
function insertMsgBox(message,del_attentionId) {
	var tb = document.getElementById("msgBoxId");// 得到消息盒子的id
	var new_tr = tb.insertRow(0);// 在第一行创建新的一行
	var new_td1 = new_tr.insertCell(0);// 在0行之后创建新行
	var new_td2 = new_tr.insertCell(1);// 在1行之后创建新行

	// 设置样式
	new_td1.style.cssText = "text-align: center";
	new_td2.style.cssText = "text-align: center";

	// 将消息内容写入jsp页面的消息盒子中
	new_td1.innerHTML = message;
	new_td2.innerHTML = "<a style='color: #97CBFF;' href='javascript:delMsg("+del_attentionId+")'>删除</a>";
}

// 页面弹窗的设置
function tips_pop() {
	var MsgPop = document.getElementById("winpop");// 获取窗口这个对象,即ID为winpop的对象

	var MsgH = parseInt(MsgPop.style.height);// 用parseInt将对象的高度转化为数字,以方便下面比较

	if (MsgH == 0) { // 如果窗口处于关闭状态，才打开一个新窗口
		MsgPop.style.display = "block";// 那么将隐藏的窗口显示出来
		show = setInterval("changeH('up')", 20);// 开始以每0.002秒调用函数changeH("up"),即每0.002秒向上移动一次
	}
}

// 改变弹窗的高度
function changeH(str) {
	var MsgPop = document.getElementById("winpop");
	var popH = parseInt(MsgPop.style.height);// 得到当前页面上弹窗的高度

	if (str == "up") { // 如果这个参数是UP
		if (popH <= 100) { // 如果转化为数值的高度小于等于100
			MsgPop.style.height = (popH + 4).toString() + "px";// 高度增加4个象素
		} else {// popH长度到104之后不再增加窗口的长度
			clearInterval(show);// 取消这个函数调用，不再增长了

			// 设置3s之后执行取消窗口的显示
			setTimeout(function() {
				hide = setInterval("changeH('down')", 15)
			}, 3000);
		}
	}

	if (str == "down") {
		if (popH >= 4) { // 如果这个参数是down
			MsgPop.style.height = (popH - 4).toString() + "px";// 那么窗口的高度减少4个象素
		} else { // popH为0时，关闭调用窗口长度减少的方法
			clearInterval(hide); // 取消这个函数调用,意思就是如果高度小于4个象度的时候,就不再减了
			MsgPop.style.display = "none"; // 因为窗口有边框,所以还是可以看见1~2象素没缩进去,这时候就把DIV隐藏掉
		}
	}
}

// 当浏览器关闭 则将客户端与服务器断开
window.onbeforeunload = function(event) {
	this.websocket.onclose = function() {
	};
	this.websocket.close();
}

// 创建XMLHttpRequest 对象
function createXMLHttpRequest() { // 万能模板

	var XMLHttpReq;

	if (window.XMLHttpRequest) { // 是Mozilla浏览器

		XMLHttpReq = new XMLHttpRequest();
	} else if (window.ActiveXObject()) { // IE浏览器
		try {
			XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP"); // 因为ie也会出现不兼容所以抛异常
		} catch (e) {
			XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP"); // 微软的，记住就好
		}
	}
	return XMLHttpReq;
}
// 进入个人中心
function personal(user2_name) {
	window.location.href = "http://localhost:8080/ssmProject_tb/personal.action?user2_name="
			+ user2_name;
}

function to_main() {
	window.location.href = "http://localhost:8080/project_tb" + "/main.jsp";

}

// 查看详情贴吧
function showDetailTw(tw_id, user_name) {
	window.location.href = "http://localhost:8080/ssmProject_tb/showDetailTw.action?tw_id="
			+ tw_id + "&user_name=" + user_name + "&showCommentPage=1";
}

// 登录验证
function loginAuthentication() {

	var user_name = $("#user_name").val();
	var user_pwd = $("#user_pwd").val();

	var login_userName = user_name;

	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq.open("POST",
			"http://localhost:8080/ssmProject_tb/loginAuthentication.action",
			true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("user_name=" + encodeURI(user_name) + "&user_pwd="
			+ encodeURI(user_pwd));

	alert("欢迎您的登录")

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.readyState == 4) {// 判断对象状态是否完成
			if (xmlReq.status == 200) { // 信息已经成功返回
				var xmltext = xmlReq.responseText;// 得到返回的数据
				if (xmltext == 'true') {// 判断登录是否成功 如果成功的话 则进行客户端对服务器的连接
					// 判断当前浏览器是否支持WebSocket
					if ('WebSocket' in window) {

						alert("登录成功")

						window.location.href = "http://localhost:8080/ssmProject_tb/main.action";// 跳转到主界面
					} else {
						alert('当前浏览器 Not support websocket')
					}
				} else if (xmltext == 'false') {
					alert("用户名或密码错误,请重新输入")
				} else {
					alert("您已登录，无需重复登录")
					window.location.href = "http://localhost:8080/ssmProject_tb/main.action";// 当前客户已经登录,直接跳转到主界面
				}
			}
		}
	}
}

// 更新个人信息
function updPerson(loginUser) {
	var flag = cf_delComment();// 判断是否执行该操作

	if (flag) {
		var user_name = $("#user_name").val();
		var user_pwd = $("#user_pwd").val();
		var user_sex = $("input[name='user_sex']:checked").val();

		// 1.创建XMLHttpRequest对象
		var xmlReq = createXMLHttpRequest();
		// 2.打开和服务器端的连接
		xmlReq.open("POST",
				"http://localhost:8080/ssmProject_tb/updPerson.action", true);// 有GTE和POST方法，中间代表连接路径，true代表异步

		xmlReq.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

		// 3.发送数据
		xmlReq.send("user_name=" + encodeURI(user_name) + "&user_pwd="
				+ encodeURI(user_pwd) + "&user_sex=" + encodeURI(user_sex)
				+ "&loginUser=" + encodeURI(loginUser));

		// 4.接收服务器的响应
		xmlReq.onreadystatechange = function() {
			if (xmlReq.readyState == 4) {// 判断对象状态是否完成
				if (xmlReq.status == 200) { // 信息已经成功返回
					var xmltext = xmlReq.responseText;// 得到返回的数据
					alert(xmltext);
					if (xmltext != '修改失败，格式不正确或者用户名已存在，请重新输入') {// 说明修改成功，则跳转到登录界面重新登录
						window.location.href = "http://localhost:8080/ssmProject_tb/login.action";// 跳转到登录界面
					}
				}
			}
		}

	}
}
// 删除我的贴文
function delTbTw(tw_id, action) {
	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq
			.open("post",
					"http://localhost:8080/ssmProject_tb/delTbTw.action?tw_id="
							+ tw_id, true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	// 3.发送数据
	xmlReq.send(null); // 因为采用的是get方法，所以方法为null

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.readyState == 4) {// 判断对象状态是否完成
			if (xmlReq.status == 200) { // 信息已经成功返回
				if (action == 'showTwList') {// 在分类列表直接删除
					location.reload(true);// 刷新当前页面
				} else {
					location.replace(document.referrer)// 跳转到上一个页面并刷新该页面
				}
				alert("删除成功");
			}
		}
	}
}

// 关注或取消关注当前贴吧的作者
function functionAttention(user1_name, user2_name) {
	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq.open("POST",
			"http://localhost:8080/ssmProject_tb/functionAttention.action",
			true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("user1_name=" + encodeURI(user1_name) + "&user2_name="
			+ encodeURI(user2_name));

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 信息已经成功返回
			// 并且返回的信息被编译成功
			var xmltext = xmlReq.responseText;// 得到返回的数据
			
			var map = eval("(" + xmltext + ")");// 解析json对象;
			var message = map.message;
			var attention_id = map.attention_id;
			
			$("#input_functionAttention").val(map.message);// 将返回的数据局部刷新插入到页面

			// 执行关注功能时，websocket调用的对应方法
			if (message == '已关注') {
				var action = "attention|" + user2_name + "|" + user1_name+"|"+attention_id;// user2_name为被关注的人,user1_name为执行关注的人

				websocket.send(action);// 发送执行命令和消息数据给服务器
			}
		}
	}
}

// 个人页面中取消关注作者
function person_cancelAttention(user1_name, user2_name) {

	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq
			.open(
					"POST",
					"http://localhost:8080/ssmProject_tb/person_cancelAttention.action",
					true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("user1_name=" + encodeURI(user1_name) + "&user2_name="
			+ encodeURI(user2_name)); // 因为采用的是get方法，所以方法为null

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 信息已经成功返回
			// 并且返回的信息被编译成功
			var xmltext = xmlReq.responseText;// 得到返回的数据

			xmltext = eval('(' + xmltext + ')')// 解析后台传回的map数据

			document.getElementById("list_myAttention").innerHTML = xmltext['table_myAttentions']// 将返回的数据局部刷新插入到页面
			document.getElementById("count_my_gz").innerHTML = xmltext['count_myAttention'];
		}
	}
}

// 删除消息
function delMsg(tb_msg) {
	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq.open("POST", "http://localhost:8080/ssmProject_tb/delMsg.action",
			true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("tb_msg=" + encodeURI(tb_msg)); // 因为采用的是get方法，所以方法为null

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 满足条件
			// 表示信息被接受且已经成功返回
			var xmltext = xmlReq.responseText;// 得到返回的数据

			$("#show_comment" + comment_id).empty();
		}
	}
}

// 发表评论
function doComment(tw_id, comment_id, user_name, incomment_id) {
	if (incomment_id == 0) {// 说明为直接评论
		var comment_context = $("#comment_context").val();// 得到直接评论框中的评论内容
	} else {// incomment_id不为0则说明为回复评论
		var comment_context = $("#incomment_context" + comment_id + "").val();// 得到我要回复评论输入框中的内容
	}

	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq.open("POST", "http://localhost:8080/ssmProject_tb/doComment.action",
			true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("tw_id=" + encodeURI(tw_id) + "&user_name="
			+ encodeURI(user_name) + "&comment_context="
			+ encodeURI(comment_context) + "&incomment_id="
			+ encodeURI(incomment_id));

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 信息已经成功返回
			// 并且返回的信息被编译成功
			var xmltext = xmlReq.responseText;// 得到返回的数据
			var dataObj = JSON.parse(xmltext)// 将得到的json格式转换成Object类型
			var message = dataObj.message;
			var new_comment_id = dataObj.comment_id;// 得到评论的id

			if (message != "发表评论失败") {

				alert("评论成功")

				if (incomment_id == 0) {// 为直接评论 则在id为comment_ul的地方直接写入html
					$("#comment_ul").prepend(message);

				} else {// 为回复评论
					// 得到要插入div的父节点li
					var parentNode_li = document.getElementById("show_comment"
							+ comment_id);

					// 判断该父节点下面是否有子节点
					if (parentNode_li.hasChildNodes() != null) {// 存在子节点
						del_ff(parentNode_li);// 清理空格

						var li_firstChild = parentNode_li.firstChild;// 获得子节点的第一个子节点

						var newNode = document.createElement("div");
						newNode.innerHTML = message;
						newNode.style = "margin-left:40px";
						newNode.id = "show_comment" + new_comment_id;

						parentNode_li.insertBefore(newNode,// 插入新的子节点
						li_firstChild.nextSibling);

					} else {// 该评论下面没有回复评论 则可直接插入子节点
						parentNode_li.prepend("<div id='show_comment"
								+ new_comment_id
								+ "' style='margin-left:40px;'>" + message
								+ "</div>");
					}

					$("#incomment_context" + comment_id).val("");

				}

				$("#comment_context").val("");
			} else {
				alert("评论失败");
			}
		}
	}
}
// 清空父节点下面为空的子节点
function del_ff(elem) {
	var elem_child = elem.childNodes;
	for (var i = 0; i < elem_child.length; i++) {
		if (elem_child[i].nodeName == "#text"
				&& !/\s/.test(elem_child.nodeValue)) {
			elem.removeChild(elem_child)
		}
	}
}

// 点击回复评论按钮 弹出输入框
function insert_inputComment(tw_id, comment_id, writer, incomment_id) {
	// comment_id用来设置input的id命名
	// incomment_id用来设置是对那一条评论进行评论
	document.getElementById("insert_inputComment" + comment_id).innerHTML = "<input id='incomment_context"
			+ comment_id
			+ "\' placeholder='请输入' />"
			+ "<button onclick='doComment("
			+ tw_id
			+ ","
			+ comment_id
			+ ",\""
			+ writer + "\"," + comment_id + ")'>发表评论</button>"
}

// 退出贴吧
function quitTb() {
	if (confirm('您确定要退出贴吧吗?')) {
		// this.websocket.close();// 让客户端与服务器断开连接

		window.location.href = "http://localhost:8080/ssmProject_tb/quitLogin.action"
	}
}
// 系统自动退出贴吧
function auto_quitTb() {

	var xmlReq = createXMLHttpRequest();

	xmlReq.open("GET", "http://localhost:8080/ssmProject_tb/quitLogin.action",
			true);// 有GTE和POST方法，中间代表连接路径，true代表异步

}

// 注册
function doRegister() {
	var user_name = document.getElementById("username").value
	var user_pwd = document.getElementById("password").value
	var user_sex = $('input:radio[name="user_sex"]:checked').val()

	if (confirm("确认注册吗？")) {

		// 1.创建XMLHttpRequest对象
		var xmlReq = createXMLHttpRequest();

		xmlReq.open("POST",
				"http://localhost:8080/ssmProject_tb/doRegister.action", true);// 有GTE和POST方法，中间代表连接路径，true代表异步

		xmlReq.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

		// 3.发送数据
		xmlReq.send("user_name=" + encodeURI(user_name) + "&user_pwd="
				+ encodeURI(user_pwd) + "&user_sex=" + encodeURI(user_sex)); // 因为采用的是get方法，所以方法为null

		// 4.接收服务器的响应
		xmlReq.onreadystatechange = function() {
			if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 满足条件表示信息被接受且已经成功返回
				var xmltext = xmlReq.responseText;// 得到返回的数据

				alert(xmltext);

				if (xmltext == "注册成功") {
					window.location.href = "http://localhost:8080/ssmProject_tb/login.action";
				}
			}
		}
	}
}

// 表单验证 判断是否可以正常提交表单
function do_verify(name) {
	if (cf_delComment()) {
		if (name = 'send_tb') {// 发帖的表单验证
			var tbTitle = $("#tbTitle").val();
			var tbArtical = $("#tbArtical").val();

			if ((tbTitle != null && tbTitle != "")
					&& (tbArtical != null && tbArtical != "")) {
				alert("发表成功");
				return true;
			} else {
				alert("发表失败,标题或正文内容不能为空，请重新输入");
				return false;
			}
		}
	}

	return false;
}

// 判断是否执行当前操作
function cf_delComment() {
	if (confirm('确定执行该操作吗?')) {
		return true;
	}
	return false;
}

// 删除评论
function delComment(comment_id) {
	// 1.创建XMLHttpRequest对象
	var xmlReq = createXMLHttpRequest();
	// 2.打开和服务器端的连接
	xmlReq.open("POST",
			"http://localhost:8080/ssmProject_tb/delComment.action", true);// 有GTE和POST方法，中间代表连接路径，true代表异步

	xmlReq
			.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");// 因为请求方式为POST,所以这里要设置请求头.(如果请求方式为GET,此句代码可以省略)

	// 3.发送数据
	xmlReq.send("comment_id=" + encodeURI(comment_id)); // 因为采用的是get方法，所以方法为null

	// 4.接收服务器的响应
	xmlReq.onreadystatechange = function() {
		if (xmlReq.status == 200 && xmlReq.readyState == 4) { // 满足条件
			// 表示信息被接受且已经成功返回
			var xmltext = xmlReq.responseText;// 得到返回的数据

			alert("删除成功");

			$("#show_comment" + comment_id).empty();
		}
	}
}
