<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@page import="com.pzy.jcook.sys.entity.User"%>
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
      
      <style type="text/css">
			#hidden{
			display:none;
			}
		</style>
      	  <script src="${pageContext.request.contextPath}/js/plugins/layer/layer.js"></script>
         <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
         
         <script type="text/javascript">
	    function validatemobile() 
	       { 
	    		var tel=document.getElementById("tel").value;
	           if(tel.length==0) 
	           { 
	              //alert('请输入手机号码！'); 
	              //alert(hidden);
	              hidden.innerHTML="请输入手机号码！";
	              hidden.style.display="block";
               return false;
	              
	           }     
	           if(tel.length!=11) 
	           { 
	               alert('请输入有效的手机号码！'); 
	               var hidden = document.getElementById("hidden");
	               //alert(hidden);
		              hidden.innerHTML="请输入有效手机号码！";
		              hidden.style.display="block";
	               return false; 
	           } 
	            
	           var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
	           if(!myreg.test(tel)) 
	           { 
	               //alert('请输入有效的手机号码！');
	               var hidden = document.getElementById("hidden");
	               //alert(hidden);
		              hidden.innerHTML="请输入有效手机号码！";
		              hidden.style.display="block";
	               return false; 
	           }  
	       } 
	    
	    
	    function checkMail(){
	    	var email = document.getElementById("email");
	        var filter  =/^[A-Za-zd]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/; 
	        if (!filter.test(email)) {
	        	
	        	var hidden = document.getElementById("hidden");
	            //alert(hidden);
		              hidden.innerHTML="请输入有效电子邮箱！";
		              hidden.style.display="block";
	             
		        return false;
	            
	        }
	        
	    }
		
		</script>
	</head>
	<%
				Subject currentUser = SecurityUtils.getSubject();
				Session session2 = currentUser.getSession();
				User user =(User)session2.getAttribute("currentUser");
				String username = user.getUsername();
				if( username.equals("admin") ){
	
			%>	
	
			<div class="main-content">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/sys/user/center">首页</a>
							</li>
							<li class="active" targeturl='${pageContext.request.contextPath}/user/index'>员工管理</li>
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
											<th>id</th>
											<th>手机号码</th>
											<th>真实姓名</th>
											<th>性别</th>
											<th>备用电话</th>
											<th>电子邮件</th>
											<th>责任区域</th>
											<th>所属部门</th>
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
		                           		<tr style="text-align: center;" ><td colspan="6" ><h3>员工信息<h3></h3></td></tr>
		                           		</thead>
		                           		<tbody>
		                           		<tr>
		                           		<td><p id="hidden" style="color: red;">  </p></td>
		                           		</tr>
		                           		
		                           			<tr>
		                           				<td>姓名</td>
		                           				<td> <input name='chinesename' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           			<td>性别</td>
		                           				<td>
												  <label class='checkbox-inline'>
												    <input type="radio" name="sex"  value="男" checked>
												    	男
												   </label>
												   <label class='checkbox-inline'>
												    <input type="radio" name="sex"  value="女">
												 	   女
												  </label>
		                           				</td>
		                           			</tr>
		                           			
		                           				
		                           			<tr>
		                           			   
		                           				<td>手机号码</td>
		                           				<td> <input id='tel' name='username' type="text" class="form-control"></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>备用号码</td>
		                           				<td> <input  name='tel' type="text" class="form-control" onclick="return validatemobile();return true"  ></td>
		                           			</tr>
		                           			
		                           			
		                           			<tr>
		                           				<td>email</td>
		                           				<td> <input id='email' name='email'  type="text" class="form-control" onclick="return validatemobile();return true"></td>
		                           			</tr>
		                           			
											<tr>
												<td>责任范围</td>
		                           				<td> <textarea name='remark' rows="4" cols="" style="width: 80%"></textarea></td>
		                           			</tr>
		                           			
		                           			<tr>
		                           				<td>所属部门</td>
		                           				<td>
												<select name='deptment.id' class=" form-control">
												  	<c:forEach var="bean" items="${deptmentselects}">
												  		<option value="${bean.id }">${bean.text }</option>
												  	</c:forEach>
												  </select>
		                           				</td>
		                           			</tr>
		                           			<tr>
		                           				<td>角色</td>
		                           				<td > 
		                           				<c:forEach items="${roles }" var="bean">
		                           				  <label class='checkbox-inline'>
														<input type="checkbox" name="role" value="${bean.id }"> ${bean.name }
												</label>
		                           				</c:forEach>
												</td>
		                           			</tr>
		                           			
		                           		
		                           			<tr>
		                           				<td>提示</td>
		                           				<td > 
		                           					 <h4>提示</h4>
		                               					 <ol>
									    					<li>初始密码为123456，登记完成可以修改</li>
									    				</ol>
		                           				</td>
		                           			</tr>
		                           			<tr>
		                           				<td colspan="6"> 
		                           					 <div class="col-sm-4 col-sm-offset-2">
		                                  			  		<button class="btn btn-primary" type="button" onclick="submit_form()" >提交</button>
		                               				 </div>
		                           				</td>
		                           			</tr>
		                           		</tbody>
		                           	</table>
		                           	</form>
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
    		   url:  $.common.getContextPath() + "/sys/user/save",
    		   data: $("form").serialize(),
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
    	
    	layer.confirm('确定删除当前员工？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			$.ajax({
    		 		   url:  $.common.getContextPath() + "/sys/user/delete?id="+id,
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
 		   url:  $.common.getContextPath() + "/sys/user/get?id="+id,
 		   success: function(msg){
 		     if(msg.code==1){
 		    	$("input[name='id']").val(msg.datas.id);
 		    	$("input[name='chinesename']").val(msg.datas.chinesename);
 		    	$("radio[name='sex']").val(msg.datas.sex);
 		   		$("input[name='username']").val(msg.datas.username);
 				$("input[name='tel']").val(msg.datas.tel);
 				$("input[name='email']").val(msg.datas.email);
 				$("textarea[name='remark']").val(msg.datas.remark);
 				$("input:checkbox[name='role']").prop('checked',false); 
 				for(var i=0;i<msg.datas.roles.length;i++){
 					$("input:checkbox[value='"+msg.datas.roles[i].id+"']").prop('checked',true); 
 				}
 				
 		    	layer.open({
      			  type: 1,
      			  skin: 'layui-layer-rim', 
      			  content: $("#_form"),
      			  area: "650px"
      			});
 		     }
 		   }
 		});
     }
    
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
	                "url":  $.common.getContextPath() + "/sys/user/list",
	                "type": "POST",
	                "dataSrc": "datas"
	              },
				"columns" : [{
					"data" : "id"
				}, {
					"data" : "username"
				},{
					"data" : "chinesename",
				},{
					"data" : "sex",
				},{
					"data" : "tel",
				},{
					"data" : "email",
				},{
					"data" : "remark",
				},{
					"data" : "deptment.name",
				},{
					"data" : "id",
				}] ,
				 "columnDefs": [
				                { "render": function ( data, type, row ) {
				                        	return  "<span class='label label-primary'>"+data+"</span>";
				                        	},
				                    "targets":7
				                },
				                {
				                    "render": function ( data, type, row ) {
				                        return "<a tager='_blank' href='javascript:void(0)' onclick='fun_delete("+data+")'>删除 </a>"+
				                        "<a tager='_blank' href='javascript:void(0)' onclick='fun_update("+data+")'>编辑 </a>";
				                    },
				                    "targets":8
				                }
				               
				            ],
        		"initComplete": function () {
        			var api = this.api();
        			$("#_search").on("click", function(){
        				alert();
        				
            		 	api.draw();
        			} );
        		} 
        	 } ).on('preXhr.dt', function ( e, settings, data ) {
		        	data.value = $("#_name").val();
		        	data.columnname = 'chinesename';
		        	return true;
		     } ).on('xhr.dt', function ( e, settings, json, xhr ) {
		    		 $(".dataTables_processing").hide();	
		     } )
        });
    $(document).ready(function(){
    	$(".nav-list li").removeClass("active");
    	$(".submenu a[href='${pageContext.request.contextPath}/sys/user/index']").parent().addClass("active");
    });
    </script>
    	</body>
</html>
