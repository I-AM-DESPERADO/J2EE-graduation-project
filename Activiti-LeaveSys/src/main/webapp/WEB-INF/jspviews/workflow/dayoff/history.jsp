<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
   <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
	<head>
	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
	 <link href="${pageContext.request.contextPath}/css/plugins/jsTree/style.min.css" rel="stylesheet">
	    <script src="${pageContext.request.contextPath}/js/plugins/toastr/toastr.min.js"></script>
	      <link href="${pageContext.request.contextPath}/css/plugins/toastr/toastr.min.css" rel="stylesheet">
		<title></title>
    
	</head>
	<body>
	
			<div class="main-content">
			  <input id='deptid' type="hidden"/>
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" >请假单历史</li>
						</ul>
					</div>

				<div class="page-content">
						<div class="row">
						
						 <div class="col-sm-12">
							  <ul class="steps"> 
										<li data-step="1" class="active">
											<span class="step">1</span>
											<span class="title">提交申请单</span>
										</li>
	
										<li data-step="2">
											<span class="step">2</span>
											<span class="title">部门经理审核</span>
										</li>
	
										<li data-step="3">
											<span class="step">3</span>
											<span class="title">总经理审核</span>
										</li>
	
										<li data-step="4">
											<span class="step">4</span>
											<span class="title">任务结束</span>
										</li>
								</ul>
						 </div>
                            <div class="col-sm-12 table-responsive">
		                               	<table class='table table-bordered'>
		                           		<thead>
		                           		<tr  ><th style="text-align: center;" colspan="4" >请假单</th></tr>
		                           		</thead>
		                           		<tbody>
		                           		
		                           		  
		                           		  <tr>
		                           				<td>部门：</td>
		                           				<td>
		                           				${bean.deptment.name }
		                           				
		                           				</td>
		                           				<td>姓名：</td>
		                           				<td>${bean.chinesename }</td>
		                           			</tr>
		                           			
		                           			 
		                           		  <tr>
		                           				<td>工号：</td>
		                           				<td>${bean.username }</td>
		                           				<td>电话：</td>
		                           				<td>${bean.tel }</td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>请假时间起：</td>
		                           				<td>
		                           				<fmt:formatDate value="${bean.datefrom}" pattern="yyyy-MM-dd HH:mm"/>
		                           				</td>
		                           				<td>请假时间止：</td>
		                           				<td><fmt:formatDate value="${bean.datefrom}" pattern="yyyy-MM-dd HH:mm"/></td>
		                           			</tr>
		                           			<tr>
		                           				<td>共计小时：</td>
		                           				<td >${bean.hours} 小时</td>
		                           			
		                           			
		                           				<td>请假类型</td>
		                           				<td> 
													<label class="radio-inline">
														
													  <input type="radio" name="type" ${bean.type =='病假'?"checked='checked'":""} id="inlineRadio1" value="病假"> 病假
													</label>
													<label class="radio-inline">
													  <input type="radio" name="type" ${bean.type =='调休假'?"checked='checked'":""}  id="inlineRadio2" value="调休假"> 调休假
													</label>
													<label class="radio-inline">
													  <input type="radio"  name="type"  ${bean.type =='工伤假'?"checked='checked'":""}  value="工伤假">工伤假
													</label>
													
													<label class="radio-inline">
													  <input type="radio" name="type"  ${bean.type =='事假'?"checked='checked'":""}  id="inlineRadio3" value="事假">事假
													</label>
													
													<label class="radio-inline">
													  <input type="radio"  name="type" ${bean.type =='丧假'?"checked='checked'":""} id="inlineRadio3" value="丧假">丧假
													</label>
													
		                           				</td>
		                           			</tr>
		                           			<tr>	
		                           				<td>请假原因</td>
												<td colspan="3"> ${bean.remark }</td>
		                           			</tr>
		                           			<tr>	
		                           				<td>领导意见</td>
												<td colspan="3"> ${bean.approve }</td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>
		                           				<td>提示</td>
		                           				<td colspan="3" > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>必须在请假前申请</li>
									    					<li>必须审核通过才能休假</li>
									    				</ol>
		                           				</td>
		                           			</tr>
		                           		</tbody>
		                           	</table> 
                            </div>
                            
                            
                              <div class="col-sm-12 table-responsive">
									     <h5>流程信息</h5>
											<%@include file="../history.jsp" %>
		                      </div>
                            
                        </div>
			</div><!-- /.main-content -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->
		
			<script>
			<c:if test="${response.code=='1'}">
			  toastr.success('${response.msg}');
			</c:if>
	
	    $(document).ready(function(){
	    	if("${task.name}"=='提交假单'){
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    	}
	    	else if("${task.name}"=='部门经理审核'){
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    		$(".steps li").eq(1).addClass("active");
	    	}else if("${task.name}"=='总经理审核'){
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    		$(".steps li").eq(1).addClass("active");
	    		$(".steps li").eq(2).addClass("active");
	    	}else{
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    		$(".steps li").eq(1).addClass("active");
	    		$(".steps li").eq(2).addClass("active");
	    		$(".steps li").eq(3).addClass("active");
	    	}
	    	
	    	
	    	$(".nav-list li").removeClass("active");
	    	$(".submenu a[href='${pageContext.request.contextPath}/workflow/ship/create']").parent().addClass("active");
	    });
    </script>
	</body>

</html>
