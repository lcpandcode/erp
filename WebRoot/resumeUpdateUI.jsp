<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>resumeUpdateUI.jsp - MyNote</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<link href="css/site.css" rel="stylesheet">
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
						修改个人信息
					</h3>
					<form id="edit-resumeUpdateUI.jsp" class="form-horizontal">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="input01">姓名</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" value="John Smith" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01">电话</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" value="555 555 555" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="input01">邮箱</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" value="john.smith@example.org" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="fileInput">头像</label>
								<div class="controls">
									<input class="input-file" id="fileInput" type="file" />
								</div>
							</div>						
							<div class="control-group">
								<label class="control-label" for="textarea">个人说明</label>
								<div class="controls">
									<textarea class="input-xlarge" id="textarea" rows="4">Web technology junkie who writes innovative and bestselling technical books. Also enjoys Sunday bicycle rides and all "good" comedy.</textarea>
								</div>
							</div>					
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">修改</button> <button class="btn">取消</button>
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
