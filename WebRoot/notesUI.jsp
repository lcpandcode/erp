<%@page import="DTO.scheduleDTO.ScheduleDTO"%>
<%@page import="DAO.NoteDAO"%>
<%@page import="DTO.noteDTO.NoteDTO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	
	//分页模块
	//读取finance列表对应页码的数据（分页读取）
	int pages = 1;//页码默认开始为首页
	//获取传参的页码值
	String pageStr = request.getParameter("pages");
	if(pageStr!=null){
		try{
			pages = Integer.parseInt(pageStr);
			if(pages<1){
				response.sendRedirect("reminder/schedulesReminder.jsp?rtn=-7");
				return;
			}
		}catch(NumberFormatException e){
			e.printStackTrace();
			//捕获异常，说明用户输入的页码不合法，跳转至提示页面
			response.sendRedirect("reminder/schedulesReminder.jsp?rtn=-7");
			return;
		}	
	}
	int limit = 5;//每页的条数
	NoteDAO dao = new NoteDAO();
	//根据user_id读取一批数据
	List <NoteDTO> list = dao.findAllNoteInBatch(((pages-1)*limit),limit,user_id);
	Iterator<NoteDTO> itNotDone = list.iterator();
	//获取总页数
	int pageTotal = 1;
	int count = dao.findAllNoteCount(user_id);
	if(count%limit==0){
		pageTotal = count/limit;
	}else{
		pageTotal = count/limit + 1;
	}
	if(pages>pageTotal){
		response.sendRedirect("reminder/noteReminder.jsp?rtn=-7");
	}
	//获取list的迭代器
	Iterator<NoteDTO> it = list.iterator();
 %>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>我的笔记 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<script src="js/note.js"></script>
		<style> input[type="number"] {height:30px;} </style>
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body onload="cancel_add()">
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
								<li>
									<a href="schedulesUI.jsp">个人日程</a>
								</li>
								<li>
									<a href="financesUI.jsp">个人财务</a>
								</li>
								<li class="active">
									<a href="financesUI.jsp">学习笔记</a>
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
					<h4>
						我的笔记
					</h4>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>
									笔记题目
								</th>
								<th>
									笔记类型
								</th>
								<th>
									添加时间
								</th>
								<th>
									查看/删除
								</th>
							</tr>
						</thead>
						<tbody>
						<%
							if(list.size()==0){
						%>
								<tr><td>您当前没有笔记记录！</td></tr>
						<%
							}else{
								NoteDTO dto = null;
								while(it.hasNext()){
									dto = it.next();
						%>
							<tr>
								<td>
									<%=dto.note_title %>
								</td>
								<td>
									<%=dto.note_typeName %>
								</td>
								<td>
									<%=dto.note_createTime %>
								</td>
								<td>
									<a href="noteViewUI.jsp?note_id=<%=dto.note_id %>&note_title=<%=dto.note_title %>&note_typeName=<%=dto.note_typeName %>" class="view-link">查看</a>&nbsp;&nbsp;
									<a href="jspDo/noteDeleteDo.jsp?note_id=<%=dto.note_id %>" class="view-link">删除</a>
								</td>
							</tr>
						<%
								}
							}
						 %>
							
						</tbody>
					</table>
					<a href="#new-project1" onclick="return addNewNote();"><i class="icon-plus"></i> 新增笔记</a>
					
					<!-- 分页模块begin -->
						<div width="50%" style="margin-top:5px;text-align:right;float:right;">
							<form name="f1" method="post" action="notesUI.jsp" onSubmit="return checkNum(<%=pageTotal%>);">	
								第<%=pages%>页&nbsp;&nbsp;
								共<%=pageTotal%>页&nbsp;&nbsp;
								<a href="notesUI.jsp?pages=1">首页</a>&nbsp;&nbsp;
								<a href="notesUI.jsp?pages=<%=(pages<1)?pages:(pages-1)%>" onclick="return checkDoLastPage(<%=pages %>)">上一页</a>&nbsp;&nbsp;
								<a href="notesUI.jsp?pages=<%=(pages>pageTotal)?pages:(pages+1)%>"onclick="return checkDoNextPage(<%=pages%>,<%=pageTotal%>)">下一页</a>&nbsp;&nbsp;
								<a href="notesUI.jsp?pages=<%=pageTotal%>">最后一页</a>&nbsp;&nbsp;
								转到第&nbsp;<input type="number" id="pages" name="pages" style="width:80px "  max="<%=pageTotal %>" min="1" step="1" />&nbsp;页&nbsp;&nbsp;
								<input type="submit" value="GO" name="pages">
							</form>
						</div>
					<!-- 分页模块end -->
					
					<br><br>
					<!-- 添加笔记模块begin -->
					<form id="new-project1" action="jspDo/noteAddDo.jsp" method="post">
						<fieldset>
							<p><span style="font-weight:bold;font-size:1.5em">新增笔记</span></p>
							<div class="control-group">
								<p><span style="font-weight:bold;">笔记题目</span></p>
								<div class="controls">
									<input type="text" name="note_title" class="input-xlarge" id="note_money" />
								</div>
							</div>
							
							<div class="control-group">
								<p><span style="font-weight:bold;">笔记类型</span></p>
								<div class="controls">
									<select name="note_type" id="note_type"> <option>-- 笔记类型 --</option> <option>高数笔记</option> <option>光学笔记</option> 
									<option>电路笔记</option> <option>课外读书</option><option>其他笔记</option></select>
								</div>
							</div>
							<div class="control-group">
								<p><span style="font-weight:bold;">笔记内容</span></p>
								<div class="controls">
									<textarea class="input-xlarge" name="note_summary" id="note_summary" rows="3"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">新增</button> <button class="btn" type="button" onclick="cancel_add()">取消</button>
							</div>
						</fieldset>
					</form>
					<!-- 添加笔记模块 end-->
				</div>
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/site.js"></script>
		
		
	</body>
</html>
