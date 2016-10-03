<%@page import="DAO.ScheduleDAO"%>
<%@page import="DTO.scheduleDTO.ScheduleDTO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<%
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//读取finance列表对应页码的数据（分页读取）
	int pages = 1;//页码默认开始为首页
	//获取传参的页码值
	String pageStr = request.getParameter("pages");
	if(pageStr!=null){
		try{
			pages = Integer.parseInt(pageStr);
			if(pages<1){
				response.sendRedirect("reminder/schedulesReminder.jsp?rtn=6");
				return;
			}
		}catch(NumberFormatException e){
			e.printStackTrace();
			//捕获异常，说明用户输入的页码不合法，跳转至提示页面
			response.sendRedirect("reminder/schedulesReminder.jsp?rtn=7");
			return;
		}	
	}
	int limit = 10;//每页的条数
	ScheduleDAO dao = new ScheduleDAO();
	List <ScheduleDTO> list = dao.findAllFinishScheduleInBatch(((pages-1)*limit),limit,user_id,1);
	Iterator<ScheduleDTO> itNotDone = list.iterator();
	//获取总页数
	int pageTotal = 1;
	int count = dao.findAllScheduleCount(user_id);
	if(count%limit==0){
		pageTotal = count/limit;
	}else{
		pageTotal = count/limit + 1;
	}
	if(pages>pageTotal){
		response.sendRedirect("reminder/schedulesReminder.jsp?rtn=6");
	}
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
		<style>input[type="number"]{heigth:30px;}</style>
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body onload="cancelAdd(),cancelUpdate()">
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
						已完成日程
					</h4>
					<ul class="tasks zebra-list">
					<%
						ScheduleDTO dto = null;
						if(!itNotDone.hasNext()){
					%>
						<li>
							<p>当前您没有已完成日程！</p>
						</li>
					<% 
						}else{
							while(itNotDone.hasNext()){
							dto = itNotDone.next();
					%>
						<li>
							<p>日程名称：<span id="schNameShow"> <%=dto.sch_name %></span>&nbsp;&nbsp;&nbsp;日程内容：<span id="schSummaryShow"><%=dto.sch_summary %></span></p>
							 <span class="meta">该日程创建于 <em><%=dto.sch_createTime %></em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;完成时间： <em><%=dto.sch_completeTime %></em></span><a href="jspDo/schedulesUpdateDo.jsp?sch_updateTypeId=1&sch_id=<%=dto.sch_id %>&sch_updateIsDoTypeId=1" class="view-link">我未完成该日程</a>&nbsp;&nbsp;&nbsp;<a href="jspDo/scheduleDeleteDo.jsp?sch_id=<%=dto.sch_id %>" class="view-link">删除该日程</a>
							 &nbsp;&nbsp;&nbsp;<a href="#" onclick="showUpdateScheudle(<%=dto.sch_id %>)">修改该日程</a>
						</li>
					<%
							}
						}
					%>
					</ul>
					
					<!-- 分页模块begin -->
						<div width="50%" style="margin-top:5px;text-align:right;float:right;">
							<form name="f1" method="post" action="schedulesViewNotDone.jsp" onSubmit="return checkNum(<%=pageTotal%>);">	
								第<%=pages%>页&nbsp;&nbsp;
								共<%=pageTotal%>页&nbsp;&nbsp;
								<a href="schedulesViewDoneUI.jsp?pages=1">首页</a>&nbsp;&nbsp;
								<a href="schedulesViewDoneUI.jsp?pages=<%=(pages<1)?pages:(pages-1)%>" onclick="return checkDoLastPage(<%=pages %>);">上一页</a>&nbsp;&nbsp;
								<a href="schedulesViewDoneUI.jsp?pages=<%=(pages>pageTotal)?pages:(pages+1)%>" onclick="return checkDoNextPage(<%=pages%>,<%=pageTotal%>);">下一页</a>&nbsp;&nbsp;
								<a href="schedulesViewDoneUI.jsp?pages=<%=pageTotal%>">最后一页</a>&nbsp;&nbsp;
								转到第<input type="number" min="0" max="<%=pageTotal %>" step="1" id="pages" name="pages" style="width:60px;" />页&nbsp;&nbsp;
								<input type="submit" value="GO" name="pages">
							</form>
						</div>
					<!-- 分页模块end -->
					
					<a href="javascript: void(0)" onclick="showAddSchedule()"><i class="icon-plus"></i> 新建日程</a>
					<form id="new-task1"  method="post" action="jspDo/schedulesAddDo.jsp">
						<fieldset>
							<legend>添加日程</legend>
							<div class="control-group">
								<label class="control-label" for="textarea">日程名称：</label>&nbsp;&nbsp;
								<input  type="text" name="sch_name" id="sch_name" />
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">日程说明</label>
								<div class="controls">
									<textarea class="input-xlarge" name="sch_summary" id="sch_summary" rows="2"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">增加</button> <button type="button" class="btn" onclick="cancelAdd()">取消</button>
							</div>
						</fieldset>
					</form>
					
					<!-- 由于每个日程的修改sch_id对应不同，所以这里通过js动态地初始化action中值 -->
					<form id="new-task2"  method="post" action="#">
						<fieldset>
							<legend>修改日程</legend>
							<div class="control-group">
								<label class="control-label" for="textarea">日程名称：</label>&nbsp;&nbsp;
								<input  type="text" name="sch_name2" id="sch_name2" />
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">日程说明</label>
								<div class="controls">
									<textarea class="input-xlarge" name="sch_summary2" id="sch_summary2" rows="2"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">修改</button> <button type="button" class="btn" onclick="cancelUpdate()">取消</button>
							</div>
						</fieldset>
					</form>
					
				</div>
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
	</body>
</html>



