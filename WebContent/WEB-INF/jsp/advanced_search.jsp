<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/advanced_search.css" />
<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<title>高级搜索</title>
</head>
<body>
	<div class="navbar-wrapper">
		<div class="container">
			<nav class="navbar navbar-static-top">
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<li class="active"><img src="img/ft.jpg" /> <img
							src="img/logo.jpg" /></li>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<li class="active"><a href="#" onclick="javascript:to_main()">返回首页</a></li>
					</div>
					<!-- /.navbar-collapse -->
				</div>
				<!-- /.container-fluid -->
			</nav>
		</div>
	</div>
	<div class="container" id="container_s">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<table class="table table-hover">
					<tbody>
						<tr>
							<td>吧名(只在此贴吧中搜索)</td>
							<td><input type="text" id="tb_name" class="form-control"
								required autofocus /></td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td>用户名(只搜索该用户的发言)</td>
							<td><input type="text" id="username" class="form-control"
								required /></td>
						</tr>

					</tbody>
					<tbody>
						<tr>
							<td>搜索结果排序方式(限定搜索结果的排序方式是)</td>
							<td><select name="sort">
									<option value="按时间倒序" selected="true">按时间倒序</option>
									<option value="按时间顺序">按时间顺序</option>
							</select></td>
						</tr>

					</tbody>
					<tbody>
						<tr>
							<td>搜索结果显示条数(选择搜索结果显示的条数)</td>
							<td><select name="pagination">
									<option value="每页显示5条" selected="true">每页显示5条</option>
									<option value="每页显示10条">每页显示10条</option>
									<option value="每页显示15条">每页显示15条</option>
							</select></td>
						</tr>

					</tbody>
				</table>
				<button class="btn btn-lg btn-primary btn-block" type="submit">提交</button>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/to_main.js"></script>

</body>
</html>