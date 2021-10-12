<%@ page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/detail_tb.css" />
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js" />

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

<title>饭团儿贴吧</title>
</head>

<body onload="jsp_main('${sessionScope.user_name}')">
	<input id="login_userName" type="hidden"
		value="${sessionScope.user_name}" />
	<!-- 用来存放当前登录对象的用户名 -->

	<!--一键返回和一件发帖定位-->
	<div id="new">
		<div id="edit">
			<a href="#t"><span class="glyphicon glyphicon-edit"></span></a>
		</div>
		<div id="return">
			<a href="#head"><span class="glyphicon glyphicon-chevron-up"></span></a>
		</div>
	</div>
	<!--一键返回和一件发帖定位结束-->
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

	<div class="container" id="all">
		<div id="img">
			<img src="img/timg.jpg" class="img-thumbnail" />
		</div>
		<div id="content">
			<h2 id="show_title"><%=session.getAttribute("sort")%>
			</h2>
			<button type="button" class="btn btn-danger">+关注</button>
			<div id="font">
				<font color="#AAA"> 关注： <font color="#ff7f3e">12345</font>&nbsp;&nbsp;&nbsp;
					贴子： <font color="#ff7f3e">12345</font>
				</font>
			</div>
			<div id="tb_describe">神秘的月球，美好的传说，地球的卫士。(贴吧描述)</div>
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
				<a href="#modal-container-487660" data-toggle="modal"><font
					color="red">更多未读消息...</font></a>
			</center>
		</div>

		<!-- 消息盒子的模态框 -->
		<div class="modal fade" id="modal-container-487660" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">我的消息</h4>
					</div>
					<div class="modal-body" id="list_myAttention">
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

		<div class="row clearfix" id="two">
			<div class="col-md-12 column">
				<div class="row clearfix">
					<div class="col-md-9 column">
						<ul class="list-group">
							<li class="list-group-item" id="see">
								<h3>看帖</h3>
							</li>
							<li class="list-group-item">
								<div id="my_article">
									<table>
										<c:forEach items="${tbtw }" var="tbtw_value">
											<td>
											<tr>
												<span style="font-size: 35px; font-weight: bold;">${tbtw_value.tw_title }</span>
												<c:if test="${tbtw_value.user_name eq user_name}">
													<a style="float: right; margin-top: 12px;"
														href="javascript:delTbTw(${tbtw_value.tw_id},'${action }');"
														onclick="return cf_delComment()">删贴</a>
												</c:if>
											</tr>
											<tr>
												<h4>
													<label>作者：</label> <a
														href="http://localhost:8080/ssmProject_tb/personal.action?user2_name=${tbtw_value.user_name }">${tbtw_value.user_name }</a>
													<c:if
														test="${tbtw_value.user_name ne user_name and action eq 'showDetailTw'}">
														<input id="input_functionAttention" type="button"
															onclick="functionAttention('${user_name }','${tbtw_value.user_name}')"
															class="btn-danger" value="${isAttention }" />
													</c:if>
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
											<!-- 通过if判断是否为详情页面来设置显示的img大小 -->
											<c:if
												test="${action eq 'showTwList'&&not empty tbtw_value.tw_img}">
												<tr>
													<img style="margin-top: 18px; display: block;"
														src="${tbtw_value.tw_img }" alt="" width="125px"
														height="90px" />
												</tr>
											</c:if>

											<c:if test="${action eq 'showDetailTw' }">
												<tr>
													<img
														style="padding-top: 20px; margin: auto; display: block;"
														src="${tbtw_value.tw_img }" alt="" width="60%"
														height="60%" />
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
											<c:if test="${action eq 'showTwList' }">
												<tr>
													<a
														href="javascript:showDetailTw(${tbtw_value.tw_id },'${tbtw_value.user_name }')">
														查看详情</a>
													<br>
												</tr>
											</c:if>

											<c:if test="${action eq 'showDetailTw' }">
												<tr>
													<input type="text" id="comment_context" placeholder="请输入" />
													<input type="button" value="发表评论"
														onclick="doComment('${tbtw_value.tw_id}',-1,'${user_name}',0)" />
													</div>
													<br>
												</tr>
											</c:if>
											</td>
										</c:forEach>
									</table>
								</div>
							</li>
						</ul>

						<div id="show_allComment">
							<ul style="list-style: none;" id="comment_ul">
								${show_allComment }
							</ul>
							<!--分页按钮-->
							<div id="pagination">
								<center>
									<nav aria-label="Page navigation">
										<ul class="pagination" id="sumPage">${pagingButton }
										</ul>
									</nav>
								</center>
							</div>
						</div>

						<!--分页按钮-->
						<div id="pagination">
							<center>
								<nav aria-label="Page navigation">
									<ul class="pagination" id="sumPage">${pagingCommentButton }
									</ul>
								</nav>
							</center>
						</div>

						<!--页尾-->
						<div class="final">
							<center>
								<ol class="breadcrumb">

									<li>@2019 FanTuaner&nbsp; <a href="#">使用饭团儿前必读</a>
									</li>
									<li><a href="#">贴吧协议</a></li>
									<li><a href="#">隐私权限</a></li>
									<li><a href="#">投诉反馈</a></li>
									<li class="active">信息网络传播试听节目许可证&nbsp;0110516</li>
								</ol>
							</center>
						</div>
						<!--页尾结束-->
					</div>

					<script type="text/javascript" src="./js/myJs.js"></script>
</body>

</html>