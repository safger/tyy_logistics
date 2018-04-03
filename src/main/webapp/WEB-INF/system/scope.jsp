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
 <link rel="stylesheet" href="<%=basePath%>js/jquery-treegrid-master/css/jquery.treegrid.css"> 
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
					系统管理<small>数据集权限管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">数据集权限管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">  
					<div class=col-xs-12>
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">数据集权限管理</h3>
							</div>
							<div class="box-body">
								<div class="row-fluid">
									<div class="panel panel-info">
										<div class="panel-heading">
											<h3 class="panel-title">组织列表</h3>
										</div>
										<div class="panel-body">
											<div id="jstree_demo_div"></div>
										</div>
									</div>  
									<div class="panel panel-info pa"> 
										<div class="panel-heading"> 
											<h3 class="panel-title">角色菜单权限信息</h3>
										</div>
										<div class="panel-body">
										   <table class="table tree"> 
												<tr>
													<th>角色名称</th>
													<th>菜单名称</th>
													<th>路径</th>
													<th>操作</th>
												</tr>
												<c:forEach items="${baseRole_list }" var="list" varStatus="stuts">
													<tr class="treegrid-${list.fuid }">
														<td>${list.realname }</td>
														<td> </td>
														<td></td>
														<td> 
														</td> 
													</tr>
													<c:if test="${list.children != null}">
														<c:forEach items="${list.children }" var="clist" varStatus="stuts">
															<tr class="treegrid-${clist.fuid } treegrid-parent-${list.fuid }">
																<td> </td>
																<td>${clist.menuName }</td>
																<td>${clist.menuUrl }</td>
																<td> </td>
																<td>
																	<div class="btn-group"> 
																		<button type="button" class="btn btn-primary btn-sm"  onclick="showOr('${list.fuid }','${clist.modifyuserrealname }')">
																			分配权限
																		</button>
																		 
																	</div>
																</td>
															</tr>
														</c:forEach>
													</c:if>
												</c:forEach>
											</table>
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
	<div class="modal fade" id="treeModal" tabindex="-1" role="dialog" aaria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close"  onclick="closeTree()">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配权限</h4>
				</div>
				<form id="editForm">
					<div class="modal-body">
						<div class="box-body">
							 <div id="com_jstree"></div>
						</div>
					</div>
				</form>
				<div class="modal-footer"> 
					<button type="button" class="btn btn-default" onclick="closeTree()" >关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveCom()" >保存</button>
				</div>
			</div>
		</div>
	</div>
	<form action="<%=basePath %>system/scope/show.html" id="tform" method="post" >
		<input name="OrganizeId" value="${OrganizeId }" />
	</form>
	<form id="myform" action="" method="post">  
		<input type="hidden" id="MenuId" name="MenuId" value="" /> 
		<input type="hidden" id="RoleId" name="RoleId" value="" /> 
			<div id='hid'></div>
	</form>  
		<script src="<%=basePath%>js/jsTree/jstree.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery-treegrid-master/js/jquery.treegrid.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery-treegrid-master/js/jquery.treegrid.bootstrap3.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
		<!-- js分页模板 -->
		 
	<script type="text/javascript"> 
		$(function() {
			 
			 $('.tree').treegrid(); 
			$("#jstree_demo_div").jstree({
				'core' : {
					"multiple" : false,
					 "themes" : { "stripes" : true },
					"data":{ 
			            "url":"<%=basePath %>system/organize/tree.html?OrganizeId=${OrganizeId}", 
						"dataType" : "json",
						"cache" : false
					}  
				}, 
				"types" : {
				    "#" : {  
				      "valid_children" : ["root"]
				    }, 
				    "root" : { 
				      "icon" : "/images/user.png",
				      "valid_children" : ["default"]
				    },
				    "default" : {
				      "valid_children" : ["default","file"]
				    },
				    "file" : {
				      "icon" : "glyphicon glyphicon-file",
				      "valid_children" : []
				    }
				  }, 
				"plugins" : [  "dnd",  "state", "types", "wholerow","types" ]
			});
			$('#jstree_demo_div').on("changed.jstree", function(e, data) {
				var OrganizeId=data.node.id;
				
				$("input[name='OrganizeId']").val(OrganizeId);
				showScope(OrganizeId);
			});    
			  
		});
		    
		
		function showScope(OrganizeId){
			$("input[name='OrganizeId']").val(OrganizeId);
			$("#tform").submit();
		}
		
		function showOr(roleid,menuid){
			$("#treeModal").modal("show"); 
	    	$("#com_jstree").jstree({ 
				'core' : { 
					 "themes" : { "stripes" : true },
					 "multiple" : true,
					"data":{ 
			            "url":"<%=basePath%>system/organize/ScopeTree.html?RoleId="+roleid+"&MenuId="+menuid,
						"dataType" : "json",
						"cache" : false
					}  
				}, 
				 "checkbox" : {
				      "keep_selected_style" : false
				    }, 
				"types" : {
				    "#" : {  
				      "valid_children" : ["root"]
				    }, 
				    "root" : { 
				      "icon" : "/images/user.png",
				      "valid_children" : ["default"]
				    },
				    "default" : {
				      "valid_children" : ["default","file"]
				    },
				    "file" : {
				      "icon" : "glyphicon glyphicon-file",
				      "valid_children" : []
				    }  
				  },    
				"plugins" : [  "types","checkbox" ] 
			});
	    	$("#MenuId").val(menuid);
	    	$("#RoleId").val(roleid); 
	 } 
		 	
		 function closeTree(){
		    	$("#treeModal").modal("hide");
		    	$("#com_jstree").jstree().destroy();
		    	 
		    }
		 
		 function saveCom(){
			 var nodes=$("#com_jstree").jstree().get_checked(true);
				var s = '';
				$("#hid").empty();
				for(var i=0; i<nodes.length; i++){
					s+=nodes[i].id+",";
				}
				s=s.length>0?s.substring(0,s.length-1):s;
				$("#hid").append("<input type='hidden' name='id' value='"+s+"' />");
	 	 		$("#myform").ajaxSubmit({
	                    type: 'post',
	                    url: "<%=basePath%>system/scope/ScopeQx.html",

				success : function(data) {
					closeTree();  
				},
				error : function(XmlHttpRequest, textStatus, errorThrown) {
					alert("error");
				}
			});
		}
	</script>
</body>
</html>
