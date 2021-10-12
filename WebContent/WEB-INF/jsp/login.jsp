<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content />
<meta name="author" content />
<title>饭团儿贴吧——打开世界的中文社区</title>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="css/sigin.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.min.js"></script>
</head>

<body>
	<canvas id="c"></canvas>
	<div class="container">
		<form class="form-signin" method="post">
			<img src="img/ft.jpg" id="img1" /> <img src="img/logo.jpg" id="img2" />
			<h3 class="form-signin-heading">
				<center>用户密码登陆</center>
			</h3>
			<label for="username" class="sr-only">用户名</label> <input type="text"
				name="user_name" id="user_name" class="form-control"
				placeholder="请输入用户名" required autofocus /> <label
				for="inputPassword" class="sr-only">密码</label> <input
				type="password" name="user_pwd" id="user_pwd" class="form-control"
				placeholder="请输入密码" required /> <input type="hidden" name="act"
				value="login" />
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me" />记住账号 <span
					style="color: red; font-size: 10px;">${login_error_hint }</span>
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block"
				onclick="loginAuthentication()">登录</button>
			<a href="http://localhost:8080/ssmProject_tb/register.action">注册</a>
		</form>
	</div>
	<script type="text/javascript">
			$(document).ready(function() {
				var canvas = document.getElementById("c");
				var ctx = canvas.getContext("2d");
				var c = $("#c");
				var w, h;
				var pi = Math.PI;
				var all_attribute = {
					num: 150, // 个数
					start_probability: 0.1, // 如果数量小于num，有这些几率添加一个新的     		     
					radius_min: 1, // 初始半径最小值
					radius_max: 2, // 初始半径最大值
					radius_add_min: .3, // 半径增加最小值
					radius_add_max: .5, // 半径增加最大值
					opacity_min: 0.3, // 初始透明度最小值
					opacity_max: 0.5, // 初始透明度最大值
					opacity_prev_min: .003, // 透明度递减值最小值
					opacity_prev_max: .005, // 透明度递减值最大值
					light_min: 40, // 颜色亮度最小值
					light_max: 70, // 颜色亮度最大值
				};
				var style_color = find_random(0, 360);
				var all_element = [];
				window_resize();

				function start() {
					window.requestAnimationFrame(start);
					style_color += .1;
					ctx.fillStyle = 'hsl(' + style_color + ',100%,97%)';
					ctx.fillRect(0, 0, w, h);
					if(all_element.length < all_attribute.num && Math.random() < all_attribute.start_probability) {
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
					to_reset: function() {
						var t = this;
						t.x = find_random(0, w);
						t.y = find_random(0, h);
						t.radius = find_random(all_attribute.radius_min, all_attribute.radius_max);
						t.radius_change = find_random(all_attribute.radius_add_min, all_attribute.radius_add_max);
						t.opacity = find_random(all_attribute.opacity_min, all_attribute.opacity_max);
						t.opacity_change = find_random(all_attribute.opacity_prev_min, all_attribute.opacity_prev_max);
						t.light = find_random(all_attribute.light_min, all_attribute.light_max);
						t.color = 'hsl(' + style_color + ',100%,' + t.light + '%)';
					},
					to_step: function() {
						var t = this;
						t.opacity -= t.opacity_change;
						t.radius += t.radius_change;
						if(t.opacity <= 0) {
							t.to_reset();
							return false;
						}
						ctx.fillStyle = t.color;
						ctx.globalAlpha = t.opacity;
						ctx.beginPath();
						ctx.arc(t.x, t.y, t.radius, 0, 2 * pi, true);
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
					return Math.random() * (num_two - num_one) + num_one;
				}
				(function() {
					var lastTime = 0;
					var vendors = ['webkit', 'moz'];
					for(var xx = 0; xx < vendors.length && !window.requestAnimationFrame; ++xx) {
						window.requestAnimationFrame = window[vendors[xx] + 'RequestAnimationFrame'];
						window.cancelAnimationFrame = window[vendors[xx] + 'CancelAnimationFrame'] ||
							window[vendors[xx] + 'CancelRequestAnimationFrame'];
					}

					if(!window.requestAnimationFrame) {
						window.requestAnimationFrame = function(callback, element) {
							var currTime = new Date().getTime();
							var timeToCall = Math.max(0, 16.7 - (currTime - lastTime));
							var id = window.setTimeout(function() {
								callback(currTime + timeToCall);
							}, timeToCall);
							lastTime = currTime + timeToCall;
							return id;
						};
					}
					if(!window.cancelAnimationFrame) {
						window.cancelAnimationFrame = function(id) {
							clearTimeout(id);
						};
					}
				}());
				start();
			});
		</script>
		
		<script type="text/javascript" src="./js/myJs.js"></script>
</body>

</html>