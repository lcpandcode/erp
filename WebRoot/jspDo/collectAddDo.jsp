<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="service.CollectServerce" %>
<%
	//验证是否登录
	//登录验证
	Integer user_idInt = (Integer)session.getAttribute("user_id");
	int user_id = 0;
	if(user_idInt==null ){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return ;
	}else{
		user_id = user_idInt;
	}
	//获取前端参数
	String col_name = request.getParameter("col_name");
	//进行非法拦截
	if(col_name==null || "".equals(col_name)){
		response.sendRedirect("../reminder/collectReminder.jsp?rtn=0");
		return;
	}
	String col_address = request.getParameter("col_address");
	if(col_address==null || "".equals(col_address)){
		response.sendRedirect("../reminder/collectReminder.jsp?rtn=1");
		return;
	}
	CollectServerce serverce = new CollectServerce();
	CollectAddVO vo = new CollectAddVO();
	vo.col_name = col_name;
	vo.col_address = col_address;
	vo.user_id = user_id;
	boolean rtn = serverce.collectAdd(vo);
	if(rtn){
		response.sendRedirect("../reminder/collectReminder.jsp?rtn=2");
		return;
	}else{
		response.sendRedirect("../reminder/collectReminder.jsp?rtn=3");
	}
%>

