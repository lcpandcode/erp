<%@page import="service.UserServerce"%>
<%@page import="VO.userVO.userAddVO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	//创建数据封装类对象用于传输数据
	userAddVO ra = new userAddVO();
	//设置编码格式
	request.setCharacterEncoding("utf-8");
	//初始化vo
	String user_name = request.getParameter("user_name");
	System.out.println("user_name= " + user_name);
	String user_pass = request.getParameter("user_pass");
	String user_email = request.getParameter("user_email");
	String user_phone = request.getParameter("user_phone");
	String user_summary = request.getParameter("user_summary");
	//判断以上输入是否为空(暂时只是判断用户名和密码是否为空，其他输入可以为空)
	//用户名为空，返回0
	if(user_name==null || "".equals(user_name)){
		response.sendRedirect("../reminder/registerReminder.jsp?rtn=0");
		return ;
	}
	//密码为空返回-1
	if(user_pass==null || "".equals(user_name)){
		response.sendRedirect("../reminder/registerReminder.jsp?rtn=-1");
		return ;
	}
	ra.user_name = user_name;
	ra.user_pass = user_pass;
	ra.user_email = user_email;
	//判断电话是否为空
	if(user_phone!=null && user_phone!=""){
		ra.user_phone = Integer.parseInt(user_phone);
	}else{
		//电话输入为空，设为默认值0
		ra.user_phone = 0;
	}
	ra.user_photo = request.getParameter("user_photo");
	ra.user_summary = user_summary;
	UserServerce rs = new UserServerce();
	boolean rtn = rs.registerDo(ra);
	if(rtn){
		response.sendRedirect("../reminder/registerReminder.jsp?rtn=1");
	}else{
		response.sendRedirect("../reminder/registerReminder.jsp?rtn=0");
	}
%>
