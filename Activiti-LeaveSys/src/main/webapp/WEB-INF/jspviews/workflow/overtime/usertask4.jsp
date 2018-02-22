<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
							<li class="active" targeturl='${pageContext.request.contextPath}/user/index'>加班单审核</li>
						</ul>
					</div>

				<div class="page-content">
						   <form class="form-horizontal" action="${pageContext.request.contextPath}/workflow/ship/doapprove/${task.id}/${prcessInstanceid}" method="post">
			           <input id='id'  name='id' type="hidden" value="${bean.id }"/>
			            <input id='pass' name='pass' type="hidden" value="true"/>
						<div class="row">
						
						 <div class="col-sm-12">
							 <ul class="steps"> 
										<li data-step="1" class="active">
											<span class="step">1</span>
											<span class="title">提交申请单</span>
										</li>
	
										<li data-step="2">
											<span class="step">2</span>
											<span class="title">领导审核</span>
										</li>
	
										<li data-step="3">
											<span class="step">3</span>
											<span class="title">物流发货</span>
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
		                           		<tr  ><th style="text-align: center;" colspan="2" >发货单</th></tr>
		                           		</thead>
		                           		<tbody>
		                           		
		                           		  <tr>
		                           				<td>货物类别</td>
		                           				<td> 
		                           				<c:if test="${bean.type==1 }">工具</c:if>
		                           				<c:if test="${bean.type==2 }">耗材</c:if>
		                           				
		                           				</td>
		                           			</tr>
		                           		
		                           		  <tr>
		                           				<td>所属工程</td>
		                           				<td>XX 工程		</td>
		                           			</tr>
		                           			
		                           			
		                           			
		                           			<tr>
		                           				<td>客户单位</td>
		                           				<td>${bean.receiveName}		</td>
		                           			</tr>
		                           			<tr>
		                           				<td>客户地址</td>
		                           				<td> ${bean.receiveAddr }		</td>
		                           			</tr>
		                           			<tr>
		                           				<td>联系人/电话</td>
		                           				<td>${bean.receiveTel }	</td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>	
		                           				<td>要求送达日期</td>
		                           				<td>
													${bean.receiveDate }
		                           				</td>
		                           			</tr>
		                           			
		                           			<tr>	
		                           				<td>领导意见</td>
												<td>--同意</td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>	
		                           				<td>物流部门意见 </td>
												<td> </td>
		                           			</tr>
		                           			
		                           			
		                           				
		                           			<tr>	
		                           				<td>备注说明</td>
												<td> ${bean.remark }</td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				
		                           				<td colspan="2">
		                           				<h4 style="text-align: center; " class="widget-title lighter smaller"><b>发货清单</b> </h4>	
													 <table class='table table-bordered'>
						                           		<thead>
						                           			<tr>
						                           				<th width="30px;"><button id="addRow">＋</button></th>
						                           				<th>序号</th>
						                           				<th>类别</th>
						                           				<th>名称</th>
						                           				<th>数量</th>
						                           			</tr>
						                           		</thead>
						                           		<tbody>
						                           		  <tr>
						                           		  <td width="30px;"><button id="addRow" >-</button></td>
						                           		  		<td>1</td>
						                           				<td>耗材</td>
						                           				<td>水泥</td>
						                           				<td>17包</td>
						                           		  </tr>
						                           		  <tr>
						                           		  		<td width="30px;"><button id="addRow" >-</button></td>
						                           		  		<td>2</td>
						                           				<td>耗材</td>
						                           				<td>钢筋</td>
						                           				<td>12包</td>
						                           		  </tr>
						                           		  <tr> 
						                           		  		<td width="30px;"><button id="addRow" >-</button></td>
						                           		  		<td>3</td>
						                           				<td>XX砂石</td>
						                           				<td>水泥</td>
						                           				<td>12包</td>
						                           		  </tr>
						                           		  </tbody>
					                           		  </table>
													
		                           				</td>
		                           			</tr>
		                           			
		                           			
		                           			
		                           			
		                           			<tr>
		                           				<td>提示</td>
		                           				<td > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>工具类由部门经理审核完成</li>
									    					<li>耗材类由总经理审核</li>
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
	    	if("${task.name}"=='提交任务'){
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    	}
	    	else if("${task.name}"=='工程部审核'||"${task.name}"=='总经理审核'){
	    		$(".steps li").removeClass("active");
	    		$(".steps li").eq(0).addClass("active");
	    		$(".steps li").eq(1).addClass("active");
	    	}else if("${task.name}"=='物流发货'){
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
