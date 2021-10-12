<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="css/send_tb.css" />
<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/updateimg.js"></script>

<title>发表帖子</title>
</head>
<body onload="jsp_main('${sessionScope.user_name}')">
	<input id="login_userName" type="hidden"
		value="${sessionScope.user_name}" />
	<!-- 用来存放当前登录对象的用户名 -->

	<canvas id="c"></canvas>

	<form action="send_tb.action" autocomplete="off" method="post"
		onsubmit="return do_verify('send_tb')" enctype="multipart/form-data">
		<div class="container">
			<div id="head">
				<h2>发表帖子</h2>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<font>请输入帖子的标题：</font>
					</div>
					<div class="panel-body">
						<input class="form-control" type="text" id="tbTitle"
							name="tw_title" />
					</div>
				</div>

				<div class="panel panel-info" id="sort_tb">
					<div class="panel-heading">
						<font>分类：</font>
					</div>
					<div class="panel-body">
						<label> <input name="tw_sort" type="radio" value="娱乐明星"
							checked="checked" /> 娱乐明星
						</label> <label> <input name="tw_sort" type="radio" value="生活" />
							生活
						</label> <label> <input name="tw_sort" type="radio" value="其它" />
							其它
						</label>
					</div>
				</div>

				<div id="contain">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<font>请输入正文：</font>
						</div>
						<div class="panel-body" id="artical">
							<textarea rows="10" cols="80" id="tbArtical" name="tw_article">这是我的正文内容</textarea>
						</div>
					</div>

					<div class="main">
						<div id="showimg">
							<ul id="showui"></ul>
							<div id="showinput"></div>
						</div>
						<div>
							<input type="file" id="upgteimg" name="file" multiple />
						</div>
					</div>
				</div>

				<div id="jgan">
					<input type="submit" id="an_one" class="btn btn-info btn-lg active"
						value="确认发帖" /> <a
						href="http://localhost:8080/ssmProject_tb/main.action">返回主界面</a>
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var canvas = document.getElementById("c");
							var ctx = canvas.getContext("2d");
							var c = $("#c");
							var w, h;
							var pi = Math.PI;
							var all_attribute = {
								num : 100, // 个数
								start_probability : 0.1, // 如果数量小于num，有这些几率添加一个新的     		     
								radius_min : 1, // 初始半径最小值
								radius_max : 2, // 初始半径最大值
								radius_add_min : .3, // 半径增加最小值
								radius_add_max : .5, // 半径增加最大值
								opacity_min : 0.3, // 初始透明度最小值
								opacity_max : 0.5, // 初始透明度最大值
								opacity_prev_min : .003, // 透明度递减值最小值
								opacity_prev_max : .005, // 透明度递减值最大值
								light_min : 40, // 颜色亮度最小值
								light_max : 70, // 颜色亮度最大值
							};
							var style_color = find_random(0, 360);
							var all_element = [];
							window_resize();

							function start() {
								window.requestAnimationFrame(start);
								style_color += .1;
								ctx.fillStyle = 'hsl(' + style_color
										+ ',100%,97%)';
								ctx.fillRect(0, 0, w, h);
								if (all_element.length < all_attribute.num
										&& Math.random() < all_attribute.start_probability) {
									all_element.push(new ready_run);
								}
								all_element.map(function(line) {
									line.to_step();
								})
							}

							function ready_run() {
								this.to_reset();
							}
							ready_run.prototype = {
								to_reset : function() {
									var t = this;
									t.x = find_random(0, w);
									t.y = find_random(0, h);
									t.radius = find_random(
											all_attribute.radius_min,
											all_attribute.radius_max);
									t.radius_change = find_random(
											all_attribute.radius_add_min,
											all_attribute.radius_add_max);
									t.opacity = find_random(
											all_attribute.opacity_min,
											all_attribute.opacity_max);
									t.opacity_change = find_random(
											all_attribute.opacity_prev_min,
											all_attribute.opacity_prev_max);
									t.light = find_random(
											all_attribute.light_min,
											all_attribute.light_max);
									t.color = 'hsl(' + style_color + ',100%,'
											+ t.light + '%)';
								},
								to_step : function() {
									var t = this;
									t.opacity -= t.opacity_change;
									t.radius += t.radius_change;
									if (t.opacity <= 0) {
										t.to_reset();
										return false;
									}
									ctx.fillStyle = t.color;
									ctx.globalAlpha = t.opacity;
									ctx.beginPath();
									ctx
											.arc(t.x, t.y, t.radius, 0, 2 * pi,
													true);
									ctx.closePath();
									ctx.fill();
									ctx.globalAlpha = 1;
								}
							}

							function window_resize() {
								w = window.innerWidth;
								h = window.innerHeight;
								canvas.width = w;
								canvas.height = h;
							}
							$(window).resize(function() {
								window_resize();
							});

							function find_random(num_one, num_two) {
								return Math.random() * (num_two - num_one)
										+ num_one;
							}
							(function() {
								var lastTime = 0;
								var vendors = [ 'webkit', 'moz' ];
								for (var xx = 0; xx < vendors.length
										&& !window.requestAnimationFrame; ++xx) {
									window.requestAnimationFrame = window[vendors[xx]
											+ 'RequestAnimationFrame'];
									window.cancelAnimationFrame = window[vendors[xx]
											+ 'CancelAnimationFrame']
											|| window[vendors[xx]
													+ 'CancelRequestAnimationFrame'];
								}

								if (!window.requestAnimationFrame) {
									window.requestAnimationFrame = function(
											callback, element) {
										var currTime = new Date().getTime();
										var timeToCall = Math.max(0,
												16.7 - (currTime - lastTime));
										var id = window.setTimeout(function() {
											callback(currTime + timeToCall);
										}, timeToCall);
										lastTime = currTime + timeToCall;
										return id;
									};
								}
								if (!window.cancelAnimationFrame) {
									window.cancelAnimationFrame = function(id) {
										clearTimeout(id);
									};
								}
							}());
							start();
						});

		// JavaScript for label effects only
		$(window).load(function() {
			$(".col-12 input").val("");

			$(".input-effect input").focusout(function() {
				if ($(this).val() != "") {
					$(this).addClass("has-content");
				} else {
					$(this).removeClass("has-content");
				}
			})
		});
	</script>
	</div>

	<script type="text/javascript" src="./js/myJs.js"></script>
</body>
</html>