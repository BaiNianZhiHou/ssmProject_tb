<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>饭团儿贴吧——全球最可爱的中文社区</title>
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="css/head_navigation.css" />
<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>

</head>

<body>
	<div></div>
	<div class="container">
		<!--页头-->
		<div id="head">
			<div id="logo">
				<a href="main.jsp"> <img src="img/ft.jpg" /> <img
					src="img/logo.jpg" />
				</a>
			</div>
			<div id="doSearch">
				<input type="text" class="form-control" placeholder="请输入贴吧名">
				<input type="button" class="btn" value="搜索贴吧" /> <input
					type="button" class="btn btn-inverse" value="所有贴吧" />
				<div id="advanced">
					<a href="advanced_search.jsp">高级搜索</a>
				</div>
			</div>
		</div>
	</div>
</body>

</html>