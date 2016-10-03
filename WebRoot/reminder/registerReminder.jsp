<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	
	//获取返回值
	int rtnInt = Integer.parseInt(request.getParameter("rtn"));
	//注册成功，停顿三秒在提示界面后自动跳转到登录界面
	if(rtnInt==1){
	response.setHeader("refresh", "3;URL=../loginUI.jsp");
	out.print("<font color='red' size='5'> 注册成功！<br/>三秒后将跳转到登录页面 <br/>如果没有跳转,请按 <a href='../loginUI.jsp'>这里</a>!!!<br/> </font>");
		//response.sendRedirect("../loginUI.jsp");
	}else if(rtnInt==0){
	%>
		<script>alert("注册失败，用户名不能为空，请重新操作！");window.location="../registerUI.jsp";</script>
	<%		
	}else if(rtnInt==-1){
	%>
		<script>alert("注册失败，用户名不能为空，请重新操作！");window.location="../registerUI.jsp";</script>
	<%		
	}else if(rtnInt==-2){
	%>
		<script>alert("注册失败，上传图片的格式不对，请重新操作！");window.location="../registerUI.jsp";</script>
	<%		
	}
	else{
	%>
		<script>alert("注册失败，请重新操作！");window.location="../registerUI.jsp";</script>
	<%		
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<script></script>
  </head>

</html>
