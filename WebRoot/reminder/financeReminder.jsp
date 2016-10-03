<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	int rtn = Integer.parseInt(request.getParameter("rtn"));//优化：考虑用switch-case语句
	switch(rtn){
		case -1: %><script>alert("金额输入不能为空！");window.location="../financesUI.jsp";</script><% break;
		case -2: %><script>alert("您输入金额的格式不对！");window.location="../financesUI.jsp";</script><% break;
		case -3: %><script>alert("请选择消费类型！");window.location="../financesUI.jsp";</script><% break;
		case -4: %><script>alert("网络异常，请稍后再试！");window.location="../financesUI.jsp";</script><% break;
		case 1: %><script>alert("添加记录成功！");window.location="../financesUI.jsp";</script><% break;
		case -5: %><script>alert("删除记录失败，请重新操作！");window.location="../financesUI.jsp";</script><% break;
		case 2: %><script>alert("删除记录成功！");window.location="../financesUI.jsp";</script><% break;
		case -6: %><script>alert("当前记录为空，不可进行删除操作！");window.location="../financesUI.jsp";</script><% break;
		case -7: %><script>alert("您输入的跳转页码不合法，请重新操作！");window.location="../financesUI.jsp";</script><% break;
		case -8: %><script>alert("页码数必须大于0！");window.location="../financesUI.jsp";</script><% break;
		case -9: %><script>alert("页码数不可大于总页数！");window.location="../financesUI.jsp";</script><% break;
		case -10: %><script>alert("非法操作，请重新操作！");window.location="../financesUI.jsp";</script><% break;
		case -11: %><script>alert("请输入时间！");window.location="../financesUI.jsp";</script><% break;
		case -12: %><script>alert("修改记录成功！");window.location="../financesUI.jsp";</script><% break;
	}
	
	
 %>
