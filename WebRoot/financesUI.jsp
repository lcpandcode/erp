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
	//读取finance列表对应页码的数据（分页读取）
	int pages = 1;//页码默认开始为首页
	//获取传参的页码值
	String pageStr = request.getParameter("pages");
	if(pageStr!=null){
		try{
			pages = Integer.parseInt(pageStr);
			if(pages<1){
				response.sendRedirect("reminder/financeReminder.jsp?rtn=-8");
				return;
			}
		}catch(NumberFormatException e){
			e.printStackTrace();
			//捕获异常，说明用户输入的页码不合法，跳转至提示页面
			response.sendRedirect("reminder/financeReminder.jsp?rtn=-7");
			return;
		}	
	}
	int limit = 5;//每页的条数
	FinanceDAO dao = new FinanceDAO();
	List <FinanceDTO> list = dao.findAllFinanceInBatch(((pages-1)*limit), limit,user_id);
	Iterator<FinanceDTO> it = list.iterator();
	//获取总页数
	int pageTotal = 1;
	int count = dao.findAllFinanceCount(user_id);
	if(count%limit==0){
		pageTotal = count/limit;
	}else{
		pageTotal = count/limit + 1;
	}
	if(pages>pageTotal && pageTotal>0){
		response.sendRedirect("reminder/financeReminder.jsp?rtn=-9");
	}
%>
		<meta charset="utf-8">
		<title>我的财务 - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
		<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<script type="text/javascript" src="js/finance.js"></script>
		<style> input[type="number"] {height:30px;} </style>
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
				<div class="span9">
					<h4>
						消费记录
					</h4>

					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>
									记录类型（支出/收入）	
								</th>
								<th>
									消费/收入类型
								</th>
								<th>
									收入/支出金额
								</th>
								<th>
									消费时间
								</th>
								<th>
									消费说明
								</th>
								<td>
									剩余资产
								</td>
								<th>
									删除/查看
								</th>
							</tr>
						</thead>
					<%
						//首先判断数据库中的读取结果，查看是否读取到记录
						if(list.size()==0){
					%>
							<tr>
								<th>
									您尚未添加任何消费记录！	
								</th>
							</tr>
					<%
						}else{
					%>
						<tbody>
							<%
							FinanceDTO vo = null;
							while(it.hasNext()){
								vo = it.next();
							%>
							<tr>
								<td>
									<%
									if(vo.fin_money>0){
									%>
									收入
									<%
									}else{
									%>
									支出
									<%
									}
									 %>
								</td>
								<td>
									<%=vo.fin_type %>
								</td>
								<td>
									<%
									if(vo.fin_money>0){
										%>
										+<%=vo.fin_money%>
										<%
									}else{
										%>
										<%=vo.fin_money%>
										<%
									}
									 %>
								</td>
								<td>
									<%=vo.fin_time%>
								</td>
								<td>
									<%=vo.fin_summary%>
								</td>
								<td>
									<%=vo.fin_moneyTotal %>
								</td>
								<td>
									<a href="jspDo/financesDeleteDo.jsp?fin_id=<%=vo.fin_id %>&fin_money=<%=vo.fin_money %>" class="view-link">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="financeViewUI.jsp?fin_id=<%=vo.fin_id %>">查看</a>
								</td>
							</tr>
							<%
							}
							 %>
						</tbody>
					<%
						}
					 %>
					</table>
					
					<!-- 分页模块begin -->
						<div width="50%" style="margin-top:5px;text-align:right;float:right;">
							<form name="f1" method="post" action="financesUI.jsp" onSubmit="return checkNum(<%=pageTotal%>);">	
								第<%=pages%>页&nbsp;&nbsp;
								共<%=pageTotal%>页&nbsp;&nbsp;
								<a href="financesUI.jsp?pages=1">首页</a>&nbsp;&nbsp;
								<a href="financesUI.jsp?pages=<%=(pages<1)?pages:(pages-1)%>" onclick="return checkDoLastPage(<%=pages %>)">上一页</a>&nbsp;&nbsp;
								<a href="financesUI.jsp?pages=<%=(pages>pageTotal)?pages:(pages+1)%>"onclick="return checkDoNextPage(<%=pages%>,<%=pageTotal%>)">下一页</a>&nbsp;&nbsp;
								<a href="financesUI.jsp?pages=<%=pageTotal%>">最后一页</a>&nbsp;&nbsp;
								转到第&nbsp;<input type="number" id="pages" name="pages" style="width:80px "  max="<%=pageTotal %>" min="1" step="1" />&nbsp;页&nbsp;&nbsp;
								<input type="submit" value="GO" name="pages" onclick="return checkPageInput();">
							</form>
						</div>
					<!-- 分页模块end -->
					<br/><br/><br/>
					<a class="toggle-link" href="#new-project1" onclick="close_project2()"><i class="icon-plus"></i> 添加消费记录</a>
					<a class="toggle-link" href="#new-project2" onclick="close_project1()"><i class="icon-plus"></i> 添加收入记录</a>
					
					<form id="new-project1" class="form-horizontal hidden" action="finance.do?type=1&id=0" method="post">
						<fieldset>
							<legend>新增消费记录</legend>
							<div class="control-group">
								<label  class="control-label" for="input01">消费金额</label>
								<div class="controls">
									<input type="number" min="0" name="fin_money" class="input-xlarge" id="fin_money1" />
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label" for="input01">消费时间</label>
								<div class="controls">
									<input type="date" name="fin_time" class="input-xlarge" id="fin_time1" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="select01">消费类型</label>
								<div class="controls">
									<select name="fin_type" id="fin_type1"> <option>-- 消费类型 --</option> <option>购物</option> <option>保险</option> 
									<option>旅游</option> <option>服务型</option><option>其他</option></select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">消费说明</label>
								<div class="controls">
									<textarea class="input-xlarge" name="fin_summary" id="fin_summary1" rows="3"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary" onclick="return checkAddFinanceForm1();">新增</button> <button class="btn" type="button" onclick="cancel_addAddOutlay()">取消</button>
							</div>
						</fieldset>
					</form>
					
					<form id="new-project2" class="form-horizontal hidden" action="finance.do?type=2&id=0" method="post">
						<fieldset>
							<p><span style="font-weight:bold;font-size:1.5em">新增收入记录</span></p>
							<div class="control-group">
								<label class="control-label" for="input01">收入金额</label>
								<div class="controls">
									<input type="number" min="0" name="fin_money" class="input-xlarge" id="fin_money2" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01">收入时间</label>
								<div class="controls">
									<input type="date" name="fin_time" class="input-xlarge" id="fin_time2" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="select01">收入类型</label>
								<div class="controls">
									<select name="fin_type" id="fin_type2"> <option>-- 收入类型 --</option> <option>工资</option>  
									<option>中奖</option> <option>投资</option><option>其他</option></select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">收入说明</label>
								<div class="controls">
									<textarea class="input-xlarge" name="fin_summary" id="fin_summary2" rows="3"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary" onclick="return checkAddFinanceForm2();">新增</button> <button class="btn" type="button" onclick="cancel_addAddIncome()">取消</button>
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
<% %>
