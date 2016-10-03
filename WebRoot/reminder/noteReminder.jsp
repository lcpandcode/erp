<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	int rtn = Integer.parseInt(request.getParameter("rtn"));//优化：考虑用switch-case语句
	
	switch(rtn){
		case 0: %><script>alert("笔记题目输入不能为空！");window.location="../notesUI.jsp";</script><% break;
		case -1:%><script>alert("请选择笔记类型！");window.location="../notesUI.jsp";</script><% break;
		case -2:%><script>alert("请输入笔记内容！");window.location="../notesUI.jsp";</script><% break;
		case -3:%><script>alert("增加成功！");window.location="../notesUI.jsp";</script><% break;
		case -4:%><script>alert("网络不佳，增加失败！");window.location="../notesUI.jsp";</script><% break;
		case -5:%><script>alert("删除成功！");window.location="../notesUI.jsp";</script><% break;
		case -6:%><script>alert("网络不佳，删除失败！");window.location="../notesUI.jsp";</script><% break;
		case -7:%><script>alert("页码输入有误！");window.location="../notesUI.jsp";</script><% break;
	}
 %>
