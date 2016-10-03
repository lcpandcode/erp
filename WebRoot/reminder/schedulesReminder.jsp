<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	//接收并解析参数
	int rtn;
	//为防止非法操作，进行相应的非法操作拦截，出现异常说明是非法的访问，进行跳转转操作
	try{
		rtn = Integer.parseInt(request.getParameter("rtn"));
	}catch(NumberFormatException e){
		e.printStackTrace();
		//非法操作，提示未登录并跳转到登录界面
		response.sendRedirect("notLoginReminder.jsp");
		return;
	}
	switch(rtn){
		case(0): %><script>alert("日程名称不能为空，请重新输入！");window.location="../schedulesUI.jsp";</script><%break;
		case(1): %><script>alert("日程说明不能为空，请重新输入！");window.location="../schedulesUI.jsp";</script><%break;
		case(2): %><script>alert("日程添加成功！");window.location="../schedulesUI.jsp";</script><%break;
		case(3): %><script>alert("网络不佳，添加日程失败，请重新操作！");window.location="../schedulesUI.jsp";</script><%break;
		case(4): %><script>alert("删除成功！");window.location="../schedulesUI.jsp";</script><%break;
		case(5): %><script>alert("网络不佳，删除失败，请重新操作！");window.location="../schedulesUI.jsp";</script><%break; 
		case(6): %><script>alert("页码输入错误，请重新操作！");window.location="../schedulesUI.jsp";</script><%break;
		case(7): %><script>alert("非法操作，请重新操作！");window.location="../schedulesUI.jsp";</script><%break;
		case(8): %><script>alert("修改成功！");window.location="../schedulesUI.jsp";</script><%break;
		case(9): %><script>alert("网络异常，操作失败，请重新操作！");window.location="../schedulesUI.jsp";</script><%break;
	}
%>

