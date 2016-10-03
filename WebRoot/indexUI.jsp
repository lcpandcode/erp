
<%@page import="DAO.CollectDAO"%>
<%@page import="DAO.NoteDAO"%>
<%@page import="DAO.ScheduleDAO"%>
<%@page import="DAO.FinanceDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	//验证是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//对用户的所有记录数据进行统计
	//获取finance条数
	FinanceDAO daoFinance = new FinanceDAO();
	int countFinance = daoFinance.findAllFinanceCount(user_id);
	//获取schedule条数
	ScheduleDAO daoSchedule = new ScheduleDAO();
	int countSchedule = daoSchedule.findAllScheduleCount(user_id);
	//获取note条数
	NoteDAO daoNote = new NoteDAO();
	int countNote = daoNote.findAllNoteCount(user_id);
	//获取collect条数
	CollectDAO daoCollect = new CollectDAO();
	int countCollect = daoCollect.findAllCollectCount(user_id);
 %>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>首页</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<script type="text/javascript" src="js/close_unit.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="#">MyNote</a>
						<div class="nav-collapse">
							<ul class="nav">
								<li class="active">
									<a href="indexUI.jsp">首页</a>
								</li>
								<li>
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
							<li class="active">
								<a href="indexUI.jsp"><i class="icon-white icon-home"></i> 首页</a>
							</li>
							<li>
								<a href="financesUI.jsp"><i class="icon-folder-open"></i> 我的财务</a>
							</li>
							<li>
								<a href="schedulesUI.jsp"><i class="icon-check"></i> 我的日程</a>
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
						首页
					</h4>
					<div id="hreo_unit" class="hero-unit">
						<h3>
							MyNote欢迎您！
						</h3>
						<p>
							欢迎使用MyNote,如您首次使用该软件，可以选择查看使用教程！
						</p>
						<p>
							<a href="helpUI.jsp" class="btn btn-primary btn-large">我需要帮助</a> <a class="btn btn-large" onclick="close_unit()">不，谢谢</a>
						</p>
					</div>
					<div class="well summary">
						<ul>
							<li>
								<a href="financesUI.jsp"><span class="count"><%=countFinance %></span> 我的财务</a>
							</li>
							<li>
								<a href="schedulesUI.jsp"><span class="count"><%=countSchedule %></span> 我的日程</a>
							</li>
							<li>
								<a href="notesUI.jsp"><span class="count"><%=countNote %></span> 我的笔记</a>
							</li>
							<li class="last">
								<a href="collectsUI.jsp"><span class="count"><%=countCollect %></span> 我的收藏</a>
							</li>
						</ul>
					</div>
					<h2>
						最近添加记录
					</h2>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>
									记录名称
								</th>
								<th>
									记录类型
								</th>
								<th>
									添加时间
								</th>
								<th>
									查看/修改/删除
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									Nike.com Redesign
								</td>
								<td>
									New Task
								</td>
								<td>
									4 days ago
								</td>
								<td>
									<a href="#" class="view-link">查看</a>&nbsp;&nbsp;
									<a href="#" class="view-link">修改</a>&nbsp;&nbsp;
									<a href="#" class="view-link">删除</a>
								</td>
							</tr>
						</tbody>
					</table>
					<ul class="pager">
						<li class="next">
							<a href="addRecordUI.jsp">更多 &rarr;</a>
						</li>
					</ul>
					
				</div>
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
	</body>
</html>