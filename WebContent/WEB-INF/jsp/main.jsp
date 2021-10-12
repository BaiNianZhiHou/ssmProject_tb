<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>饭团儿贴吧</title>

<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="css/main.css" />
<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="js/updateimg.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

<style type="text/css">
#winpop {
	width: 250px;
	height: 0px;
	position: fixed;
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

</head>

<body onload="jsp_main('${sessionScope.user_name}')">
	<input id="login_userName" type="hidden"
		value="${sessionScope.user_name}" />
	<!-- 用来存放当前登录对象的用户名 -->

	<div class="container">
		<!--页头-->
		<div id="head">
			<div id="logo">
				<img src="img/ft.jpg" /> <img src="img/logo.jpg" />
			</div>
			<div id="doSearch">
				<input type="text" class="form-control" placeholder="请输入贴吧名">
				<input type="button" class="btn" value="搜索贴吧" /> <input
					type="button" class="btn btn-inverse" value="所有贴吧" />
				<div>
					<a href="advanced_search.jsp">高级搜索</a>
				</div>
			</div>
		</div>
		<!--页头结束-->
		<div id="contain_tb">

			<!--大轮播图-->
			<div id="first" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#first" data-slide-to="0" class="active"></li>
					<li data-target="#first" data-slide-to="1"></li>
					<li data-target="#first" data-slide-to="2"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox" id="rotation_imgs">
					<div class="item active">
						<div id="img1">
							<img src="img/lb1.jpg">
						</div>
						<div class="carousel-caption">
							<h3>
								<a href="#">忍住！2019想去的地方</a>
							</h3>
						</div>
					</div>
					<div class="item">
						<div id="img2">
							<img src="img/lb2.jpg">
						</div>
						<div class="carousel-caption">
							<h3>
								<a href="#">来了！一起预约2019年景区</a>
							</h3>
						</div>
					</div>
					<div class="item">
						<div id="img3">
							<img src="img/lb3.jpg">
						</div>
						<div class="carousel-caption">
							<h3>
								<a href="#">新技能get！爱摄影</a>
							</h3>
						</div>
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#first" role="button"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#first" role="button"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			<!--大轮播图结束-->

			<!--个人中心块及贴吧数块-->
			<div id="second">
				<div id="mine_msg">
					<ul class="list-group" id="second_one">
						<li class="list-group-item"><img src="img/timg.jpg"
							id="tb_img1">
							<div id="second_two">
								<c:set var="username" value="${sessionScope.username}" />
								<c:out value="欢迎您：${user_name}" default="未登录" />
							</div>
							<div id="show_sum_tb">当前在线人数：</div> <span>消息盒子：<a
								id="messageBox" href="#modal-container-487660"
								data-toggle="modal">${myMsgCount}</a>条
						</span> <!-- 消息盒子的模态框 -->
							<div class="modal fade" id="modal-container-487660" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">×</button>
											<h4 class="modal-title" id="myModalLabel">我的消息</h4>
										</div>
										<div class="modal-body" id="myMsgs"
											style="height: 400px; overflow-y: scroll;">
											<table id="msgBoxId" class="table table-hover" align="center">
												<c:forEach items="${myMsgList}" var="item">
													<tr>
														<td style="text-align: center">${item.msg_contain }</td>
														<td style="text-align: center"><a
															style="color: #97CBFF;"
															href="javascript:delMsg(${item.tb_msg })">删除</a></td>
													</tr>
												</c:forEach>
											</table>
											<!--分页按钮-->
											<div id="pagination">
												<center>
													<nav aria-label="Page navigation">
													<ul class="pagination" id="sumPage">${msgPagingButton }
													</ul>
													</nav>
												</center>
											</div>
										</div>

									</div>
								</div>
							</div>



							<div id="personal">
								<form action="personal.action" method="get">
									<input type="hidden" value="${user_name }" name="user2_name" />
									<input type="submit" value="个人中心" id="personal_one"
										class="btn btn-default" />
								</form>
							</div>
							<div id="send_t">
								<form action="send_tb_main.action" method="get">
									<input type="hidden" value="send_tb" name="act" /> <input
										type="submit" value="我要发帖" id="send_t_one"
										class="btn btn-default" />
								</form>
							</div>
							<div id="exit">

								<input type="button" value="退出贴吧" id="exit_one"
									class="btn btn-default" onclick="quitTb()" />

							</div></li>
					</ul>
					<ul class="list-group" id="show_sum_tb_one">
						<li class="list-group-item">
							<div id="img">
								<img src="img/img.png" id="tb_img" />
							</div>
							<div id="total_img">
								<div id="total1">
									<img src="img/img1.png" />
								</div>
								<div id="tb_font">
									<center>
										<font face="agency fb" size="5">${countTw }</font>
									</center>
								</div>
								<div id="total2">
									<img src="img/img2.png" />
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!--个人中心块及贴吧数块结束-->

			<!--推荐贴吧文字版及轮播图版-->
			<div id="recommond_tbs">
				<div id="recommond1">
					<ul class="list-group">
						<li class="list-group-item">
							<h3>推荐吧</h3>
							<div id="tj_tb1">
								<div id="tj_tb">
									<img src="img/tj.png" />
								</div>
								<div id="tj_bm">
									<a href="#">剑三吧</a>
								</div>
								<div id="tj_bmms">
									<center>你是剑网3玩家吗？那就来吧！我们自己的家</center>
								</div>
								<div id="read_logo">
									<center>
										<img src="img/read.png" /> <font>12</font>
									</center>
								</div>
							</div>
							<div id="tj_tb2">
								<div id="tj_tb">
									<img src="img/tj.png" />
								</div>
								<div id="tj_bm1">
									<a href="#">悬疑吧</a>
								</div>
								<div id="tj_bmms">
									<center>悬念、疑惑，诡计背后的真相将出乎意料</center>
								</div>
								<div id="read_logo">
									<center>
										<img src="img/read.png" /> <font>15</font>
									</center>
								</div>
							</div>
							<div id="tj_tb3">
								<div id="tj_tb">
									<img src="img/tj.png" />
								</div>
								<div id="tj_bm2">
									<a href="#">steam吧</a>
								</div>
								<div id="tj_bmms">
									<center>国内最大的STEAM游戏平台讨论社群之一</center>
								</div>
								<div id="read_logo">
									<center>
										<img src="img/read.png" /> <font>10</font>
									</center>
								</div>
								<br>
							</div>
							<h3>搭配音乐阅读极佳</h3>

							<div id="recommond2" class="carousel slide" data-ride="carousel">
								<!-- Indicators -->
								<ol class="carousel-indicators">
									<li data-target="#recommond2" data-slide-to="0" class="active"></li>
									<li data-target="#recommond2" data-slide-to="1"></li>
									<li data-target="#recommond2" data-slide-to="2"></li>
									<li data-target="#recommond2" data-slide-to="3"></li>
								</ol>

								<!-- Wrapper for slides -->
								<div class="carousel-inner" role="listbox" id="rotation_imgs">
									<div class="item active">
										<div id="img1">
											<img src="img/tb_img1.jpg" />
										</div>
										<div class="carousel-caption">
											<h3>
												<a href="#">小说吧</a>
											</h3>
										</div>
									</div>
									<div class="item">
										<div id="img2">
											<img src="img/tb_img2.jpg" />
										</div>
										<div class="carousel-caption">
											<h3>
												<a href="#">摄影吧</a>
											</h3>
										</div>
									</div>
									<div class="item">
										<div id="img3">
											<img src="img/tb_img3.jpg" />
										</div>
										<div class="carousel-caption">
											<h3>
												<a href="#">治愈吧</a>
											</h3>
										</div>
									</div>
									<div class="item">
										<div id="img3">
											<img src="img/tb_img4.jpg" />
										</div>
										<div class="carousel-caption">
											<h3>
												<a href="#">爱笑吧</a>
											</h3>
										</div>
									</div>
								</div>

								<!-- Controls -->
								<a class="left carousel-control" href="#recommond2"
									role="button" data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
									<span class="sr-only">Previous</span>
								</a> <a class="right carousel-control" href="#recommond2"
									role="button" data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!--推荐贴吧文字版及轮播图版结束-->

			<!--贴吧分类-->
			<div id="third">
				<div id="sort_tb">

					<ul class="list-group">
						<li id="titlie" class="list-group-item">
							<h4>
								<font color="#000000">贴吧分类</font>
							</h4>
							<hr /> <span class="glyphicon glyphicon-star"></span> 娱乐天地
							</p> <a
							href="http://localhost:8080/ssmProject_tb/showSortTw.action?tw_sort=娱乐明星&showPage=1">娱乐明星</a>
							<a href="#">&nbsp;&nbsp;&nbsp;内地明星</a>
							</p> <a href="#">韩国明星</a> <a href="#">&nbsp;&nbsp;&nbsp;日本明星</a> <a
							href="#">&nbsp;&nbsp;&nbsp;时尚人物</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-expand"></span> 我爱生活
							</p> <a
							href="http://192.168.43.51:8080/project_tb/UseTbServlet?act=showSort&sort=live&showPage=1">生活</a>
							<a href="#">&nbsp;&nbsp;&nbsp;生活趣味</a>
							</p> <a href="#">生活家</a> <a href="#">&nbsp;&nbsp;&nbsp;聚餐</a> <a
							href="#">&nbsp;&nbsp;&nbsp;每天一乐</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-film"></span> 看电影
							</p> <a href="#">香港电影</a> <a href="#">&nbsp;&nbsp;&nbsp;欧美电影</a> <a
							href="#">&nbsp;&nbsp;&nbsp;内地电影</a>
							</p> <a href="#">韩国电影</a> <a href="#">&nbsp;&nbsp;&nbsp;日本电影</a> <a
							href="#">&nbsp;&nbsp;&nbsp;台湾电影</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-book"></span> 小说
							</p> <a href="#">奇幻</a> <a href="#">&nbsp;&nbsp;&nbsp;言情</a> <a
							href="#">&nbsp;&nbsp;&nbsp;异灵</a> <a href="#">&nbsp;&nbsp;&nbsp;穿越</a>
							<a href="#">&nbsp;&nbsp;&nbsp;连载</a>
							</p> <a href="#">修真</a> <a href="#">&nbsp;&nbsp;&nbsp;历史</a> <a
							href="#">&nbsp;&nbsp;&nbsp;架空文</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-home"></span> 生活家
							</p> <a href="#">小而美</a> <a href="#">&nbsp;&nbsp;&nbsp;DIY</a> <a
							href="#">&nbsp;&nbsp;&nbsp;美食</a> <a href="#">&nbsp;&nbsp;&nbsp;摄影</a>
							<a href="#">&nbsp;&nbsp;&nbsp;旅行</a>
							</p> <a href="#">变美</a> <a href="#">&nbsp;&nbsp;&nbsp;留学移民</a> <a
							href="#">&nbsp;&nbsp;&nbsp;文玩</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-map-marker"></span> 地区
							</p> <a href="#">山东</a> <a href="#">&nbsp;&nbsp;&nbsp;河北</a> <a
							href="#">&nbsp;&nbsp;&nbsp;河南</a> <a href="#">&nbsp;&nbsp;&nbsp;山西</a>
							<a href="#">&nbsp;&nbsp;&nbsp;江苏</a>
							</p> <a href="#">辽宁</a> <a href="#">&nbsp;&nbsp;&nbsp;四川</a> <a
							href="#">&nbsp;&nbsp;&nbsp;广东</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-globe"></span> 人文自然
							</p> <a href="#">艺术</a> <a href="#">&nbsp;&nbsp;&nbsp;军事</a> <a
							href="#">&nbsp;&nbsp;&nbsp;历史</a> <a href="#">&nbsp;&nbsp;&nbsp;自然</a>
							</p> <a href="#">鉴赏收藏</a> <a href="#">&nbsp;&nbsp;&nbsp;民族文化</a> <a
							href="#">&nbsp;&nbsp;&nbsp;语言文化</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-education"></span> 高校
							</p> <a href="#">北京院校</a> <a href="#">&nbsp;&nbsp;&nbsp;山东院校</a> <a
							href="#">&nbsp;&nbsp;&nbsp;江苏院校</a>
							</p> <a href="#">四川院校</a> <a href="#">&nbsp;&nbsp;&nbsp;湖北院校</a> <a
							href="#">&nbsp;&nbsp;&nbsp;河北院校</a>
							</p>
							<hr /> <span class="glyphicon glyphicon-piggy-bank"></span> 闲.趣
							</p> <a href="#">萌宠</a> <a href="#">&nbsp;&nbsp;&nbsp;萝莉</a> <a
							href="#">&nbsp;&nbsp;&nbsp;重口味</a> <a href="#">&nbsp;&nbsp;&nbsp;吐槽</a>
							<a href="#">&nbsp;&nbsp;&nbsp;恐怖</a>
							</p> <a href="#">星座</a> <a href="#">&nbsp;&nbsp;&nbsp;爆料</a> <a
							href="#">&nbsp;&nbsp;&nbsp;爆料</a>
							</p>
						</li>
						</p>
					</ul>
				</div>
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

			<!--贴吧分类结束-->
			<div id="fix">
				<!--贴吧热议榜-->
				<div id="four">
					<div id="hot_tb_list">
						<ul class="list-group">
							<li class="list-group-item" id="titlie">
								<h4>
									<font color="#000000">贴吧热议榜</font>
								</h4>
							</li>
							<li class="list-group-item" id="hot_content"><span
								class="glyphicon glyphicon-heart"></span> <a href="#">&nbsp;嫦娥四号着陆月球表面</a>
								</p> <span class="glyphicon glyphicon-heart"></span> <a href="#">&nbsp;苹果架暴跌</a>
								</p> <span class="glyphicon glyphicon-heart"></span> <a href="#">&nbsp;南北方人谁更抗冻</a>
								</p> &nbsp;&nbsp;4 <a href="#">&nbsp;20个人能打过老虎吗</a>
								</p>
								</p> &nbsp;&nbsp;5 <a href="#">&nbsp;马刺大胜猛龙</a>
								</p> &nbsp;&nbsp;6 <a href="#">&nbsp;权健被立案侦查</a>
								</p> &nbsp;&nbsp;7 <a href="#">&nbsp;男子年会饮酒死亡</a>
								</p> &nbsp;&nbsp;8 <a href="#">&nbsp;王佳豪加盟英超狼队</a>
								</p> &nbsp;&nbsp;9 <a href="#">&nbsp;火锅店招服务员要985</a>
								</p> &nbsp;10 <a href="#">小米折叠手机</a>
								</p>
								</p></li>
						</ul>
						<!--贴吧热议榜结束-->

						<!--贴吧娱乐-->
						<ul class="list-group" id="four_one">
							<li class="list-group-item">
								<h4>
									<font color="#000000">贴吧娱乐</font>
								</h4>
							</li>
							<li class="list-group-item" id="four_one1"><img
								src="img/ef64e6950473ec62017b5eefcccf3038.jpg"
								id="tb_entertainment" />
								</p> <span class="glyphicon glyphicon-heart-empty"></span> <a
								href="#">冯绍峰赵丽颖粉红记事</a>
								</p> <span class="glyphicon glyphicon-heart-empty"></span> <a
								href="#">火箭少女101的惊变24小时</a>
								</p> <span class="glyphicon glyphicon-heart-empty"></span> <a
								href="#">八位一线当红小生，格局渐稳</a>
								</p></li>
						</ul>
						<!--贴吧娱乐结束-->

						<!--公告板-->
						<ul class="list-group" id="four_two">
							<li class="list-group-item">
								<h4>
									<font color="#000000">公告板</font>
								</h4>
							</li>
							<li class="list-group-item"><img src="img/Notice.jpg"
								id="tb_entertainment" />
								</p> <a href="#">贴吧开展违法赌博专项清理活动</a>
								</p> <a href="#">关于伪造、变造买卖居民身份证相关信息打击处理公告</a>
								</p></li>
						</ul>
						<!--公告板结束-->
					</div>
				</div>
			</div>
			<!--热门动态及个性动态-->
			<div id="show_contain_tb">
				<div class="row clearfix">
					<div class="col-md-12 column">
						<div class="tabbable" id="tabs-358408">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#panel-789588"
									data-toggle="tab">热门动态</a></li>
								<li><a href="#panel-969420" data-toggle="tab">个性动态</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="panel-789588">
									<ul class="list-group">
										<li class="list-group-item">
											<h3>
												<a>DIY吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【DIY】一"梳"定情！过程虐身的心意之作</font>
										</a>
											</p> 先上成品图
											</p> <img src="img/diy_one.jpg" id="tb_entertainment" /> <img
											src="img/diy_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												花花&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 17</font>
										</li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>悬疑吧</a>
											</h3>
										</li>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】恐怖故事也需要高情商！你看懂几个？</font>
										</a>
											</p> 一、诅咒 我终于从某处获得了传说中的“诅咒真书”。<br>
											&nbsp;&nbsp;翻开来，里头第一句话就是：“若按照本书中所记载的步骤实施，便可成功的咒杀你所憎恶的对象，但若步骤有一丁点差错，那么这个咒杀令便会反噬到施咒者身上！即便如此你仍要继续吗？”<br>废话！我就是因为有个绝对饶恕不得的仇人，所以才费尽千辛万苦拿到这本诅咒真书。<br>
											&nbsp;&nbsp;我开始阅读并实行书上的指令：<br>
											&nbsp;&nbsp;“1.请先闭上你的眼睛，专心回想你想要咒杀的对象的脸。”<br>
											&nbsp;&nbsp;那家伙的脸……我想忘也忘不了的，立刻闭上眼回想他的面容特征，再来是什么呢？<br>
											&nbsp;&nbsp;“2.接着请仔细想像他的死亡方式。”<br>
											&nbsp;&nbsp;我立刻把脑海中所有能想到的痛苦的死法都回想了一遍，再来呢？<br>
											&nbsp;&nbsp;“3.最后请睁开眼睛。”<br> &nbsp;&nbsp;请问：咒杀成功了吗？<br>
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												华夏好男人&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 30</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>steam吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【游戏】《古剑奇谭三•梦付千秋星垂野》通关评价</font>
										</a>
											</p> <img src="img/steam_two.jpg" id="tb_entertainment" /> <img
											src="img/steam_one.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												九艘跳周可儿&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 17</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>爱豆爱阿翁吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【娱乐】百组同龄明星对对碰，拼的就是颜值!</font>
										</a>
											</p> 娱乐圈明星星光熠熠，同龄的明星大有人在! 把这些同年出生的明星进行AB向选择，你会选哪一个？
											</p> <img src="img/ad_one.jpg" id="tb_entertainment" /> <img
											src="img/ad_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												瓜子浅笑&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 30</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>科学吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】关于时间的本质，看看科学家都是怎么说的。</font>
										</a>
											</p> 关于时间的本质，看看科学家都是怎么说的。
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												华山论剑我第六&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 21</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>推理吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】浅谈福尔摩斯式观人推理，除了破案还可以做什么？</font>
										</a>
											</p> 个人的一些随笔，更新速度会比较慢，但不会弃。
											在这个贴子里我会简要的分析福尔摩斯式的推理，以及推理在生活中除了破案以外的实际应用
											</p> <img src="img/f_one.jpg" id="tb_entertainment" /> <img
											src="img/f_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												妙蛙种子qq&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 15</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>爱豆爱阿翁吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【娱乐】皎如玉树临风前，百位风华古装男性浅尝</font>
										</a>
											</p> 高级审美的自我修养=气质＞人设＞颜值 细节决成败，内在见真章 ◎所有流量小生均不在涉猎范围内 陆续出现的镇楼们 一排：
											《楚留香传奇》无花；《齐天大圣》孙悟空；《神雕侠侣》杨过；《泪痕剑》卓东来；《包青天》...
											</p> <img src="img/ad_three.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												卿琖&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 15</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>DIY吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">nba吧</font>
										</a>
											</p> 【体育】NBA近10年冠军球队进攻效率以及防守效率排名
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												比迪丽干琪琪&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 13</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>nba2kol吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【体育】盘点各个优秀蓝紫卡外线</font>
										</a>
											</p>
											上次发帖众吧友反应都很好，这次再盘点一下外线，大部分都是比较常见的球星，也包括部分礼盒球星，本贴分析主要是我个人看法，有什么不妥和漏洞还希望各位MVP能帮我指出，我们一起讨论。
											乔老爷镇
											</p> <img src="img/nba_one.jpg" id="tb_entertainment" /> <img
											src="img/nba_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												地平线少年&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 45</font></li>
									</ul>
									</p>
								</div>
								<div class="tab-pane" id="panel-969420">
									<ul class="list-group">
										<li class="list-group-item">
											<h3>
												<a>剑网3吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【游戏】大战保命用！剑网3各门派各心法的减伤技能</font>
										</a>
											</p> 主要针对大战保命用，打团本偶尔也会用到的
											</p> <img src="img/jw_one.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												北傲疏狂&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 14</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>红豆爱阿翁吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【娱乐】百位古装剧女子手拈花 最美不过眼前景</font>
										</a>
											</p>
											古装女子手拈鲜花或娇羞、或沉思、或含情，怎一个美字了得！本帖收集了100位手拈鲜花的古装角色这类镜头是小众，比较难找，不可能每张都完美那些要求苛刻的右拐不送不要跟我说哪张图截的不行啊，角度不行啊，你行你来！
											</p> <img src="img/hd_one.jpg" id="tb_entertainment" /> <img
											src="img/hd_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												红豆爱阿翁吧&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 21</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>红豆爱阿翁吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】同位女演员的古装造型大PK，四选一选哪个？</font>
										</a>
											</p> 古装女子，造型独特，美轮美奂，层出不穷！ 女明星的不同古装造型，哪个造型更适合她？你更喜欢哪一个？
											随意选取四个不同剧中的造型进行PK，哪个人气最高涨？
											</p> <img src="img/hd_one.jpg" id="tb_entertainment" /> <img
											src="img/hd_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												瓜子浅笑&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 23</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>圣斗士星矢手游吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【游戏】现版本十二黄金强度测评，不吹不黑</font>
										</a>
											</p> 楼主入坑也已经3个月了，银河传奇50星左右，下面是楼主对目前黄金强度的看法，已经修改意见欢迎大家来点评
											</p> <img src="img/sds_one.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												忍让502&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 23</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>崩坏3rd吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】靠美工撑起的崩崩崩，到底有多用心！</font>
										</a>
											</p> 众所周知，崩崩崩是一个靠美工撑起的游戏 既然如美工对待自己的作品能够用心成什么样子呢
											此贴为考据考证向，可以闲聊吹比，可以滑稽氵贴，严谨节奏向 私货镇楼，下面开始
											</p> <img src="img/rd_one.jpg" id="tb_entertainment" /> <img
											src="img/rd_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												作者&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font>
												浏览量</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>耳机吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【讨论】科普向：耳机阻抗与耳放推力、增益、EQ等问题</font>
										</a>
											</p>
											很多人对于播放器推力大好不好、耳机高阻好不好等问题还比较纠结，所以今天想来谈谈这些耳机阻抗与耳放（随身播放器）推力、增益、EQ等相关问题。
											声音的特点声音的本质是声波，它的传播会遵循波的特点，会反射、衍...
											</p> <img src="img/ej_one.jpg" id="tb_entertainment" /> <img
											src="img/rj_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												r911&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 13</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>nba吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【体育】高分盛宴越来越少，50分先生还有谁？</font>
										</a>
											</p>
											十年前，在那个优秀得分手井喷的年代，科比，艾弗森他们为我们上演了无数次得分盛宴，他们将个人英雄主义演绎到极致，一场场飙分大战即使到现在很多人也记忆犹新。而如今，他们已离开了NBA，而联盟也不再由得分后卫...
											</p> <img src="img/nba_three.jpg" id="tb_entertainment" /> <img
											src="img/nba_four.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												J-Dub&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 12</font></li>
									</ul>

									<ul class="list-group" id="five-one">
										<li class="list-group-item">
											<h3>
												<a>奇迹暖暖吧</a>
											</h3>
										</li>
										<li class="list-group-item"><a href="#"> <font
												size="2">【游戏】个性美？盘点奇迹暖暖带假肢的衣服部件</font>
										</a>
											</p> 如题上一个盘点贴没有规划好，导致盘点得很乱这次重新开了一个，也有了一点存稿，大家再也不用担心我鸽了
											这是一个为各位浪游光的小可爱们而作的一个盘点贴，希望大家以后搭配时再也不用翻遍整个衣柜找动作啦 本次盘...
											</p> <img src="img/qjnn_one.jpg" id="tb_entertainment" /> <img
											src="img/qjnn_two.jpg" id="tb_entertainment" />
											</p> <span class="glyphicon glyphicon-user"></span> <a href="#">
												菲列特利加&nbsp;&nbsp;&nbsp;&nbsp;</a> <span
											class="glyphicon glyphicon-eye-open"></span> <font> 21</font></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--热门动态及个性动态结束-->
			<!--分页按钮-->
			<div id="pagination">
				<center>
					<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
					</nav>
				</center>
			</div>
			<!--分页按钮结束-->
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

		<script>
			document.getElementById('winpop').style.height = '0px';//初始化小弹窗的高度

			var oDiv = document.getElementById("third"), H = 0, Y = oDiv
			var oDiv1 = document.getElementById("fix"), A = 0, B = oDiv1
			while (Y) {
				H += Y.offsetTop;
				Y = Y.offsetParent;
			}
			while (B) {
				A += B.offsetTop;
				B = B.offsetParent;
			}
			window.onscroll = function() {
				var s = document.body.scrollTop
						|| document.documentElement.scrollTop
				if (s > H) {
					oDiv.style = "position:fixed;bottom:50px;"
				} else {
					oDiv.style = ""
				}
				var a = document.body.scrollTop
						|| document.documentElement.scrollTop
				if (a > A) {
					oDiv1.style = "position:fixed;top:1070px;"
				} else {
					oDiv1.style = ""
				}
			}
		</script>

		<script type="text/javascript" src="./js/myJs.js"></script>
</body>

</html>