<%@page import="VO.financeVO.FinanceDeleteVO"%>
<%@page import="service.FinanceServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return;
	}
	//获取通过url传参的fin_id的值
	String str = (String)request.getParameter("fin_id");
	if(str==null){
		//无数据时，提示不可删除
		response.sendRedirect("../reminder/financesReminder.jsp?rtn=-6");
	}
	FinanceServerce server = new FinanceServerce();
	FinanceDeleteVO vo = new FinanceDeleteVO();
	vo.fin_money = Double.parseDouble((String)request.getParameter("fin_money"));
	vo.fin_id = Integer.parseInt(str);
	vo.user_id = (Integer)session.getAttribute("user_id");
	boolean rtn = server.financeDeleteDo(vo);
	//判断是否 执行成功
	if(rtn){
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=2");
		return;
	}else{
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=-5");
	}
 %>
