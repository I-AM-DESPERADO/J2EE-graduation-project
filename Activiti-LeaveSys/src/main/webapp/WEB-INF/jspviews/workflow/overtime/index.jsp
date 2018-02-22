<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="en">
	<head>
		<title></title>
		<style type="text/css">
		   .error{
       color: red;
      }
      </style>
      	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
         <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
              <script src="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	      <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet">
	
	</head>
			<div class="main-content">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" targeturl='${pageContext.request.contextPath}/workflow/overtime/index'>加班单查询</li>
						</ul>
					</div>

				<div class="page-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="page-header page-header-revise">
									<form role="form" class="form-inline">
										<div class="form-group">
											部门
												<select name='deptment.id'  id='deptment1' class=" form-control">
												  	<c:forEach var="bean" items="${deptmentselects}">
												  		<option value="${bean.id }">${bean.text }</option>
												  	</c:forEach>
												  </select>
												  
												员工  
												<input type="text"  id="_name" 	placeholder="姓名" class="form-control ">
												加班日期起
												<input type="text"  id="datefrom" 	placeholder="加班日期起" class="form-control form_datetime ">
												加班日期止
												<input type="text" id="dateend" 	placeholder="加班日期止" class="form-control form_datetime" >
												
												<button class="btn btn-purple btn-sm" id="_search" type="button">
														<i class="icon-search icon-on-right "></i> 搜索
													</button>
												</span>
													
										</div>
									</form>
                       			 </form>
									
								</div>

							<div class="table-responsive" >
		                         <table ID='dt_table_view' class="table table-striped table-bordered table-hover ">
		                            <thead>
		                                <tr>
											<th>加班人</th>
											<th>所属部门</th>
											<th>加班日期起</th>
											<th>加班日期止</th>
											<th>加班时间</th>
											<th>联系电话</th>
											<th>操作</th>
										</tr>
		                            </thead>
		                       		 <tbody>
		                            </tbody>
		                          </table>
		                          </div>
						</div>
				</div>
				
				
				
 		 				<div class="row" id='_form' style="display: none;">
                            <div class="col-sm-12  ">
		                           <form  id='form_' class="form-horizontal" action="" method="get">
		                           <input name='id' type="hidden"/>
		                           	 	<table class='table table-bordered'>
		                           		<thead>
		                           		<tr  ><th style="text-align: center;" colspan="4" >加班单</th></tr>
		                           		</thead>
		                           		<tbody>
		                           		
		                           		  
		                           		  <tr>
		                           				<td>部门：</td>
		                           				<td>
		                           				<select name='deptment.id' class=" form-control">
												  	<c:forEach var="bean" items="${deptmentselects}">
												  		<option value="${bean.id }">${bean.text }</option>
												  	</c:forEach>
												  </select>
		                           				
		                           				</td>
		                           				<td>姓名：</td>
		                           				<td><input required="required" name='chinesename' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			 
		                           		  <tr>
		                           				<td>工号：</td>
		                           				<td><input required="required" name='username' type="text" class="form-control"></td>
		                           				<td>电话：</td>
		                           				<td><input required="required" name='tel' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>加班时间起：</td>
		                           				<td><input   name='datefrom' type="text" class="form-control input-group form_datetime" ></td>
		                           				<td>加班时间止：</td>
		                           				<td><input   name='dateend' type="text" class="form-control input-group form_datetime" ></td>
		                           			</tr>
		                           			<tr>
		                           				<td>共计小时：</td>
		                           				<td colspan="3" ><input   name='hours' type="text" class="form-control " ></td>
		                           			
		                           			
		                           			
		                           			</tr>
		                           			<tr>	
		                           				<td>加班原因</td>
												<td colspan="3"> <textarea required="required" name='remark' rows="2" cols="" style="width: 100%" ></textarea></td>
		                           			</tr>
		                           			
		                           			
		                           			
		                           			<tr>
		                           				<td>提示</td>
		                           				<td colspan="3" > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>必须在加班前申请</li>
									    					<li>必须审核通过才能休假</li>
									    				</ol>
		                           				</td>
		                           			</tr>
		                           			<tr>
		                           				<td colspan="6"> 
		                           					 <div class="col-sm-4 col-sm-offset-2">
		                                  			  		<button class="btn btn-primary" type="button" onclick="submit_form()">提交修改</button>
		                               				 </div>
		                           				</td>
		                           			</tr>
		                           		</tbody>
		                           	</table> 
		                           	</form>
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
    
    var table=null;
    var form_=$("#form_").validate({
	    rules: {
	    	chinesename: "required",
	    	username: "required"
	    },
	    ignore:"",
	    messages: {
	    	chinesename: "姓名必须填写",
	    	username: "手机号码必须填写"
	    }
	});
    function submit_form(){
    	if(!form_.form()) return ;
    	$.ajax({
    		   type: "POST",
    		   url:  $.common.getContextPath() + "/workflow/overtime/save",
    		   data: $("#form_").serialize(),
    		   success: function(msg){
    		     if(msg.code==1){
    		    	 toastr.success('操作成功');
    		    	 table.draw();
    		     }
    		     layer.closeAll() ;
    		   }
    		});
     }
    
    function fun_delete(id){
    	
    	layer.confirm('确定删除当前加班单？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			$.ajax({
    		 		   url:  $.common.getContextPath() + "/workflow/overtime/delete?id="+id,
    		 		   success: function(msg){
    		 		     if(msg.code==1){
    		 		    	 toastr.success('操作成功');
    		 		    	 table.draw();
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
 		   url:  $.common.getContextPath() + "/workflow/overtime/get?id="+id,
 		   success: function(msg){
 		     if(msg.code==1){
 		    	$("input[name='id']").val(msg.datas.id);
 		    	$("input[name='chinesename']").val(msg.datas.chinesename);
 		   		$("input[name='username']").val(msg.datas.username);
 				$("input[name='tel']").val(msg.datas.tel);
 				$("input[name='datefrom']").val(msg.datas.datefrom);
 				$("input[name='dateend']").val(msg.datas.dateend);
 				$("input[name='hours']").val(msg.datas.hours);
 				
 				$("textarea[name='remark']").val(msg.datas.remark);
 				$("input:radio[name='type']").prop('checked',false); 
 				$("input:radio[name='type'][value='"+msg.datas.type+"']").prop('checked',true); 
 		    	layer.open({
      			  type: 1,
      			  skin: 'layui-layer-rim', 
      			  content: $("#_form"),
      			  area: "850px"
      			});
 		     }
 		   }
 		});
     }
    
    $(document).ready(function(){
    	
        	table=$('#dt_table_view').DataTable( {
        		"dom": "rt<'row'<'col-sm-5'i><'col-sm-7'p>>",
	            "ajax": {
	                "url":  $.common.getContextPath() + "/workflow/overtime/listall",
	                "type": "POST",
	                "dataSrc": "datas"
	              },
				"columns" : [{
					"data" : "username"
				}, {
					"data" : "deptment.name"
				},{
					"data" : "datefrom",
				},{
					"data" : "dateend",
				},{
					"data" : "hours",
				},{
					"data" : "tel",
				},{
					"data" : "id",
				}] ,
				 "columnDefs": [
				                {
				                    "render": function ( data, type, row ) {
				                        return "<a tager='_blank' href='javascript:void(0)' onclick='fun_delete("+data+")'>删除 </a>"+
				                        "<a tager='_blank' href='javascript:void(0)' onclick='fun_update("+data+")'>编辑 </a>";
				                    },
				                    "targets":6
				                }
				               
				            ],
        		"initComplete": function () {
        			var api = this.api();
        			$("#_search").on("click", function(){
            		 	api.draw();
        			} );
        		} 
        	 } ).on('preXhr.dt', function ( e, settings, data ) {
		        	data.deptment = $("#deptment1").val();
		        	data.username = $("#_name").val();
		        	data.datefrom = $("#datefrom").val();
		        	data.dateend= $("#dateend").val();
		        	return true;
		     } ).on('xhr.dt', function ( e, settings, json, xhr ) {
		    		 $(".dataTables_processing").hide();	
		     } )
        });
    $(document).ready(function(){
    	 $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
    	$(".nav-list li").removeClass("active");
    	$(".submenu a[href='${pageContext.request.contextPath}/workflow/overtime/index']").parent().addClass("active");
    });
    </script>
    	</body>
</html>
