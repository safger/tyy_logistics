<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>管控系统 | 权限系统</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="<%=basePath%>js/jsTree/themes/default/style.min.css" />

<style type="text/css">
.panel {
	display: inline-block;
	width: 30%;
	vertical-align: top;
}

.panel.pa {
	display: inline-block;
	width: 65%;
	margin-left: 2%;
}
.panel-title{
    display: inline-block; 
}
.ibox-tools {
    display: inline-block;
    float: right;
    margin-top: 0; 
    position: relative;
    padding: 0;
}
.ibox-tools a{
    cursor: pointer;
    margin-left: 5px;
} 

.btn-primary {
    background-color: #1ab394;
    border-color: #1ab394;
    color: #FFFFFF;
}
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<jsp:include page="head.jsp" />
		<c:import url="/system/menuData.html"></c:import>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					系统管理<small>组织管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">组织管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class=col-xs-12> 
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">组织管理</h3>
							</div>
							<div class="box-body">
								<div class="row-fluid">
									<div class="panel panel-info">
										<div class="panel-heading">
											<h3 class="panel-title">组织列表</h3>
										</div>
										<div class="panel-body">
											<div id="jstree"></div> 
										</div>
									</div>  
									<div class="panel panel-info pa"> 
										<div class="panel-heading">    
											<h3 class="panel-title" style="display: inline-block;">组织信息</h3> 
											<div class="ibox-tools rboor"> 
						                        <a href="javascript:addChild()" class="btn btn-primary btn-xs p310" ><i class="fa fa-plus"></i> 新增子集</a> 
						                    </div> 
										</div> 
										<div class="panel-body">
											<form role="form" id="myform">
												<div class="box-body">
													<div class="form-group">
														<label >名称</label> <input type="text" name="fullname" class="form-control"  required="required"  placeholder="请输入名称">
														<input  type="hidden" value=""  name="fuid" />
														<input  type="hidden" value=""  name="parentid" />
													</div>
													<div class="form-group">
														<label >排序</label> <input type="number" name="sortcode" class="form-control"   placeholder="请输入排序">
													</div>
													<div class="form-group">
														<label >联系人</label> <input type="text" name="contact" class="form-control"   placeholder="请输入联系人">
													</div> 
													<div class="form-group">
														<label >联系电话</label> <input type="text" name="outerphone" class="form-control"   placeholder="请输入联系电话">
													</div>
													<div class="form-group">
									                  <label>备注</label> 
									                  <textarea class="form-control" rows="3" name="description" placeholder="请输入备注"></textarea>
									                </div>
												</div>
												<!-- /.box-body -->
												<div class="box-footer" >  
													<button id="ed" type="button" onclick="edit()" class="btn btn-primary">提交</button>
													<button type="button" onclick="del()" class="btn btn-danger">删除</button>
												</div> 
											</form>
											</div>
										</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="foot.jsp" />
	</div>

	<!-- ./wrapper -->

	<script src="<%=basePath%>js/jsTree/jstree.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#jstree").jstree({
				'core' : {
					 "themes" : { "stripes" : true },
					"data":{    
			            "url":"<%=basePath%>system/organize/tree.html?date="+new Date(),
						"dataType" : "json",
						"cache" : false
					}
				},   
				 "plugins" : [  "dnd",  "state", "types", "wholerow"] 
			});
			$('#jstree').on("changed.jstree", function(e, data) {
				var id =data.node.id;  
				var ch=data.node.children;
				if(ch.length>0){
					$(".btn-danger").remove(); 
				}else{ 
					var de=$(".btn-danger");
					if(de.length==0){  
						$("#ed").after('<button type="button" style="margin-left: 4px" onclick="del()" class="btn btn-danger">删除</button>');
					} 
				} 
				 $.ajax({
					    url: "<%=basePath %>system/organize/update_show.html?id="+id+"&time="+new Date(),
							async : false,
							contentType : "application/x-www-form-urlencoded;charset=UTF-8",
							dataType : "json",
							success : function(data) {
								 $("input[name='fullname']").val(data.fullname);
								 $("input[name='fuid']").val(data.fuid);
								 $("input[name='parentid']").val(data.fuid);
								 $("input[name='sortcode']").val(data.sortcode);
								 $("input[name='contact']").val(data.contact); 
								 $("input[name='outerphone']").val(data.outerphone); 
								 $("textarea[name='description']").val(data.description);
							}
						});

			});
		}); 
		
		function edit(){
			var id=$("input[name='parentid']").val();
			if(id==null||id.length==0){
				alert("请先选择组织!");
				return;
			}
			$("#myform").ajaxSubmit({
			       type: 'post',  
			        async: false,
			       url: "<%=basePath%>system/organize/edit.html?date="+new Date(),
			        dataType:"json",  
					success : function(data) {   
						//$('#jstree').jstree(true).refresh();  */
						 location.reload(); 
					},
					error : function(XmlHttpRequest, textStatus, errorThrown) {
						alert("error");
					}
				});   
		}
		function del(){
			var choice=confirm("您确认要删除吗？", function() { }, null);
			if(choice){
				var id=$("input[name='fuid']").val();
				if(id==null||id.length==0){
					alert("请先选择组织!");
					return;
				}
				$.ajax({
					url:"<%=basePath %>system/organize/delete.html?id="+id+"&time="+new Date(),
					async: false,
					  success: function(data){
					  	if(data==1){ 
					  		 location.reload(); 
					  	}else{
					  		alert("服务器异常，请稍后再试！");
					  	}
		              }
				});
			}
		}
		function addChild(){
			var id=$("input[name='parentid']").val();
			if(id==null||id.length==0){
				alert("请先选择组织!");
				return; 
			}
			$("#myform").find("input").each(function (){
				if($(this).attr("name")!='parentid'){
					$(this).val("");
				} 
			})
			$("textare").val("");  
			$(".box-footer").html('<button  type="button" onclick="edit()" class="btn btn-primary">保存子集</button>');
			
		}
	</script>
</body>
</html>
