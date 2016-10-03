<%@page import="DAO.NoteDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<%
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
	}
	//获取url传参的note_id和note_title
	String note_title = request.getParameter("note_title");
	int note_id = Integer.parseInt(request.getParameter("note_id"));
	String note_typeName = request.getParameter("note_typeName");
	//读取笔记内容
	NoteDAO dao = new NoteDAO();
	String note_summary = dao.findNoteSummaryByNoteId(note_id);
 %>
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>查看笔记 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<script src="js/note.js"></script>
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
							<li>
								<a href="indexUI.jsp"><i class="icon-home"></i> 首页</a>
							</li>
							<li>
								<a href="financesUI.jsp"><i class="icon-folder-open"></i> 我的财务</a>
							</li>
							<li>
								<a href="schedulesUI.jsp"><i class="icon-check"></i> 我的日程</a>
							</li>
							<li class="active">
								<a href="notesUI.jsp"><i class="icon-white icon-home"></i> 我的笔记</a>
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
					<div class="hero-unit">
						<h3>
							笔记标题：<%=note_title %>
						</h3>
						<p>
							笔记内容：<%=note_summary %>
						</p>
						<a href="#new-project2" class="toggle-link"><i class="icon-plus"></i>修改笔记</a>
					</div>
				</div>
				
				<!-- 修改笔记模块begin -->
				<form id="new-project2" class="form-horizontal hidden" action="jspDo/noteAddDo.jsp" method="post">
					<fieldset>
						<p><span>修改笔记</span></p>
						<div class="control-group">
							<label  class="control-label" for="input01">笔记题目</label>
							<div class="controls">
								<input type="text" name="note_title" class="input-xlarge" id="note_title" value="<%=note_title %>" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="select01">笔记类型</label>
							<div class="controls">
								<select name="fin_typeName" id="fin_typeName">
									<%
									if("高数笔记".equals(note_typeName)){
									%>
									<option selected="selected">高数笔记</option> 
									<%
									}else{
									%>
									<option>高数笔记</option>
									<%
									}
									if("光学笔记".equals(note_typeName)){
									%>
									<option selected="selected">光学笔记</option> 
									<%
									}else{
									%>
									<option>光学笔记</option>
									<%
									}
									if("电路笔记".equals(note_typeName)){
									%>
									<option selected="selected">电路笔记</option> 
									<%
									}else{
									%>
									<option>电路笔记</option>
									<%
									}
									if("其他笔记".equals(note_typeName)){
									%>
									<option selected="selected">其他笔记</option> 
									<%
									}else{
									%>
									<option>其他笔记</option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="textarea">笔记内容</label>
							<div class="controls">
								<textarea class="input-xlarge" name="fin_summary" id="fin_summary" rows="5" ><%=note_summary %></textarea>
							</div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">修改</button> <button class="btn" type="button" onclick="cancel_update()">取消</button>
						</div>
					</fieldset>
				</form>
				<!-- 修改笔记模块 end-->
				
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
		
	</body>
</html>