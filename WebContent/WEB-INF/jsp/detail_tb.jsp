<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
		<link rel="stylesheet" href="css/detail_tb.css" />
		<link rel="stylesheet" href="zyComment-150419140228/css/semantic.css" />
		<link rel="stylesheet" href="zyComment-150419140228/css/zyComment.css" />
		<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.js"></script>
		<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="zyComment-150419140228/js/zyComment.js"></script>
		<title>XX吧——饭团儿贴吧</title>
	</head>

	<body>
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
		<div id="head">
			<div id="logo">
				<a href="main.jsp"> <img src="img/ft.jpg" /> <img src="img/logo.jpg" />
				</a>
			</div>
			<div id="doSearch">
				<input type="text" class="form-control" placeholder="请输入贴吧名">
				<input type="button" class="btn" value="搜索贴吧" /> 
				<input type="button" class="btn btn-inverse" value="所有贴吧" />
				<div id="advanced">
					<a href="advanced_search.jsp">高级搜索</a>
				</div>
			</div>
		</div>
		<!--
		-->
		<div class="container" id="all">
			<div id="img">
				<img src="img/gsy.jpg" class="img-thumbnail" />
			</div>
			<div id="content">
				<h2>XX吧</h2>
				<button type="button" class="btn btn-danger">+关注</button>
				<div id="font">
					<font color="#AAA">
						关注：
						<font color="#ff7f3e">12345</font>&nbsp;&nbsp;&nbsp; 贴子：
						<font color="#ff7f3e">12345</font>
					</font>
				</div>
				<div id="tb_describe">
					神秘的月球，美好的传说，地球的卫士。(贴吧描述)
				</div>
			</div>

			<div class="row clearfix" id="two">
				<div class="col-md-12 column">
					<div class="row clearfix">
						<div class="col-md-9 column">
							<ul class="list-group">
								<li class="list-group-item" id="see">
									<h3>
										看帖
									</h3>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
											<span class="glyphicon glyphicon-user"></span> 贴子作者
										</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
										<span class="glyphicon glyphicon-user"></span> 贴子作者
									</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample1">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
										<span class="glyphicon glyphicon-user"></span> 贴子作者
									</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample2" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample2">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
										<span class="glyphicon glyphicon-user"></span> 贴子作者
									</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample3" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample3">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
										<span class="glyphicon glyphicon-user"></span> 贴子作者
									</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample4" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample4">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div>
										<font id="say">123</font>
										<a href="#">
											<font size="2">帖子名</font>
										</a>
										<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="作者名字">
										<span class="glyphicon glyphicon-user"></span> 贴子作者
									</button>
									</div>
									</p>
									<%=session.getAttribute("my_article") %>
									</p> <img src="img/Notice.jpg" id="tb_entertainment" />
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample5" aria-expanded="false" aria-controls="collapseExample">
  										查看评论
									</button>
									<div class="collapse" id="collapseExample5">
										<div class="well">
											<%=session.getAttribute("allComment") %>
										</div>
									</div>
								</li>
							</ul>

							<!--分页按钮-->
							<div id="pagination">
								<center>
									<nav aria-label="Page navigation">
										<ul class="pagination">
											<li>
												<a href="#" aria-label="Previous">
													<span aria-hidden="true">&laquo;</span>
												</a>
											</li>
											<li>
												<a href="#">1</a>
											</li>
											<li>
												<a href="#">2</a>
											</li>
											<li>
												<a href="#">3</a>
											</li>
											<li>
												<a href="#">4</a>
											</li>
											<li>
												<a href="#">5</a>
											</li>
											<li>
												<a href="#" aria-label="Next">
													<span aria-hidden="true">&raquo;</span>
												</a>
											</li>
										</ul>
									</nav>
								</center>
							</div>
							<!--分页按钮结束-->

							<!--评论框-->
							<div id="t">
								<div class="input-group">
									<input type="text" class="form-control" aria-describedby="basic-addon2">
									<span class="input-group-addon" id="basic-addon2">标题</span>
								</div>
								<div id="type">
									<span class="glyphicon glyphicon-comment"></span>
									<div>  
										分类     
									</div>  
								</div>
								</p><textarea></textarea></p>

								<button type="button" class="btn btn-primary">发表</button>

							</div>
							<!--评论框结束-->
						</div>
						<div class="col-md-3 column">
							<div id="hot_tb_list">
								<ul class="list-group">
									<li class="list-group-item" id="titlie">
										<h4>
									<font color="#000000"><strong>贴吧热议榜</strong></font>
								</h4>
									</li>
									<li class="list-group-item" id="hot_content">
										<span class="glyphicon glyphicon-heart"></span>
										<a href="#">&nbsp;嫦娥四号着陆月球表面</a>
										<font color="#AAA">12345</font>
										</p>
										<span class="glyphicon glyphicon-heart"></span>
										<a href="#">&nbsp;苹果架暴跌</a>
										<font color="#AAA">12345</font>
										</p>
										<span class="glyphicon glyphicon-heart"></span>
										<a href="#">&nbsp;南北方人谁更抗冻</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;&nbsp;4
										<a href="#">&nbsp;20个人能打过老虎吗</a>
										<font color="#AAA">12345</font>
										</p>
										</p>
										&nbsp;&nbsp;5
										<a href="#">&nbsp;马刺大胜猛龙</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;&nbsp;6
										<a href="#">&nbsp;权健被立案侦查</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;&nbsp;7
										<a href="#">&nbsp;男子年会饮酒死亡</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;&nbsp;8
										<a href="#">&nbsp;王佳豪加盟英超狼队</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;&nbsp;9
										<a href="#">&nbsp;火锅店招服务员要985</a>
										<font color="#AAA">12345</font>
										</p>
										&nbsp;10
										<a href="#">小米折叠手机</a>
										<font color="#AAA">12345</font>
										</p>
										</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!--页尾-->
			<div class="final">
				<center>
					<ol class="breadcrumb">

						<li>@2019 FanTuaner&nbsp;
							<a href="#">使用饭团儿前必读</a>
						</li>
						<li>
							<a href="#">贴吧协议</a>
						</li>
						<li>
							<a href="#">隐私权限</a>
						</li>
						<li>
							<a href="#">投诉反馈</a>
						</li>
						<li class="active">信息网络传播试听节目许可证&nbsp;0110516</li>

					</ol>
				</center>
			</div>
			<!--页尾结束-->

		</div>

		<script type="text/javascript">
			window.onload = function() {
				var oDiv = document.getElementById("hot_tb_list"),
					H = 0,
					Y = oDiv
				while(Y) {
					H += Y.offsetTop;
					Y = Y.offsetParent;
				}
				window.onscroll = function() {
					var s = document.body.scrollTop ||
						document.documentElement.scrollTop
					if(s > H) {
						oDiv.style = "position:fixed;top:0;"
					} else {
						oDiv.style = ""
					}
				}
			}

			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})

			$("#new a").click(function(event) {
				var top = $(this.hash).offset().top - 60;
				$("html,body").animate({
					scrollTop: top
				})
			})
			
			$('#bottom').popover(options)
		</script>
	</body>

</html>