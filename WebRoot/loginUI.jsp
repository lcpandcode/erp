<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
<%
	if("-1".equals(request.getParameter("rtn"))){
%>
	<script>alert("您输入的账号和密码不正确！");window.location="loginUI.jsp"</script>
<%
	}
 %>		

	<head>
		<meta charset="utf-8">
		<title>登录 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<script type="text/javascript" src="js/login.js"></script>
	</head>
	<body>
		<div id="login-page" class="container">
			<h1>MyNote Login</h1>
		<form id="login-form" class="well" action="jspDo/loginDo.jsp" method="post" onsubmit = "return checkNull();">
			<input type="text" class="span2" id="user_name" name="user_name" placeholder="用户名" /><br />
			<input type="password" class="span2" id="user_pass" name="user_pass" placeholder="密码" /><br />
			<input type="text" class="span2" id="check_code" name="check_code" placeholder="验证码码" /><br /> 
			<div><img alt="验证码" src="jspTool/checkCodeCreate.jsp" onClick="show(this)"/></div>
			<label class="checkbox"> <input type="checkbox" /> 记住登录状态 </label>
			<button type="submit" class="btn btn-primary">登录</button>
			<button type="submit" class="btn">忘记密码</button>
		</form>	
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
	</body>
</html>