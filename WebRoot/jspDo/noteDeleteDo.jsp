<%@page import="service.NoteServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//获取url传递参数的值
	int note_id = Integer.parseInt(request.getParameter("note_id"));
	//进行删除操作
	NoteServerce server = new NoteServerce();
	boolean rtn = server.noteDeleteDo(note_id);
	if(rtn){
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-5");
		return;
	}else{
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-6");
	}
%>

