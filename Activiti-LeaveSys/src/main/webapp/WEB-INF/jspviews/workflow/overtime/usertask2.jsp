<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="en">
	<head>
	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
	 <link href="${pageContext.request.contextPath}/css/plugins/jsTree/style.min.css" rel="stylesheet">
	    <script src="${pageContext.request.contextPath}/js/plugins/toastr/toastr.min.js"></script>
	      <link href="${pageContext.request.contextPath}/css/plugins/toastr/toastr.min.css" rel="stylesheet">
		<title></title>
      </style>
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
							<li class="active" targeturl=''>加班单</li>
						</ul>
					</div>

				<div class="page-content">
						   <form class="form-horizontal" action="${pageContext.request.contextPath}/workflow/overtime/doapprove/${task.id}/${prcessInstanceid}" method="post">
			           <input id='id'  name='id' type="hidden" value="${bean.id }"/>
			            <input id='pass' name='pass' type="hidden" value="true"/>
						<div class="row">
						
						 <div class="col-sm-12">
							 <ul class="steps"> 
										<li data-step="1" class="active">
											<span class="step">1</span>
											<span class="title">提交加班单</span>
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
		                           				<td>加班时间起：</td>
		                           				<td>
		                           				<fmt:formatDate value="${bean.datefrom}" pattern="yyyy-MM-dd HH:mm"/>
		                           				</td>
		                           				<td>加班时间止：</td>
		                           				<td><fmt:formatDate value="${bean.datefrom}" pattern="yyyy-MM-dd HH:mm"/></td>
		                           			</tr>
		                           			<tr>
		                           				<td>共计小时：</td>
		                           				<td colspan="3">${bean.hours} 小时</td>
		                           			
		                           			
		                           				
		                           			</tr>
		                           			<tr>	
		                           				<td>请假原因</td>
												<td colspan="3"> ${bean.remark }</td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>
		                           				<td>提示</td>
		                           				<td colspan="3" > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>必须下班前申请</li>
									    					<li>必须审核通过才能加班，加班订餐</li>
									    				</ol>
		                           				</td>
		                           			</tr>
		                           		</tbody>
		                           	</table> 
                            </div>
                            
                             <div class="col-sm-12 ">
				                        <div class="page-header">
											<h1>处理意见 </h1>
										</div>
										<div class="form-group">
														 <label>意见</label>
															<textarea id="approvals" name="approvals" rows="2"  style="widows: 100%"  class="form-control"></textarea>
										</div>
											
													
										 <div class="form-group">
											    <button type="submit" class="btn btn-primary" onclick="$('#pass').val('true')">同意</button>
												<button type="submit" class="btn  btn-warning" onclick="$('#pass').val('false')">不同意</button>
										</div>
									</div>	  
									
                              <div class="col-sm-12 table-responsive">
									     <h5>流程信息</h5>
											<%@include file="../history.jsp" %>
		                      </div>
                            
                        </div>
                        </form>
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
	    	if("${task.name}"=='提交加班单'){
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
