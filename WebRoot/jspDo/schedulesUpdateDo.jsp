<%@page import="org.apache.taglibs.standard.tag.common.fmt.FormatNumberSupport"%>
<%@page import="VO.scheduleVO.ScheduleUpdateVO"%>
<%@page import="DTO.scheduleDTO.ScheduleDTO"%>
<%@page import="service.ScheduleServerce"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//设置编码格式
	request.setCharacterEncoding("utf-8");
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return;
	}
	//获取需要更新信息的种类（根据一个sch_typeId类标记，1表示修改完成状态，2表示修改内容和标题）
	Integer sch_updateTypeId = null;
	try{
		sch_updateTypeId = Integer.parseInt(request.getParameter("sch_updateTypeId"));
	}catch(NumberFormatException e){
		e.printStackTrace();
		//捕获异常，非法操作，拦截并提示
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=7");
		return;
	}
	//获取sch_id
	Integer sch_id = null;
	try{
		sch_id = Integer.parseInt(request.getParameter("sch_id"));
	}catch(NumberFormatException e){
		//捕获异常，拦截非法操作
		e.printStackTrace();
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=7");
		return;
	}
	ScheduleServerce serverce = new ScheduleServerce();
	ScheduleUpdateVO vo = new ScheduleUpdateVO();
	vo.sch_updateTypeId = sch_updateTypeId;
	vo.sch_id = sch_id;
	if(sch_updateTypeId==1){
		//判断修改状态的操作
		Integer updateIsDoType = null;
		try{
			updateIsDoType = Integer.parseInt(request.getParameter("sch_updateIsDoTypeId"));
		}catch(NumberFormatException e){
			//捕获异常，表明是非法操作，进行拦截
			e.printStackTrace();
			response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=7");
			return;
		}
		if(updateIsDoType==1){
			//updateIsDonType的值是1说明是将日程状态改为未完成
			vo.sch_isDone = 0;
			vo.sch_completeTime = null;//由于是将已完成的日程改为为完成，所以sch_comleteTime初始化为 null
		}else{
			//获取当前时间
			Date date = new Date();
			SimpleDateFormat sch_completeTimeFormat = new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss");
			String sch_completeTime = sch_completeTimeFormat.format(date);
			vo.sch_completeTime = sch_completeTime;
			//修改状态
			vo.sch_isDone = 1;
		}
	}else if(sch_updateTypeId==2){
		//修改日程内容
		//获取表单提交的数据
		String sch_summary = request.getParameter("sch_summary2");
		String sch_name = request.getParameter("sch_name2");
		//拦截输入为空的操作
		if(sch_name==null || "".equals(sch_name)){
			response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=0");
			return;
		}else if(sch_summary==null || "".equals(sch_summary)){
			response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=1");
			return;
		}
		vo.sch_name = sch_name;
		vo.sch_summary = sch_summary;
	}
	boolean rtn = serverce.scheduleUpdate(vo);
	if(rtn){
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=8");
		return;
	}else{
		response.sendRedirect("../reminder/schedulesReminder.jsp?rtn=9");
	}
%>


