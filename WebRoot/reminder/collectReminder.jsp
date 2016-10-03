<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//验证登录否
	//登录验证
	Integer user_idInt = (Integer)session.getAttribute("user_id");
	if(user_idInt==null ){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return ;
	}
	//获取rtn参数
	int rtn;
	try{
		rtn = Integer.parseInt(request.getParameter("rtn"));
	}catch(NumberFormatException e){
		//非法传参，进行拦截
		e.printStack();
		out.println("<script>alert('非法访问！');</script>");
		response.sendRedirect("../collectsUI.jsp");
		return;
	}
	
	switch(rtn){
		case 0:%><script>alert("请输入收藏网站的名字！");window.location="../collectsUI.jsp";</script><% break;
		case 1: %><script>alert("请输入网站地址！");window.location="../collectsUI.jsp";</script><% break;
		case 2: %><script>alert("添加成功！");window.location="../collectsUI.jsp";</script><% break;
		case 3: %><script>alert("网络异常，请重新操作！");window.location="../collectsUI.jsp";</script><% break;
	}
%>

