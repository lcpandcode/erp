<%@page import="VO.financeVO.FinanceViewVO"%>
<%@page import="service.FinanceServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head><script><script type="text/javascript" src="js/finance.js"></script></head>
	<%
	//验证是否登录
	Integer user_idInt = (Integer)session.getAttribute("user_id");
	if(user_idInt==null){
		//没有登录，跳转至提示界面
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return ;
	}
	//通过验证，进行查询操作
	FinanceServerce server = new FinanceServerce(); 
	ArrayList<FinanceViewVO> list = server.financeViewDo(user_idInt);
	request.setAttribute("financeList", list);
	//将list对象add进request中，然后通过转发的方式实现数据传输到另外一个界面，最后会得到结果返回
	request.getRequestDispatcher("../financesUI.jsp").forward(request, response);
%>
</html>

