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
 <link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.css">
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
					系统管理<small>部门权限管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">部门权限管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">  
					<div class=col-xs-12>
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">部门权限管理</h3>
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
											<h3 class="panel-title">组织菜单信息</h3>
										</div>
										<div class="panel-body">
										   <div id="jstree_menu_div"></div> 
										</div> 
										<div class="panel-footer" style="display: none;">  
											<button type="button" onclick="add()" class="btn btn-primary btn-sm">保存</button>
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
	<form id="myform" action="" method="post"> 
		 <input type="hidden" name="OrganizeId" value="">
			<div id='hid'></div>
		</form>  
		<script src="<%=basePath%>js/jsTree/jstree.min.js"></script>
			<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
		<!-- js分页模板 -->
		 
	<script type="text/javascript"> 
		$(function() {
			$("#jstree_demo_div").jstree({
				'core' : {
					"multiple" : false,
					 "themes" : { "stripes" : true },
					"data":{ 
			            "url":"<%=basePath %>system/organize/tree.html", 
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
				showMenu(OrganizeId);    
				$(".panel-footer").css("display","block");
			});  
			 
		});
		
		
		var tt=null; 
		function showMenu(OrganizeId){ 
			if(tt!=null){
				$("#jstree_menu_div").jstree().destroy();
			} 
			tt=$("#jstree_menu_div").jstree({
				'core' : {
					"multiple" : true, 
					 "themes" : { "stripes" : true },
					"data":{ 
			            "url":"<%=basePath %>system/menu/treeOrg.html?OrganizeId="+OrganizeId,
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
			$("#jstree_menu_div").bind("loaded.jstree", function (e, data) {
	             data.inst.open_all(0); // -1 opens all nodes in the container
			 }) 
			
		}

		  
		function add(){
			var OrganizeId=$("input[name='OrganizeId']").val();
			var nodes =$("#jstree_menu_div").jstree().get_checked(true);
			var s = '';
			$("#hid").empty();
			for(var i=0; i<nodes.length; i++){
			 	var children = nodes[i].children; 
			 	if(children.length==0){
			 		var parent = nodes[i].parent;
			 		var fuid = nodes[i].id; 
			 		fuid=fuid.split("_")[0]; 
			 		if(parent!='#'){
			 			s=parent+"~"+fuid;  
						$("#hid").append("<input type='hidden' name='id' value='"+s+"' />");
			 		}
			 	}
			} 
			$("#myform").ajaxSubmit({
                type: 'post', 
                url: "<%=basePath %>system/organize/Assign.html",   
				success : function(data) {
					showMenu(OrganizeId);    
				},
				error : function(XmlHttpRequest, textStatus, errorThrown) {
					alert("error");
				}
			});
		}
		 	
	 
	</script>
</body>
</html>
