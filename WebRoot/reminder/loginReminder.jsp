<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String rtn = request.getParameter("rtn");
	int rtnInt = Integer.parseInt(rtn);
	if(rtnInt==-1){
		%>
		<script>alert("账号或密码不能为空！请重新操作！");window.location="../loginUI.jsp";</script>
		<%
	}else if(rtnInt==-2){
		%>
		<script>alert("验证码不能为空！请重新操作！");window.location="../loginUI.jsp";</script>
		<%
	}else if(rtnInt==-3){
		%>
		<script>alert("验证码输入错误！请重新操作！");window.location="../loginUI.jsp";</script>
		<%
	}else if(rtnInt==0){
		%>
		<script>alert("账号或密码输入错误！请重新操作！");window.location="../loginUI.jsp";</script>
		<%
	}else{
		response.sendRedirect("../indexUI.jsp");
	}
 %>
