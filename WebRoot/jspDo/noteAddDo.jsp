<%@page import="service.NoteServerce"%>
<%@page import="VO.noteVO.NoteAddVO"%>
<%@page import="service.NoteServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//设置接收数据的编码格式
	request.setCharacterEncoding("utf-8");
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return;
	}
	//获取前端的数据
	String note_title = request.getParameter("note_title");
	if(note_title==null || "".equals(note_title)){
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=0");
		return;
	}
	String note_type = request.getParameter("note_type");
	if(note_type==null || "".equals(note_type) || "-- 笔记类型 --".equals(note_type)){
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-1");
		return;
	}
	String note_summary = request.getParameter("note_summary");
	if(note_summary==null || "".equals(note_type)){
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-2");
		return;
	}
	
	//进行数据插入操作
	NoteAddVO vo = new NoteAddVO();
	vo.note_title = note_title;
	vo.note_typeName = note_type;
	vo.note_summary = note_summary;
	vo.user_id = user_id;
	NoteServerce server = new NoteServerce();
	boolean rtn = server.noteAddDo(vo);
	//增加成功URL传参传递-3，增加失败传参-4
	if(rtn){
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-3");
		return;
	}else{
		response.sendRedirect("../reminder/noteReminder.jsp?rtn=-4");
	}
	
%>

