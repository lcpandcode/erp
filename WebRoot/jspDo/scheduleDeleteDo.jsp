<%@page import="service.ScheduleServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return;
	}
	//获取url传参的sch_id值
	int sch_id = Integer.parseInt(request.getParameter("sch_id"));
	//进行删除操作
	ScheduleServerce serverce = new ScheduleServerce();
	boolean rtn = serverce.scheduleDelete(sch_id);
	if(rtn){
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=4");
		return;
	}else{
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=5");
	}
%>

