<!DOCTYPE html>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="com.pzy.jcook.sys.entity.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
 <%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
		<!-- page specific plugin styles -->
		<!-- text fonts -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fonts.googleapis.com.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace-skins.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace-rtl.min.css" />
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace-ie.min.css" />
		<![endif]-->
		<!-- inline styles related to this page -->
		<!-- ace settings handler -->
		<script src="${pageContext.request.contextPath}/assets/js/ace-extra.min.js"></script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
		<script src="${pageContext.request.contextPath}/assets/js/html5shiv.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/respond.min.js"></script>
		<![endif]-->
			<!--[if !IE]> -->
		<script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.3.min.js"></script>
		<![endif]-->
		<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="${pageContext.request.contextPath}/assets/js/excanvas.min.js"></script>
		<![endif]-->
		<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.custom.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.ui.touch-punch.min.js"></script>
		<!-- ace scripts -->
		<script src="${pageContext.request.contextPath}/assets/js/ace-elements.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/ace.min.js"></script>
  <!-- Data Tables -->
    <script src="${pageContext.request.contextPath}/js/plugins/dataTables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugins/dataTables/dataTables.bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/common.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/js/plugins/toastr/toastr.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquerydatatable.defaults.js?sf=1"></script>
      <decorator:head/>
	<script>
    $.common.setContextPath('${pageContext.request.contextPath}');
    </script>
	</head>

	<body class="no-skin">
		<!-- top -->
		<div id="navbar" class="navbar navbar-default   ace-save-state">
			<div class="navbar-container ace-save-state" id="navbar-container">
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>

				<div class="navbar-header pull-left">
					<a href="index.html" class="navbar-brand">
						<small>
							<i class="fa fa-leaf"></i>
							<spring:message code="jsp.index.title" />
						</small>
					</a>
				</div>

				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav pull-right">
						
					
						<li class="light-blue dropdown-modal pull-right" >
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="${pageContext.request.contextPath}/assets/images/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
										<small>欢迎,${currentUser.chinesename }</small>
								</span>

								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<!-- 
								<li>
									<a href="${pageContext.request.contextPath}/center">
										<i class="ace-icon fa fa-cog"></i>
										个人信息
									</a>
								</li>
								
								 -->  

								<li>
									<a href="${pageContext.request.contextPath}/sys/user/changepw">
										<i class="ace-icon fa fa-user"></i>
										修改密码
									</a>
								</li>

								<li class="divider"></li>
								<li>
									<a href="${pageContext.request.contextPath}/loginout">
										<i class="ace-icon fa fa-power-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		
		<div class="main-container ace-save-state" id="main-container">
			<!-- menu -->
			<div id="sidebar" class="sidebar   responsive  ace-save-state">
				<ul class="nav nav-list">
				<li class=" open">
						<a href="#" class="dropdown-toggle"><i class="menu-icon fa fa-list"></i>
							<span class="menu-text"> 工作流 </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>

						<b class="arrow"></b>
						<ul class="submenu">
							<li class=""><a href="${pageContext.request.contextPath}/workflow/tasktodo"> <i
									class="menu-icon fa fa-calendar"></i> <span class="menu-text">
										我的待办 </span>
							</a> <b class="arrow"></b>
							</li>
	
							<li class=""><a href="${pageContext.request.contextPath}/workflow/taskdone"> <i
									class="menu-icon fa fa-briefcase"></i> <span class="menu-text">
										我的已办 </span>
							</a> <b class="arrow"></b>
							</li>
	
							<li class=""><a href="${pageContext.request.contextPath}/workflow/dayoff/create"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										请假申请</span>
							</a> <b class="arrow"></b>
							</li>
							<li class=""><a href="${pageContext.request.contextPath}/workflow/overtime/create"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										加班申请</span>
							</a> <b class="arrow"></b>
							
							<li class=""><a href="${pageContext.request.contextPath}/workflow/dayoff/index"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										请假单查询</span>
							</a> <b class="arrow"></b>
							<li class=""><a href="${pageContext.request.contextPath}/workflow/overtime/index"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										加班单查询</span>
							</a> <b class="arrow"></b>
							<li class=""><a href="${pageContext.request.contextPath}/workflow/check/index"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										工时报表</span>
							</a> <b class="arrow"></b>
							</li>
							
							<li class=""><a href="${pageContext.request.contextPath}/workflow/dayoff/reportindex"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										请假统计报表</span>
							</a> <b class="arrow"></b>
							</li>
							
							<li class=""><a href="${pageContext.request.contextPath}/workflow/overtime/reportindex"> <i
									class="menu-icon fa  fa-pencil-square-o"></i> <span class="menu-text">
										加班统计报表</span>
							</a> <b class="arrow"></b>
							</li>
						</ul>
					</li>
				
				
			
				
				<li class=" open">
						<a href="#" class="dropdown-toggle"><i class="menu-icon fa fa-list"></i>
							<span class="menu-text"> 系统设置 </span>
							<b class="arrow fa fa-angle-down"></b>
						</a>

						<b class="arrow"></b>

						<ul class="submenu">
							<li class="">
								<a href="${pageContext.request.contextPath}/sys/user/index"><i class="menu-icon fa fa-users"></i>员工管理</a>
								<b class="arrow"></b>
							</li>
							
							<li>
								<a href="${pageContext.request.contextPath}/sys/deptment/index"><i class="menu-icon fa fa-folder-open"></i>部门管理</a>
								<b class="arrow"></b>
							</li>
							
							
						</ul>
					</li>
			
				
				
				
				</ul>
				<!-- /.nav-list -->
	
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>
			</div>
			<!--  end menu-->
			
			<decorator:body />
			
		</div>
	</body>
</html>
