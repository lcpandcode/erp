<%@page import="VO.scheduleVO.ScheduleAddVO"%>
<%@page import="service.ScheduleServerce"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//设置编码格式
	request.setCharacterEncoding("utf-8");
	//获取前端输入数据并拦截非法输入
	String sch_name = request.getParameter("sch_name");
	if(sch_name==null || "".equals(sch_name)){
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=0");
		return;
	}
	String sch_summary = request.getParameter("sch_summary");
	if(sch_summary==null || "".equals(sch_summary)){
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=1");
		return;
	}
	//进行数据库插入操作
	ScheduleServerce serverce = new ScheduleServerce();
	ScheduleAddVO vo = new ScheduleAddVO();
	//初始化封装类
	vo.sch_name = sch_name;
	vo.sch_summary = sch_summary;
	vo.user_id = user_id;
	boolean rtn = serverce.scheduleAddDo(vo);
	if(rtn){
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=2");
		return;
	}else{
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=3");
	}
%>


