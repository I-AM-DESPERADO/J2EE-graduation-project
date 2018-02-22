<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="com.pzy.jcook.sys.entity.User"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="en">
	<head>
	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
	  <link href="${pageContext.request.contextPath}/css/plugins/jsTree/style.min.css" rel="stylesheet">
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
							<li class="active" targeturl='${pageContext.request.contextPath}/user/index'>部门管理</li>
						</ul>
					</div>

		<%
				Subject currentUser = SecurityUtils.getSubject();
				Session session2 = currentUser.getSession();
				User user =(User)session2.getAttribute("currentUser");
				String username = user.getUsername();
				if( username.equals("admin") ){
	
			%>	

				<div class="page-content">
						<div class="row">
						<div class="col-sm-4">
							<div class="widget-box ">
												<div class="widget-header">
													<h4 class="widget-title lighter smaller">部门组织树</h4>
												</div>
	
												<div class="widget-body">
													<div class="widget-main ">
														<div id="jstree_demo_div">
			           									</div>
													</div>
												</div>
							</div>
	          			 </div>
	          			 
							<div class="col-sm-8">
							 <div class="widget-box ">
								<div class="widget-header">
										<h4 class="widget-title lighter smaller">部门管理</h4>
								</div>
	
								<div class="widget-body">
										<div class="widget-main ">
											<div class="page-header page-header-revise">
												<form role="form" class="form-inline">
													<div class="form-group">
														<div class="input-group">
															<input type="text"  id="_name"
																placeholder="姓名" class="form-control ">
															<span class="input-group-btn">
																<button class="btn btn-purple btn-sm" id="_search" type="button">
																	<i class="icon-search icon-on-right "></i> 搜索
																</button>
															</span>
														</div>
														  <button class="btn btn-primary btn-sm" type="button" id='_new'>新建</button>
													</div>
												</form>
			                       			 </form>
											</div>

											<div class="table-responsive" >
						                         <table ID='dt_table_view' class="table table-striped table-bordered table-hover ">
							                            <thead>
							                                <tr>
																
																<th>部门名称</th>
																<th>编码</th>
																<th>电话</th>
																<th>负责人</th>
																<th>上级部门</th>
																<th>操作</th>
															</tr>
							                            </thead>
							                       		 <tbody>
							                            </tbody>
						                          </table>
						                          </div>
										</div>
									</div>
												
						</div>
						</div>
				</div>
				
				
				
				   <div id='_form' style="display: none;">
 						 <div class="row">
                            <div class="col-sm-12 ">
		                          <form class="form-horizontal" action="" method="get">
		                           <input name='id' type="hidden"/>
		                           	<table class='table table-bordered'>
		                           		<thead>
		                           		<tr style="text-align: center;" ><td colspan="6" ><h3>部门信息<h3></td></tr>
		                           		</thead>
		                           		<tbody>
		                           			<tr>
		                           				<td>部门名称</td>
		                           				<td> <input name='name' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				
		                           			<tr>
		                           				<td>部门编码</td>
		                           				<td> <input name='code' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>电话</td>
		                           				<td> <input name='tel' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>
		                           				<td>负责人</td>
		                           				<td> <input name='manger'  type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>上级部门</td>
		                           				<td>
												<select name='parent.id' class=" form-control">
												  	<c:forEach var="bean" items="${deptmentselects}">
												  		<option value="${bean.id }">${bean.text }</option>
												  	</c:forEach>
												  </select>
		                           				</td>
		                           			</tr>
		                           			<tr>
		                           				<td>提示</td>
		                           				<td > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>上级部门不填默认为根部门，上级部门不能选自己</li>
									    				</ol>
		                           				</td>
		                           			</tr>
		                           			<tr>
		                           				<td colspan="6"> 
		                           					 <div class="col-sm-4 col-sm-offset-2">
		                                  			  		<button class="btn btn-primary" type="button" onclick="submit_form()">提交</button>
		                               				 </div>
		                           				</td>
		                           			</tr>
		                           		</tbody>
		                           	</table>
		                           	</form>
                            </div>
                        </div>
  			 </div>
   
				<%} %>
				<!-- /.page-content -->
			</div><!-- /.main-content -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->
		
			<script>
	 var table=null;
	    var tree;
	    function submit_form(){
	    	$.ajax({
	    		   type: "POST",
	    		   url:  $.common.getContextPath() + "/sys/deptment/save",
	    		   data: $("form").serialize(),
	    		   success: function(msg){
	    		     if(msg.code==1){
	    		    	 toastr.success('操作成功');
	    		    	 window.location.reload();
	    		     }
	    		     layer.closeAll() ;
	    		   }
	    		});
	     }
	    
	    function fun_delete(id){
	    	layer.confirm('确定删除当前部门？', {
	    		  btn: ['确定','取消'] //按钮
	    		}, function(){
	    			$.ajax({
	    		 		   url:  $.common.getContextPath() + "/sys/deptment/delete?id="+id,
	    		 		   success: function(msg){
	    		 		     if(msg.code==1){
	    		 		    	 toastr.success('操作成功');
	    		 		    	window.location.reload();
	    		 		     }
	    		 		     layer.closeAll() ;
	    		 		   }
	    		 	});
	    		}, function(){
	    			 layer.closeAll() ;
	    		});
	     }
	   
	    function fun_update(id){
	    	$.ajax({
	 		   url:  $.common.getContextPath() + "/sys/deptment/get?id="+id,
	 		   success: function(msg){
	 		     if(msg.code==1){
	 		    	$("input[name='id']").val(msg.datas.id);
	 		    	$("input[name='name']").val(msg.datas.name);
	 		    	$("radio[name='tel']").val(msg.datas.tel);
	 		   		$("input[name='manger']").val(msg.datas.manger);
	 				$("input[name='tel']").val(msg.datas.tel);
	 				$("input[name='code']").val(msg.datas.code);
	 				$("select[name='parent.id']").val(msg.datas.parent.id);
	 		    	layer.open({
	      			  type: 1,
	      			  skin: 'layui-layer-rim', 
	      			  content: $("#_form"),
	      			  area: "800px"
	      			});
	 		     }
	 		   }
	 		});
	     }
	    
	    function init_dept_tree(){
	    	$.ajax({
		 		   url:  $.common.getContextPath() + "/sys/deptment/alldeptments",
		 		   success: function(msg){
		 			  tree = $('#jstree_demo_div').jstree({
		 			 		'core' : {
		 			 			"multiple" : false,
		 			 		  'data' : msg
		 			 		}}).on('changed.jstree', function (e, data) {
		 			 			console.info(data.node.id);
		 			 			$("#deptid").val(data.node.id);
		 			 			 table.draw();
		 			 		  });
		 			   
		 		   }
		 	});
	    }
	   
	    $(document).ready(function(){
	    	init_dept_tree();
	        	$("#_new").click(function(){
	        		$("input[name='id']").val("");
	 		    	$("input[name='name']").val("");
	 		    	$("radio[name='code']").val("");
	 		   		$("input[name='tel']").val("");
	 				$("input[name='manger']").val("");
	 				$("select[name='parent']").val("");
	        		layer.open({
	        			  type: 1,
	        			  skin: 'layui-layer-rim', //加上边框
	        			  content: $("#_form"),
	        			  area: "900px"
	        			});
	        	});
	        	table=$('#dt_table_view').DataTable( {
	        		"dom": "rt<'row'<'col-sm-5'i><'col-sm-7'p>>",
		            "ajax": {
		                "url":  $.common.getContextPath() + "/sys/deptment/listall",
		                "type": "POST",
		                "dataSrc": "datas"
		              },
					"columns" : [{
						"data" : "name"
					}, {
						"data" : "code"
					},{
						"data" : "tel",
					},{
						"data" : "manger",
					},{
						"data" : "parent",
					},{
						"data" : "id",
					}] ,
					 "columnDefs": [
									{
									    "render": function ( data, type, row ) {
									        if(row.parent!=null)
									        	return row.parent.name;
									        else return "";
									        	
									    },
									    "targets":4
									}, 
					                {
					                    "render": function ( data, type, row ) {
					                    	 return "<a tager='_blank' href='javascript:void(0)' onclick='fun_delete("+data+")'>删除 </a>"+
						                        	"<a tager='_blank' href='javascript:void(0)' onclick='fun_update("+data+")'>编辑 </a>";
					                    },
					                    "targets":5
					                }
					               
					            ],
	        		"initComplete": function () {
	        			var api = this.api();
	        			$("#_search").on("click", function(){
	            		 	api.draw();
	        			} );
	        		} 
	        	 } ).on('preXhr.dt', function ( e, settings, data ) {
			        	data.name = $("#_name").val();
			        	data.deptid = $("#deptid").val();
			        	return true;
			     } ).on('xhr.dt', function ( e, settings, json, xhr ) {
			    		 $(".dataTables_processing").hide();	
			     } )
	        });
	    
	    $(document).ready(function(){
	    	$(".nav-list li").removeClass("active");
	    	$(".submenu a[href='${pageContext.request.contextPath}/sys/deptment/index']").parent().addClass("active");
	    });
	    
    </script>
    <script src="${pageContext.request.contextPath}/js/plugins/jsTree/jstree.min.js"></script>
	</body>

</html>
