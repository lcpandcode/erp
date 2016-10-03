<%@page import="DAO.ScheduleDAO"%>
<%@page import="DTO.scheduleDTO.ScheduleDTO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<%
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	/*
	*页面说明：获取的页面信息首先是首选的未完成日程和已完成日程各五条，然后提示用户可以查看所有完成
	*或者未完成的日程，查看后跳转到新的页面，以表格的形式列出信息
	*/
	//定义每页显示每种状态的条数并初始化为5
	int limit = 5;
	ScheduleDAO dao = new ScheduleDAO();
	//获取部分未完成日程的列表信息
	List<ScheduleDTO> listNotDone = dao.findAllFinishScheduleInBatch(0,limit,user_id,0);
	Iterator<ScheduleDTO> itNotDone = listNotDone.iterator();
	//获取部分已经完成的列表的信息
	List<ScheduleDTO> listDone = dao.findAllFinishScheduleInBatch(0, limit, user_id, 1);
	Iterator<ScheduleDTO> itDone = listDone.iterator();
	
 %>
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>我的日程 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<script src="js/schedule.js"></script>
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body>
		<div class="container">
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="#">MyNote</a>
						<div class="nav-collapse">
							<ul class="nav">
								<li>
									<a href="indexUI.jsp">首页</a>
								</li>
								<li class="active">
									<a href="schedulesUI.jsp">个人日程</a>
								</li>
								<li>
									<a href="financesUI.jsp">个人财务</a>
								</li>
								<li>
									<a href="notesUI.jsp">学习笔记</a>
								</li>
							</ul>
							<form class="navbar-search pull-left" action="">
								<input type="text" class="search-query span2" placeholder="Search" />
							</form>
							<ul class="nav pull-right">
								<li>
									<a href="registerUI.jsp">用户注册</a>
								</li>
								<li>
									<a href="loginUI.jsp">登录</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="span3">
					<div class="well" style="padding: 8px 0;">
						<ul class="nav nav-list">
							<li class="nav-header">
								导航
							</li>
							<li>
								<a href="indexUI.jsp"><i class="icon-home"></i> 首页</a>
							</li>
							<li>
								<a href="financesUI.jsp"><i class="icon-folder-open"></i> 我的财务</a>
							</li>
							<li class="active">
								<a href="schedulesUI.jsp"><i class="icon-white icon-home"></i> 我的日程</a>
							</li>
							<li>
								<a href="notesUI.jsp"><i class="icon-envelope"></i> 我的笔记</a>
							</li>
							<li>
								<a href="collectsUI.jsp"><i class="icon-file"></i> 我的收藏</a>
							</li>
							<li>
								<a href="addRecordUI.jsp"><i class="icon-list-alt"></i> 添加记录</a>
							</li>
							<li class="nav-header">
								个人资料 管理
							</li>
							<li>
								<a href="resumeUpdateUI.jsp"><i class="icon-user"></i> 个人资料修改</a>
							</li>
							<li>
								<a href="settingsUI.jsp"><i class="icon-cog"></i> 个性设置</a>
							</li>
							<li class="divider">
							</li>
							<li>
								<a href="helpUI.jsp"><i class="icon-info-sign"></i> 帮助</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="span9">
					<h4>
						未完成日程
					</h4>
					<ul class="tasks zebra-list">
					<%
						ScheduleDTO dto = null;
						if(!itNotDone.hasNext()){
					%>
						<li>
							<p>当前您没有未完成日程！</p>
						</li>
					<% 
						}else{
							while(itNotDone.hasNext()){
							dto = itNotDone.next();
					%>
						<li>
							<p>日程名称：<%=dto.sch_name %></p>
							<p>日程内容：<%=dto.sch_summary %></p>
							 <span class="meta">该日程创建于 <em><%=dto.sch_createTime %></em></span><a href="jspDo/schedulesUpdateDo.jsp?sch_updateTypeId=1&sch_id=<%=dto.sch_id %>&sch_updateIsDoTypeId=0" class="view-link">我已完成该日程</a>&nbsp;&nbsp;&nbsp;<a href="jspDo/scheduleDeleteDo.jsp?sch_id=<%=dto.sch_id %>" class="view-link">删除该日程</a>
							 &nbsp;&nbsp;&nbsp;<a href="schedulesViewNotDoneUI.jsp" class="view-link">查看更多未完成日程</a>
						</li>
					<%
							}
						}
					%>
					</ul>
					<a class="toggle-link" href="#" onclick="return addSchedule()"><i class="icon-plus"></i> 新建日程</a>
					<br><br>
					<form id="new-task"  method="post" action="jspDo/schedulesAddDo.jsp">
						<fieldset>
							<p><span style="font-weight:bold;font-size:1.5em">新增日程</span></p>
							<div class="control-group">
								<label class="control-label" for="textarea">日程名称：</label>
								<input  type="text" name="sch_name" id="sch_name" />
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">日程说明：</label>
								<div class="controls">
									<textarea class="input-xlarge" name="sch_summary" id="sch_summary" rows="2"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">新增</button> <button type="button" class="btn" onclick="cancelAdd()">取消</button>
							</div>
						</fieldset>
					</form>
					<h4>
						已完成日程
					</h4>
					<%
						if(!itDone.hasNext()){
					%>
					<ul class="tasks done">
						<li>
							<i class="icon-ok"></i> <span class="title">您当前没有已完成的日程！</span> 
						</li>
					</ul>
					<%
						}else{
						while(itDone.hasNext()){
							dto = itDone.next();
					%>
					<ul class="tasks done">
						<li>
							<i class="icon-ok"></i> <span class="title"><%=dto.sch_name %></span> <span class="meta">已完成，&nbsp;&nbsp;完成时间： <em><%=dto.sch_completeTime %></em></span><a href="jspDo/scheduleDeleteDo.jsp?sch_id=<%=dto.sch_id %>" class="view-link">删除该条记录</a><a href="schedulesViewDoneUI.jsp" class="view-link">&nbsp;&nbsp;&nbsp;&nbsp;查看更多已完成日程</a>
						</li>
					</ul>
					<%			
							}
						}
					 %>
				</div>
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
	</body>
</html>
