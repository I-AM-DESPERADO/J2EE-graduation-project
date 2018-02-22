<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="en">
	<head>
		<title>打卡页面</title>
		<style type="text/css">
		   .error{
       color: red;
      }
      </style>
      	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
         <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
         <link href="${pageContext.request.contextPath}/css/plugins/toastr/toastr.min.css" rel="stylesheet">
	</head>
			<div class="main-content">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" targeturl='${pageContext.request.contextPath}/user/index'></li>
						</ul>
					</div>

				<div class="page-content">
						
				
				<div class='row'>
					<div class="col-md-6">
						<div class="panel panel-success">
						  <div class="panel-heading">上班打卡签到</div>
						  <div class="panel-body">
						   <form class="form-horizontal">
							  <div class="form-group">
							    <label for="inputEmail3" class="col-sm-2 control-label">部门</label>
							    <div class="col-sm-10">
							        <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.deptment.name }" readonly="readonly">
							 
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">工号</label>
							    <div class="col-sm-10">
							         <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.username }" readonly="readonly">
							         
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							    <div class="col-sm-10">
							        <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.chinesename }" readonly="readonly">
							 
							    </div>
							  </div>
							  
							  <div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <button type="button" onclick="check()" class="btn btn-success">打卡签到</button>
							    </div>
							  </div>
							</form>
						  </div>
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="panel panel-primary">
						  <div class="panel-heading">下班打卡签到</div>
						  <div class="panel-body">
						   <form class="form-horizontal">
							  <div class="form-group">
							    <label for="inputEmail3" class="col-sm-2 control-label">部门</label>
							    <div class="col-sm-10">
							      <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.deptment.name }" readonly="readonly">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">工号</label>
							    <div class="col-sm-10">
							     <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.username }" readonly="readonly">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							    <div class="col-sm-10">
							        <input type="email" class="form-control" id="inputEmail3" placeholder="Email" value="${sessionScope.currentUser.chinesename }" readonly="readonly">
							 
							    </div>
							  </div>
							  
							  <div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <button type="button" onclick="checkout()"  class="btn btn-primary">签退</button>
							    </div>
							  </div>
							</form>
						  </div>
						</div>
					</div>
					
				
				</div>
				
				<!-- /.page-content -->
			</div><!-- /.main-content -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

	<script>
	 <c:if test="${state=='success'}">
	  toastr.success('${tip}');
	 </c:if>
  
    $.common.setContextPath('${pageContext.request.contextPath}');
    function check(){
    	$.ajax({
    		   type: "POST",
    		   url:  $.common.getContextPath() + "/sys/user/check",
    		   success: function(msg){
    			   toastr.success(msg.msg);
    		   }
    		});
     }
    
    function checkout(){
    	$.ajax({
    		   type: "POST",
    		   url:  $.common.getContextPath() + "/sys/user/checkout",
    		   success: function(msg){
    			   toastr.success(msg.msg);
    		   }
    		});
     }
    $(document).ready(function(){
    	$(".nav-list li").removeClass("active");
    	$(".submenu a[href='${pageContext.request.contextPath}/sys/user/index']").parent().addClass("active");
    });
    </script>
    	</body>
</html>

