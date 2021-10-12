<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/personal.css" />
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

<style type="text/css">
#winpop {
	width: 250px;
	height: 0px;
	position: absolute;
	right: 0;
	bottom: 0;
	border: 1px solid grey;
	margin: 0;
	padding: 1px;
	overflow: hidden;
	display: none;
	background: #FFFFFF
}

#winpop .title {
	width: 100%;
	height: 20px;
	line-height: 20px;
	background: #0AB0FF;
	font-weight: bold;
	text-align: center;
	font-size: 12px;
	color: white
}

#winpop .con {
	width: 100%;
	height: 360px;
	line-height: 80px;
	font-weight: bold;
	font-size: 12px;
	color: #FF0000;
	text-decoration: underline;
	text-align: center
}

.close {
	position: absolute;
	right: 4px;
	top: -1px;
	color: #FFFFFF;
	cursor: pointer
}
</style>

<title>我的主页</title>
</head>

<body id="bg" onload="jsp_main('${sessionScope.user_name}')">

	<!-- 头部的导航条 -->
	<div id="head" style="margin-left: -350px">
		<div id="logo">
			<a href="main.action"> <img src="img/ft.jpg" /> <img
				src="img/logo.jpg" />
			</a>
		</div>
		<div id="doSearch">
			<input type="text" class="form-control" placeholder="请输入贴吧名">
			<input type="button" class="btn" value="搜索贴吧" /> <input
				style="margin-top: -100px" type="button" class="btn btn-inverse"
				value="所有贴吧" />
			<div id="advanced" style="margin-top: -15px">
				<a href="advanced_search.jsp">高级搜索</a>
			</div>
		</div>
	</div>

	<input id="login_userName" type="hidden"
		value="${sessionScope.user_name}" />
	<!-- 用来存放当前登录对象的用户名 -->

	<div class="container" id="container">
		<div id="img">
			<img src="img/timg.jpg" class="img-thumbnail" />
		</div>

		<!-- 设置页面右下角的消息弹窗 -->
		<div id="winpop">
			<div class="title">
				系统信息<br> <span class="close" οnclick="tips_pop()">X</span>
			</div>

			<!-- 点击信息标题链接到信息明细，传递信息编号参数 -->
			<center>
				<p id="newMessage" style="color: black;"></p>
				<br>
			</center>

			<center>
				<!-- 点击查看更多未读消息 -->
				<a href="#modal-container-4876601" data-toggle="modal"><font
					color="red">更多未读消息...</font></a>
			</center>
		</div>

		<!-- 我的模态框 -->
		<div class="modal fade" id="modal-container-4876601" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title">我的消息</h4>
					</div>
					<div class="modal-body" id="myModalLabel">
						<table class="table table-hover" align="center">
							<tr>
								<th></th>
								<th></th>
								<th></th>
							</tr>
						</table>
					</div>

				</div>
			</div>
		</div>

		<div id="revise">
			<c:if test="${user_name == param.user2_name}">
				<a id="modal-19088" href="#modal-container-19088" role="button"
					class="btn btn-default" data-toggle="modal">编辑资料</a>
				<div class="modal fade" id="modal-container-19088" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">×</button>
								<h4 class="modal-title" id="myModalLabel">修改个人信息</h4>
							</div>

							<div class="modal-body">
								<div class="row clearfix">
									<div class="col-md-12 column">
										<div class="form-signin">
											<label for="exampleInputEmail1">我的姓名</label> <input
												type="text" id="user_name" value="${tbuser.user_name }"
												class="form-control" required autofocus /> <label
												for="exampleInputEmail1">我的性别</label><br> <label><input
												name="user_sex" type="radio" value="男" checked="checked" />男
											</label> <label><input name="user_sex" type="radio" value="女" />女
											</label><br> <label for="exampleInputEmail1">我的密码</label> <input
												id="user_pwd" type="password" name="password"
												class="form-control" value="${tbuser.user_pwd }" required />
											<div class="checkbox"></div>
											<button class="btn btn-lg btn-primary btn-block"
												onclick="updPerson('${user_name}')">提交</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>

		</div>
		<!--切换背景-->
		<div id="change">
			<!--<span class="glyphicon glyphicon-picture"></span>-->
			<a id="modal-130527" href="#modal-container-130527" role="button"
				class="btn" data-toggle="modal"><span
				class="glyphicon glyphicon-picture"></span></a>

			<div class="modal fade" id="modal-container-130527" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel">背景设置</h4>
						</div>
						<div class="modal-body">
							<!--<div class="container">-->
							<div class="row">
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_one">
										<img src="img/bg_v1_1001.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_two">
										<img src="img/bg_v1_1002.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_three">
										<img src="img/bg_v1_1003.jpg" class="img-thumbnail" />
									</div>
								</div>
								<!--</div>-->
							</div>
							</p>
							<div class="row">
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_four">
										<img src="img/bg_v1_1004.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_five">
										<img src="img/bg_v1_1005.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_six">
										<img src="img/bg_v1_1006.jpg" class="img-thumbnail" />
									</div>
								</div>
								<!--</div>-->
							</div>
							<div class="row">
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_seven">
										<img src="img/bg_v1_1007.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_eight">
										<img src="img/bg_v1_1008.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_nine">
										<img src="img/bg_v1_1009.jpg" class="img-thumbnail" />
									</div>
								</div>
								<!--</div>-->
							</div>
							<div class="row">
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_ten">
										<img src="img/bg_v1_1010.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_eleven">
										<img src="img/bg_v1_1011.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_twelve">
										<img src="img/bg_v1_1012.jpg" class="img-thumbnail" />
									</div>
								</div>
								<!--</div>-->
							</div>
							<div class="row">
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_thirteen">
										<img src="img/bg_v1_1013.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_fourteen">
										<img src="img/bg_v1_1014.jpg" class="img-thumbnail" />
									</div>
								</div>
								<div class="col-md-4 col-sm-6 col-xs-12">
									<div id="img_fifteen">
										<img src="img/bg_v1_1015.jpg" class="img-thumbnail" />
									</div>
								</div>
								<!--</div>-->
							</div>

						</div>
					</div>

				</div>

			</div>
		</div>
		<!--切换背景结束-->

		<div class="container" id="container_one">
			<div id="username_two">
				<%
					String personal_username = request.getParameter("user2_name");
					request.setAttribute("personal_username", personal_username);
				%>


				<h2>
					<c:if test="${user_name == requestScope.personal_username}">
					我的主页
					
					</c:if>

					<c:if test="${user_name != requestScope.personal_username}">
					${requestScope.personal_username }的主页
					<input id="input_functionAttention" type="button"
							onclick="functionAttention('${user_name }','<%=personal_username %>')"
							class="btn-danger" value="${isAttention }" />
					</c:if>
				</h2>


				<c:if test="${user_name != requestScope.personal_username}">
					<label>${requestScope.personal_username }的关注： </label>
				</c:if>

				<c:if test="${user_name == requestScope.personal_username}">
					<label>我的关注： </label>
				</c:if>

				<span id="count_my_gz">${count_myAttension }</span> <a
					id="modal-487660" href="#modal-container-487660" class="btn"
					data-toggle="modal"
					onclick="gainMyAttentionsOrFans(${list_myAttension })">查看</a>

				<div class="modal fade" id="modal-container-487660" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">×</button>
								<h4 class="modal-title" id="myModalLabel">我的关注</h4>
							</div>
							<div class="modal-body" id="list_myAttention">
								<table class="table table-hover" align="center">
									<tr>
										<th style="text-align: center">用户名</th>
										<th></th>
										<th></th>
									</tr>
									<!-- 遍历并显示我所关注的用户 -->
									<div id="table_attentionList">
										<c:forEach items="${list_myAttension}" var="item">
											<tr>
												<th style="text-align: center">${item.user2_name }</th>
												<th style="text-align: center"><a
													href="javascript:personal('${item.user2_name }');">查看主页</a></th>
												<c:if test="${user_name == item.user1_name }">
													<th style="text-align: center"><a
														href="javascript:person_cancelAttention('${item.user1_name }','${item.user2_name }')">取消关注</a>

													</th>
												</c:if>

											</tr>
										</c:forEach>
									</div>

								</table>
							</div>
						</div>
					</div>
				</div>


				<br>

				<c:if test="${user_name != requestScope.personal_username}">
					<label>${requestScope.personal_username }的粉丝： </label>
				</c:if>

				<c:if test="${user_name == requestScope.personal_username}">
					<label>我的粉丝： </label>
				</c:if>


				<span id="count_gz_me">${count_myFans }</span> <a id="modal-487661"
					href="#modal-container-487661" role="button" class="btn"
					data-toggle="modal"
					onclick="javascrip:gainMyAttentionsOrFans(${list_myFans})">查看</a>

				<div class="modal fade" id="modal-container-487661" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">×</button>
								<h4 class="modal-title" id="myModalLabel">我的粉丝</h4>
							</div>
							<div class="modal-body" id="list_myFans">
								<table class="table table-hover" align="center">
									<tr>
										<th style="text-align: center">用户名</th>
										<th></th>
									</tr>
									<c:forEach items="${list_myFans}" var="item">
										<tr>
											<th style="text-align: center">${item.user1_name }</th>
											<th style="text-align: center"><a
												href="javascript:personal('${item.user1_name }');">查看主页</a></th>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="other" style="margin-top: 0;">
				<h3>我的贴子</h3>
				<hr />
				<table>
					<c:forEach items="${my_tbtw_list }" var="tbtw_value">
						<td>
						<tr>
							<h2>${tbtw_value.tw_title }</h2>
						</tr>
						<tr>
							<h4>
								<label>作者：</label> ${tbtw_value.user_name }
							</h4>
						</tr>
						<tr>
							<!-- 显示文本内容 -->
							<!-- 将文本编辑中的回车符，在页面显示时依然以回车显示 -->
							<%
								request.setAttribute("vEnter", "\n");
							%>
							<span style="font-size: 18px;">${fn:replace(tbtw_value.tw_article,vEnter,"<BR/>") }</span>
							<br>
						</tr>
						<!-- 通过if判断来设置img -->
						<c:if
							test="${action eq 'showTwList'&&not empty tbtw_value.tw_img}">
							<tr>
								<img style="margin-top: 18px; display: block;"
									src="${tbtw_value.tw_img }" alt="" width="125px" height="90px" />
							</tr>
						</c:if>

						<c:if test="${action eq 'showDetailTw' }">
							<tr>
								<img style="padding-top: 20px; margin: auto; display: block;"
									src="${tbtw_value.tw_img }" alt="" width="70%" height="70%" />
							</tr>
						</c:if>
						<tr>
							<span style="font-size: 12px; float: right; margin: 15px">
								<fmt:formatDate value="${tbtw_value.tw_time}"
									pattern="yyyy-MM-dd　HH：mm" />
							</span>
							<br>
							<br>
						</tr>
						<!-- 显示贴吧的评论 -->
						<c:if test="${not empty tw_comment_list }">
							<tr>评论
							</tr>
						</c:if>
						<tr>
							<a
								href="javascript:showDetailTw(${tbtw_value.tw_id },'${tbtw_value.user_name }')">
								查看详情</a>
							<br>
						</tr>
					</c:forEach>
				</table>
			</div>

			<!--分页按钮-->
			<div id="pagination">
				<center>
					<nav aria-label="Page navigation">
						<ul class="pagination" id="paging">${pagingButton }
						</ul>
					</nav>
				</center>
			</div>

			<div class="final">
				<center>
					<ol class="breadcrumb" id='breadcrumb'>

						<li>@2019 FanTuaner&nbsp; <a href="#">使用饭团儿前必读</a>
						</li>
						<li><a href="#">贴吧协议</a></li>
						<li><a href="#">隐私权限</a></li>
						<li><a href="#">投诉反馈</a></li>
						<li class="active">信息网络传播试听节目许可证&nbsp;0110516</li>

					</ol>
				</center>
			</div>
		</div>

		<script>
			$("#head").load("head_navigation.jsp");
			$("body").load();
			window.onload = function() {

				var bg = document.getElementById("bg"), img_one = document
						.getElementById("img_one"), img_two = document
						.getElementById("img_two"), img_three = document
						.getElementById("img_three");
				img_five = document.getElementById("img_five");
				img_four = document.getElementById("img_four");
				img_six = document.getElementById("img_six");
				img_seven = document.getElementById("img_seven");
				img_eight = document.getElementById("img_eight");
				img_nine = document.getElementById("img_nine");
				img_ten = document.getElementById("img_ten");
				img_eleven = document.getElementById("img_eleven");
				img_twelve = document.getElementById("img_twelve");
				img_thirteen = document.getElementById("img_thirteen");
				img_fourteen = document.getElementById("img_fourteen");
				img_fifteen = document.getElementById("img_fifteen");
				img_one.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1001.jpg)  0 120px no-repeat";
				}
				img_two.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1002.jpg)  0 120px no-repeat";
				}
				img_three.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1003.jpg)  0 120px no-repeat";
				}
				img_four.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1004.jpg)  0 120px no-repeat";
				}
				img_five.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1005.jpg)  0 120px no-repeat";
				}
				img_six.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1006.jpg)  0 120px no-repeat";
				}
				img_seven.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1007.jpg)  0 120px no-repeat";
				}
				img_eight.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1008.jpg)  0 120px no-repeat";
				}
				img_nine.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1009.jpg)  0 120px no-repeat";
				}
				img_ten.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1010.jpg)  0 120px no-repeat";
				}
				img_eleven.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1011.jpg)  0 120px no-repeat";
				}
				img_twelve.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1012.jpg)  0 120px no-repeat";
				}
				img_thirteen.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1013.jpg)  0 120px no-repeat";
				}
				img_fourteen.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1014.jpg)  0 120px no-repeat";
				}
				img_fifteen.onclick = function() {
					bg.style.background = "URL(img/bg_v1_1015.jpg)  0 120px no-repeat";
				};
			}
		</script>

		<script type="text/javascript" src="./js/myJs.js"></script>
</body>

</html>