<%@ page language="java" import="java.util.*,com.sn.entity.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head> 
<title>用户注册</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/dist/css/AdminLTE.min.css" />
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/iCheck/square/blue.css" />
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo"> 
			<a href="javascript:void(0)"><b>管控系统</b></a> <span style="font-size: 26px">权限系统</span>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">用户登录</p>
 
			<form action="<%=basePath%>system/oplogin.html" method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" name="username" required="required" placeholder="请账号" /> <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>  
				<div class="form-group has-feedback"> 
					<input type="password" class="form-control" name="password" required="required" placeholder="请输入密码" /> <span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-8">
						<div class="checkbox icheck">
							<label> <input id="remember" type="checkbox" /> 记住账号
							</label>
						</div>
					</div>
				</div>
				<div class="social-auth-links text-center">
					<button type="submit" class="btn btn-block btn-primary">点击登录</button>

				</div>
			</form>

			<!-- /.social-auth-links -->
			<%-- <div style="font-size: 12px">   
				 <a href="<%=basePath%>reg/registerShow.html" class="text-center">点击注册</a>
			</div> --%> 
		</div>
	</div>
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/iCheck/icheck.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common/jquery.cookie.js"></script>
	<script>
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' // optional
			});
			$("input[name='acount']").focus(); 
			$('input').on('ifChecked', function(event) {
				$("#remember").attr("checked", "checked");
			});
			var cookie_username = $.cookie('login_cookie_username');
			var cookie_userpwd = $.cookie('login_cookie_password');
			if (cookie_username != null && cookie_username != "") {
				$("input[name='acount']").val(cookie_username);
				$("input[name='password']").val(cookie_userpwd);
				$('#remember').iCheck('check');
				$("#remember").attr("checked", "checked");
			}
			$("form").submit(function(e) {
				var remember = $("#remember").attr("checked");
				if (remember == 'checked') {
					var cookie_username = $("input[name='acount']").val();
					var cookie_userpwd = $("input[name='password']").val();
					$.cookie('login_cookie_username', $.trim(cookie_username), {
						expires : 30
					});
					$.cookie('login_cookie_password', cookie_userpwd, {
						expires : 30
					});
				} else {
					$.cookie('login_cookie_username', null); 
					$.cookie('login_cookie_password', null);
				}
			});
			keyLogin();
		});

		function keyLogin() {
			if (event.keyCode == 13)
				$("form").submit();
		}
	</script>
</body>
</html>