<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--[if lt IE 7 ]><html lang="en" class="ie6 ielt7 ielt8 ielt9"><![endif]--><!--[if IE 7 ]><html lang="en" class="ie7 ielt8 ielt9"><![endif]--><!--[if IE 8 ]><html lang="en" class="ie8 ielt9"><![endif]--><!--[if IE 9 ]><html lang="en" class="ie9"> <![endif]--><!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en"><!--<![endif]--> 
	<head>
		<meta charset="utf-8">
		<title>Projects - MyNote</title>
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
									<a href="indexUI.jsp">é¦é¡µ</a>
								</li>
								<li>
									<a href="tasks.htm">ä¸ªäººæ¥ç¨</a>
								</li>
								<li class="active">
									<a href="financesUI.jsp">ä¸ªäººè´¢å¡</a>
								</li>
								<li>
									<a href="messages.htm">å­¦ä¹ ç¬è®°</a>
								</li>
								
							</ul>
							<form class="navbar-search pull-left" action="">
								<input type="text" class="search-query span2" placeholder="Search" />
							</form>
							<ul class="nav pull-right">
								<li>
									<a href="profile.htm">ç¨æ·æ³¨å</a>
								</li>
								<li>
									<a href="loginUI.jsp">ç»å½</a>
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
								å¯¼èª
							</li>
							<li>
								<a href="indexUI.jsp"><i class="icon-home"></i> é¦é¡µ</a>
							</li>
							<li class="active">
								<a href="financesUI.jsp"><i class="icon-white icon-home"></i> æçè´¢å¡</a>
							</li>
							<li>
								<a href="tasks.htm"><i class="icon-check"></i> æçæ¥ç¨</a>
							</li>
							<li>
								<a href="messages.htm"><i class="icon-envelope"></i> æçç¬è®°</a>
							</li>
							<li>
								<a href="files.htm"><i class="icon-file"></i> æçæ¶è</a>
							</li>
							<li>
								<a href="activity.htm"><i class="icon-list-alt"></i> æ·»å è®°å½</a>
							</li>
							<li class="nav-header">
								ä¸ªäººèµæ ç®¡ç
							</li>
							<li>
								<a href="profile.htm"><i class="icon-user"></i> ä¸ªäººèµæä¿®æ¹</a>
							</li>
							<li>
								<a href="settingsUI.jsp"><i class="icon-cog"></i> ä¸ªæ§è®¾ç½®</a>
							</li>
							<li class="divider">
							</li>
							<li>
								<a href="help.htm"><i class="icon-info-sign"></i> å¸®å©</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="span9">
					<h1>
						Projects
					</h1>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>
									Name
								</th>
								<th>
									Client
								</th>
								<th>
									Tasks
								</th>
								<th>
									Messages
								</th>
								<th>
									Files
								</th>
								<th>
									Progress
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									Nike.com Redesign
								</td>
								<td>
									Monsters Inc
								</td>
								<td>
									<span class="badge">11</span>
								</td>
								<td>
									<span class="badge">2</span>
								</td>
								<td>
									<span class="badge">4</span>
								</td>
								<td>
									<div class="progress">
										<div class="bar" style="width: 60%;"></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									Twitter Server Consulting
								</td>
								<td>
									Bad Robot
								</td>
								<td>
									<span class="badge">7</span>
								</td>
								<td>
									<span class="badge">3</span>
								</td>
								<td>
									<span class="badge">0</span>
								</td>
								<td>
									<div class="progress">
										<div class="bar" style="width: 90%;"></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									Childrens Book Illustration
								</td>
								<td>
									Evil Genius
								</td>
								<td>
									<span class="badge">10</span>
								</td>
								<td>
									<span class="badge">2</span>
								</td>
								<td>
									<span class="badge">1</span>
								</td>
								<td>
									<div class="progress">
										<div class="bar" style="width: 20%;"></div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<a class="toggle-link" href="#new-project"><i class="icon-plus"></i> New Project</a>
					<form id="new-project" class="form-horizontal hidden">
						<fieldset>
							<legend>New Project</legend>
							<div class="control-group">
								<label class="control-label" for="input01">Project Name</label>
								<div class="controls">
									<input type="text" class="input-xlarge" id="input01" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="select01">Client</label>
								<div class="controls">
									<select id="select01"> <option>-- Select client --</option> <option>Bad Robot</option> <option>Evil Genius</option> <option>Monsters Inc</option> </select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="textarea">Project Summary</label>
								<div class="controls">
									<textarea class="input-xlarge" id="textarea" rows="3"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Create</button> <button class="btn">Cancel</button>
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
