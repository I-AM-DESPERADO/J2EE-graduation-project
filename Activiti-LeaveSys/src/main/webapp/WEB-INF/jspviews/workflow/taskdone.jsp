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
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" targeturl='${pageContext.request.contextPath}/workflow/taskdone'>已办任务</li>
						</ul>
					</div>

				<div class="page-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="page-header page-header-revise">
									<form role="form" class="form-inline">
										<div class="form-group">
											<div class="input-group">
												<input type="text"  id="_name"
													placeholder="事项名称" class="form-control ">
												<span class="input-group-btn">
													<button class="btn btn-purple btn-sm" id="_search" type="button">
														<i class="icon-search icon-on-right "></i> 搜索
													</button>
												</span>
											</div>
										</div>
									</form>
                        </form>
									
								</div>

								<div class="table-responsive ">
									<table ID='dt_table_view'
										class="table  table-bordered table-hover">
										<thead>
											<tr>
												<th>事项名称</th>
												<th>收到日期</th>
												<th>提交人</th>
												<th>当前步骤</th>
												<th>状态</th>
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
				<!-- /.page-content -->
			</div><!-- /.main-content -->

	<script>
    $.common.setContextPath('${pageContext.request.contextPath}');
    var table=null;
    $(document).ready(function(){
    	 	$("#_new").click(function(){
        		$("input[name='id']").val("");
 		    	$("input[name='chinesename']").val("");
 		    	$("radio[name='sex']").val("");
 		   		$("input[name='username']").val("");
 				$("input[name='tel']").val("");
 				$("input[name='email']").val("");
 				$("textarea[name='remark']").val("");
        		layer.open({
        			  type: 1,
        			  skin: 'layui-layer-rim', //加上边框
        			  content: $("#_form"),
        			  area: "800px"
        			});
        	});
        	table=$('#dt_table_view').DataTable( {
        		"dom": "rt<'row'<'col-sm-5'i><'col-sm-7'p>>",
	            "ajax": {
	                "url":  $.common.getContextPath() + "/workflow/taskdonelist",
	                "type": "POST",
	                "dataSrc": "datas"
	              },
				"columns" : [{
					"data" : "title"
				}, {
					"data" : "createDate"
				},{
					"data" : "creater.chinesename",
				},{
					"data" : "stepName",
				},{
					"data" : "state",
				},{
					"data" : "id",
				}] ,
				 "columnDefs": [
				                {
				                    "render": function ( data, type, row ) {
				                        return  "<a tager='_blank'  href='${pageContext.request.contextPath}/workflow/taskhistory/"+row.processInstanceId+"' >详情</a>";
				                    },
				                    "targets":5
				                },
				                {
				                    "render": function ( data, type, row ) {
				                        return  "<span class='label label-primary'>"+data+"</span>";
				                    },
				                    "targets":3
				                },
				                {
				                    "render": function ( data, type, row ) {
				                    	if(data=='进行中')
				                       	 return  "<span class='label label-danger '>"+data+"</span>";
				                        else
				                        	return  "<span class='label label-primary'>"+data+"</span>";
				                    },
				                    "targets":4
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
		        	return true;
		     } ).on('xhr.dt', function ( e, settings, json, xhr ) {
		    		 $(".dataTables_processing").hide();	
		     } )
        });
    
    $(document).ready(function(){
    	$(".nav-list li").removeClass("active");
    	$(".nav-list a[href='"+$(".breadcrumb li[targeturl]").attr("targeturl")+"']").parent().addClass("active");
    });
    </script>
	</body>
</html>
