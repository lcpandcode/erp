<%@page import="DTO.financeType.FinanceTypeDTO"%>
<%@page import="DAO.FinanceTypeDAO"%>
<%@page import="DAO.FinanceDAO"%>
<%@page import="DTO.financeDTO.FinanceDTO"%>
<%@page import="VO.financeVO.FinanceViewVO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<!--跳转说明：由于financesUI.jsp的加载都是经过financesUI.jsp的页面进行跳转操作的，所以，这个页面链接对应的目录应该是MyNote/jspDo而不是MyNote,所以跳转链接
	无需加返回上一级目录符号-->
	<head>
<%	
	//判断是否登录
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//设置接收参数的编码格式
	request.setCharacterEncoding("utf-8");
	//接收url传参的参数
	String fin_type = request.getParameter("fin_type");
	String fin_time = request.getParameter("fin_time");
	double fin_money = 0.0;
	try{
		fin_money = Double.parseDouble(request.getParameter("fin_money"));
	}catch(NumberFormatException e){
		//捕获异常，非法操作，进行拦截
		e.printStackTrace();
		response.sendRedirect("reminder/financeReminder.jsp?rtn=-10");
		return;
	}
	int fin_id = 0;
	try{
		fin_id = Integer.parseInt(request.getParameter("fin_id"));
	}catch(NumberFormatException e){
		e.printStackTrace();
		//拦截非法操作
		response.sendRedirect("reminder/financeReminder.jsp?rtn=-10");
		return;
	}
	String fin_summary = request.getParameter("fin_summary");
	//拦截非法操作
	if(fin_type==null || "".equals(fin_type) || fin_time==null || "".equals(fin_time) || fin_time==null || "".equals(fin_time)
	|| fin_summary==null || "".equals(fin_summary)){
		response.sendRedirect("reminder/financeReminder.jsp?rtn=-10");
		return;	
	}
	//读取finance_type
	FinanceTypeDAO dao = new FinanceTypeDAO();
	//获取支出类型数据
	FinanceTypeDTO dtoOutLay = dao.findAllTypeByAttribute(0);
	Iterator<String> itOutLay = dtoOutLay.fin_typeName.iterator();
	//获取收入类型数据
	FinanceTypeDTO dtoIncome = dao.findAllTypeByAttribute(1);
	Iterator<String> itIncome = dtoIncome.fin_typeName.iterator();
%>
		<meta charset="utf-8">
		<title>我的财务 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<script type="text/javascript" src="js/finance.js"></script>
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
								<li>
									<a href="schedulesUI.jsp">个人日程</a>
								</li>
								<li class="active">
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
									<a href="loginUI.jsp">登录</a>
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
							<li class="active">
								<a href="financesUI.jsp"><i class="icon-white icon-home"></i>我的财务</a>
							</li>
							<li>
								<a href="schedulesUI.jsp"><i class="icon-check"></i> 我的日程</a>
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
								个人资料 管理
							</li>
							<li>
								<a href="resumeUpdateUI.jsp"><i class="icon-user"></i> 个人资料修改</a>
							</li>
							<li>
								<a href="settingsUI.jsp"><i class="icon-cog"></i>个性设置</a>
							</li>
							<li class="divider">
							</li>
							<li>
								<a href="helpUI.jsp"><i class="icon-info-sign"></i> 帮助</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="span9" >
					<form id="new-project3" class="form-horizontal"  method="post" action="finance.do?fin_id=<%=fin_id%>&id=1">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="select01">记录类型</label>
									&nbsp;&nbsp;&nbsp;&nbsp;<select name="fin_typeAttribute3" id="fin_typeAttribute3" onchange="finChangeUpdate()">
									<%
										if(fin_money>=0){
									%>
										<option selected="selected">收入</option>
										<option>支出</option>
									<%		
										}else{
									%>
										<option>收入</option>
										<option selected="selected">支出</option>
									<%
										}
									%> 
									 </select>
							</div>
							<div class="control-group">
								<label class="control-label" id="fin_moneyLabel" for="input01">金额</label>
								<div class="controls">
									<input type="number" style="height:30px" name="fin_money3" class="input-xlarge" id="fin_money3" value="<%=fin_money %>" onclick="reminder_finTypeSelect()" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" id="fin_timeLabel" for="input01">时间</label>
								<div class="controls">
									<input type="date" name="fin_time3" class="input-xlarge" id="fin_time3" value="<%=fin_time %>" onclick="reminder_finTypeSelect()"/>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" id="fin_typeLabel" for="select01">类型</label>
							<%
								if(fin_money>=0){
							%>
									&nbsp;&nbsp;&nbsp;&nbsp;<select name="fin_type3" id="fin_type3Income" >
							<%		
									String fin_typeString1 = null;
									while(itIncome.hasNext()){
										fin_typeString1 = itIncome.next();
										if(fin_type.equals(fin_typeString1)){
							%>
											<option selected="selected"><%=fin_typeString1 %></option>
							<%
										}else{
							%>
											<option><%=fin_typeString1 %></option>
							<%
											}
										}
								 %>
									</select>
							
									<select name="fin_type3" id="fin_type3Outlay" onclick="reminder_finTypeSelect()" style="display:none;">
							<%		
									String fin_typeString2 = null;
									while(itOutLay.hasNext()){
										fin_typeString2 = itOutLay.next();
							%>
										<option><%=fin_typeString2 %></option>
							<%
										}
							%>
									</select>
							<%
								}else{
							%>
									&nbsp;&nbsp;&nbsp;&nbsp;<select name="fin_type3" id="fin_type3Income" onclick="reminder_finTypeSelect()" style="display:none;">
							<%		
									String fin_typeString1 = null;
									while(itIncome.hasNext()){
										fin_typeString1 = itIncome.next();
							%>
										<option><%=fin_typeString1 %></option>
							<%
										}
							%>
									</select>
									
									<select name="fin_type3" id="fin_type3Outlay" onclick="reminder_finTypeSelect()">
							<%		
									String fin_typeString2 = null;
									while(itOutLay.hasNext()){
										fin_typeString2 = itOutLay.next();
										if(fin_type.equals(fin_typeString2)){
							%>
											<option selected="selected"><%=fin_typeString2 %></option>
							<%
										}else{
							%>
											<option><%=fin_typeString2 %></option>
							<%
										}
									}
							%>
									</select>
							<%
								}
							 %>
							</div>
							<div class="control-group">
								<label class="control-label" id="fin_summaryLabel" for="textarea">说明</label>
								<div class="controls">
									<textarea class="input-xlarge" name="fin_summary3" id="fin_summary3" rows="3" onclick="reminder_finTypeSelect()"><%=fin_summary%> </textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary" onclick="return alter()">修改</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button class="btn" type="button" onclick="self.location=document.referrer;">取消</button>
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
