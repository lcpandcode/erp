<%@page import="service.UserServerce"%>
<%@page import="VO.userVO.userLoginVO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//获取页面输入值
	userLoginVO rlvo = new userLoginVO();
	String user_name = request.getParameter("user_name");
	String user_pass = request.getParameter("user_pass");
	String checkCode = request.getParameter("check_code");
	//判断用户名或者密码是否为空,为空返回-1
	if(user_name==null || user_pass==null){
		response.sendRedirect("../reminder/loginReminder.jsp?rtn=-1");
		return ;
	}
	//判断验证码是否为空,为空返回-2
	if(checkCode==null){
		response.sendRedirect("../reminder/loginReminder.jsp?rtn=-2");
		return ;
	}
	//判断验证码是否正确,不正确返回-3
	if(!checkCode.equals(session.getAttribute("checkCode"))){
		response.sendRedirect("../reminder/loginReminder.jsp?rtn=-3");
		return ;
	}
	rlvo.user_name = user_name;
	rlvo.user_pass = user_pass;
	UserServerce resumeSer = new UserServerce();

	//执行登录方法，密码错误返回0
	int result_login = resumeSer.loginDo(rlvo);
	if(result_login>0){
		session.setAttribute("user_id", result_login);
		response.sendRedirect("../reminder/loginReminder.jsp?rtn=1");
	}else{
		response.sendRedirect("../reminder/loginReminder.jsp?rtn=0");
	}
%>

