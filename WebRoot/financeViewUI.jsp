<%@page import="DTO.financeDTO.FinanceDTO"%>
<%@page import="DAO.FinanceDAO"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	//验证登录否
	Integer user_id = (Integer)session.getAttribute("user_id");
	if(user_id==null){
		response.sendRedirect("reminder/notLoginReminder.jsp");
		return;
	}
	//获取url参数
	int fin_id = 0;
	try{
		fin_id = Integer.parseInt(request.getParameter("fin_id"));
	}catch(NumberFormatException e){
		//捕获异常，非法操作，拦截
		e.printStackTrace();
		response.sendRedirect("reminder/financeReminder.jsp?rtn=7");
		return;
	}
	//读取finance信息
	FinanceDAO dao = new FinanceDAO();
	FinanceDTO dto = dao.findFinanceByPrimaryKey(fin_id);
 %>

<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>resumeUpdateUI.jsp - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<script src="js/finance.js"></script>
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	</head>
	<body onload="financeViewLoad(<%=dto.fin_money%>)">
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
							<li class="active">
								<a href="resumeUpdateUI.jsp"><i class="icon-white icon-home"></i> 个人资料修改</a>
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
					<h3>
						消费记录
					</h3>
					<form id="edit-resumeUpdateUI.jsp" class="form-horizontal" action="financeUpdateUI.jsp?fin_id=<%=fin_id %>" method="post">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="input01">记录类型</label>
								<div class="controls">
									<input type="text" readonly="readonly" class="input-xlarge" id="recordTypeInput" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01" id="financeTypeLabel">支出/收入类型</label>
								<div class="controls">
									<input type="text" readonly="readonly" class="input-xlarge" name="fin_type" value="<%=dto.fin_type %>" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01" id="financeTimeLabel">消费/收入时间</label>
								<div class="controls">
									<input type="text" readonly="readonly" class="input-xlarge" name="fin_time" value="<%=dto.fin_time %>" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01" id="financeMoneyLabel">支出/收入金额</label>
								<div class="controls">
									<input type="text" readonly="readonly" class="input-xlarge" name="fin_money" value="<%=dto.fin_money %>" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"  for="input01">当前剩余金额</label>
								<div class="controls">
									<input type="text" readonly="readonly" class="input-xlarge" name="financeMoneyInput" value="<%=dto.fin_moneyTotal %> " />
								</div>
							</div>						
							<div class="control-group">
								<label class="control-label" for="textarea" id="financeSummaryLabel">支出/收入说明</label>
								<div class="controls">
									<textarea readonly="readonly" class="input-xlarge" name="fin_summary" rows="4"><%=dto.fin_summary %></textarea>
								</div>
							</div>				
							<div class="form-actions">
								<button type="submit" id="financeUpdateButton" class="btn btn-primary">我要修改该条记录</button>
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
