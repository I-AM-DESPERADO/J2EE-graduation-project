<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="en">
	<head>
	
	 
	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
	 <link href="${pageContext.request.contextPath}/css/plugins/jsTree/style.min.css" rel="stylesheet">
	    <script src="${pageContext.request.contextPath}/js/plugins/toastr/toastr.min.js"></script>
	      <link href="${pageContext.request.contextPath}/css/plugins/toastr/toastr.min.css" rel="stylesheet">
	       <script src="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	      <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css" rel="stylesheet">
		<title></title>
      </style>
	</head>
	<body>
	
			<div class="main-content">
			 <script type="text/javascript">
				function delta_t()
				{ 
					
					var starttime= new Date(document.getElementById("starttime").value);
					
					var endtime=new Date(document.getElementById("endtime").value);
					var times = endtime.getTime()-starttime.getTime();
					if(times<=0)
					{
						alert("输入时间有误，请重新输入")
						return false;
					}
					
					else
					{
						
						var def = (times/1000)/3600;
						document.getElementById("hours").value=def;	
				}
			}
				
				
		
		</script>
			
			
			
			  <input id='deptid' type="hidden"/>
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" targeturl='${pageContext.request.contextPath}/workflow/dayoff/create'>请假单申请</li>
						</ul>
					</div>

				<div class="page-content">
						<div class="row">
                            <div class="col-sm-12 table-responsive">
		                           <form class="form-horizontal" action="${pageContext.request.contextPath}/workflow/dayoff/create" method="post">
		                           	<table class='table table-bordered'>
		                           		<thead>
		                           		<tr  ><th style="text-align: center;" colspan="4" >请假单</th></tr>
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
		                           				<td><input required="required" name='chinesename' type="text" value="${sessionScope.currentUser.chinesename}" class="form-control" ></td>
		                           			</tr>
		                           			
		                           			 
		                           		  <tr>
		                           				<td>工号：</td>
		                           				<td><input required="required" name='username' type="text" value="${sessionScope.currentUser.username}" class="form-control" ></td>
		                           				<td>电话：</td>
		                           				<td><input required="required" name='tel' type="text" value="${sessionScope.currentUser.tel}" class="form-control" ></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>请假时间起：</td>
		                           				<td>
		                           				<input id='starttime' name='datefrom' type="text" class="form-control input-group form_datetime" ></td>
		                           				<td>请假时间止：</td>
		                           				<td>
		                           				<input id='endtime' name='dateend' type="text" class="form-control input-group form_datetime" ></td>
		                           			</tr>
		                           			<tr>
		                           				<td>共计小时：</td>
		                           				<td ><input id='hours' name='hours' type="text" class="form-control input-group date" onclick="delta_t()" ></td>
		                           			
		                           			
		                           				<td>请假类型</td>
		                           				<td> 
													<label class="radio-inline">
													  <input type="radio" name="type" id="inlineRadio1" value="病假"> 病假
													</label>
													<label class="radio-inline">
													  <input type="radio" name="type" id="inlineRadio2" value="调休假"> 调休假
													</label>
													<label class="radio-inline">
													  <input type="radio"  name="type" id="inlineRadio3" value="工伤假">工伤假
													</label>
													
													<label class="radio-inline">
													  <input type="radio" name="type" id="inlineRadio3" value="事假">事假
													</label>
													
													<label class="radio-inline">
													  <input type="radio"  name="type" id="inlineRadio3" value="丧假">丧假
													</label>
													
		                           				</td>
		                           			</tr>
		                           			<tr>	
		                           				<td>请假原因</td>
												<td colspan="3"> <textarea required="required" name='remark' rows="2" cols="" style="width: 100%" ></textarea></td>
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
		                           			<tr>
		                           				<td colspan="6"> 
		                           					 <div class="col-sm-4 col-sm-offset-2">
		                                  			  		<button class="btn btn-primary" type="submit">提交假单</button>
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
			
			<c:if test="${response.code=='1'}">
			  toastr.success('${response.msg}');
			</c:if>
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
	    	 $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
	    	$(".nav-list li").removeClass("active");
	    	$(".submenu a[href='${pageContext.request.contextPath}/workflow/dayoff/create']").parent().addClass("active");
	    });
    </script>
	</body>

</html>
