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
					系统管理<small>角色管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">角色管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row"> 
					<div class=col-xs-12>
						<div class="box"> 
							<div class="box-header">
								<h3 class="box-title">角色管理</h3>
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
											<h3 class="panel-title">角色信息</h3>
											<div class="ibox-tools rboor">
						                        <a href="javascript:addShow()" class="btn btn-primary btn-xs p310"  ><i class="fa fa-plus"></i> 新增</a>  
						                    </div> 
										</div>
										<div class="panel-body">
										  <table id="newAttributeTable" class="table table-bordered table-hover" style="width: 100%">
							                <thead> 
							                <tr>
							                  <th>序号</th>
							                  <th>名称</th>
							                  <th>是否有效</th>
							                  <th>排序</th>
							                  <th>操作</th>
							                </tr>
							                </thead>
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
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<form id="editForm">
					<div class="modal-body">
						<div class="box-body">
							<div class="form-group">
								<label>名称 </label> 
								<input type="hidden"  name="fuid"> 
								<input type="text" class="form-control"  name="realname" placeholder="请输入名称">
							</div>
							<div class="form-group">
								<label>排序</label> <input type="number" class="form-control"  name="sortcode" placeholder="请输入排序号">
							</div>
							<div class="form-group">
			                  <label>备注</label> 
			                  <textarea class="form-control" rows="3" name="description" placeholder="请输入备注"></textarea>
			                </div>
			                <input type="hidden" name="parentid">
						</div>
					</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save">保存</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="treeModal" tabindex="-1" role="dialog" a  aria-hidden="true">
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
	<form id="myform" action="" method="post"> 
		<input type="hidden" id="RoleId" name="RoleId" value="" /> 
			<div id='hid'></div>
		</form>  
		<!-- DataTable插件 -->
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/jquery.dataTables.min.js"></script>
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.min.js"></script>
		<script src="<%=basePath%>js/jsTree/jstree.min.js"></script>
			<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
		<!-- js分页模板 -->
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/handlebars-v3.0.1.js"></script>
		<!--定义操作列按钮模板--> 
		<script id="tpl" type="text/x-handlebars-template">
		<div class="btn-group">
		  <button type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    操作 <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu"> 
			{{#each func}}
			<li><a href="#" onclick="{{this.fn}}">{{this.name}}</a></li>
		    {{/each}}
		  </ul>
		</div>
		</script>
		
	<script type="text/javascript">
	 var table;
	 var editFlag = false;
	 var tpl = $("#tpl").html();
	 var template = Handlebars.compile(tpl);
		$(function() {
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
				
				$("input[name='parentid']").val(OrganizeId);
				
				showRole(OrganizeId); 
			});  
			
		});
		
		
		
		function showRole(OrganizeId){
			if(table==null){
				table = $('#newAttributeTable').dataTable( {
					 "processing": true, 
					 "serverSide": true,
					 "searchable": true,
					 "searching": true,  
					 "aaSorting" : [[3, "desc"]], 
			         "ajax": "<%=basePath %>system/role/showRole.html?OrganizeId="+OrganizeId+"&date="+new Date(), 
			         "columns": [{ "data": null, 
			       	  			"title" : "<input id='changeAll'  onclick='changeAll()' type='checkbox'/>", 
			       	  			"createdCell" : function(nTd, sData, oData,
											iRow, iCol) {
										var ht='<div class="checkbox">';  
										    ht+='<label>';  
									      	ht+='<input  name="_change" type="checkbox" value='+oData.fuid+'  /> <br/>';
									      	ht+='</label> </div>';		  
										$(nTd).html(ht); // 分页行号累加：$(nTd).html(iRow+1);
									}},
									
								  { "data": "realname",
									"title" : "名称" },
								  { "data": "enabled",
									"title" : "是否有效" },
								  { "data": "sortcode",
									"title":"排序"},
								  { "data" : null,
									"title" : "操作"
									}],
					"columnDefs": [ 
								{ "bSortable": false, "aTargets": [ 0, 4 ] },
			                    {
			                        targets: 4,
			                        render: function (data, type, row,   meta) {
			                        	 var context ;
			                        	if(row.enabled==1){
			                        		 context =
					                            {
					                                func: [
														{"name": "分配权限","fn": "showCompetence(\'" + row.fuid + "\')", "type": "primary"},
														{"name": "禁用","fn": "valid(\'" + row.fuid + "\','0')", "type": "primary"},
					                                    {"name": "修改","fn": "edit(\'" + row.fuid + "\')", "type": "primary"},
					                                    {"name": "删除", "fn": "del(\'" + row.fuid + "\')", "type": "danger"}
					                                ]
					                            };
			                        	}else{  
			                        		context =
				                            {
				                                func: [  
													{"name": "分配权限","fn": "showCompetence(\'" + row.fuid + "\')", "type": "primary"},
													{"name": "启用","fn": "valid(\'" + row.fuid + "\','1')", "type": "primary"},
				                                    {"name": "修改","fn": "edit(\'" + row.fuid + "\')", "type": "primary"},
				                                    {"name": "删除", "fn": "del(\'" + row.fuid + "\')", "type": "danger"}
				                                ]
				                            };
			                        	}
			                           
			                            var html = template(context);
			                            return html;
			                        } 
			                    },
			                    {
			                        targets: 2,
			                        render: function (data, type, row,   meta) {
			                           	if(data=='1'){
				                            return '<span class="label label-success">有效</span>';
			                           	}else{ 
			                           		 return '<span class="label label-danger">无效</span>';
			                           	}
			                        } 
			                    } 
			                ],
			                "language": {
			                    "lengthMenu": "_MENU_ 条记录每页",
			                    "zeroRecords": "没有找到记录",
			                    "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
			                    "infoEmpty": "无记录",
			                    "infoFiltered": "(从 _MAX_ 条记录过滤)",
			                    "paginate": {
			                        "previous": "上一页",
			                        "next": "下一页"
			                    },
			                    "search": " _INPUT_"
			                },
			                initComplete: function () {
			                     
			                }
			     } );
				 
				 $("#save").click(add);
				 
				 $("input[type=search]").attr("placeholder","请输入名称");
			}else{ 
				 table.api().ajax.url('<%=basePath %>system/role/showRole.html?OrganizeId='+OrganizeId).load(); 
			}
			
		}

		 

		 	/**
		     * 添加数据
		     **/
		    function add() {
		        $.ajax({
		            url:"<%=basePath%>system/role/edit.html",
		            data: {
		            	"OrganizeId": $("input[name='parentid']").val(),
		                "fuid": $("input[name='fuid']").val(),
		                "realname": $("input[name='realname']").val(),
		                "sortcode": $("input[name='sortcode']").val(),
		                "description": $("textarea[name='description']").val(),
		            }, success: function (data) { 
		            	table.api().ajax.url('<%=basePath %>system/role/showRole.html?OrganizeId='+ $("input[name='parentid']").val()).load(); 
		                $("#myModal").modal("hide");
		                $("#myModalLabel").text("新增");
		                clear();
		            }
		        });
		    }

		 	
		 	function addShow(){
		 		var id=$("input[name='parentid']").val();
				if(id==null||id.length==0){
					alert("请先选择组织!");
					return; 
				}
				$("#myModal").modal('toggle');
		 	}
		 	 /** 
		     *编辑方法
		     **/
		    function edit(fuid) {
		    	$.ajax({
		    		url:"<%=basePath %>system/role/update_show.html",
		    		data:{"id":fuid},
		    		dataType:"json",
		    		success:function(s){ 
		    	        $("#myModalLabel").text("修改");
		    	        $("input[name='fuid']").val(s.fuid); 
		    	        $("input[name='realname']").val(s.realname); 
		    	        $("input[name='sortcode']").val(s.sortcode);  
		    	        $("textarea[name='description']").val(s.description);
		    	        $("#myModal").modal("show"); 
		    		}
		    	});
		    }

		    /**
		     * 清除
		     */ 
		    function clear() {
		    	$(".modal-content").find("input").each(function (){
		    		if($(this).attr("name")!='parentid'){ 
			    		$(this).val("");
		    		} 
		    	}) 
		    	$(".modal-content").find("textarea").each(function (){
		    		$(this).val("");
		    	})
		        editFlag = false;
		    }

		  
		 
		    function changeAll(){     
		    	if($("#changeAll").is(':checked')){ 
		    		$("input[name='_change']").each(function (){
		    			$(this).prop("checked","checked");
		    		})   
		    	}else{  
		    		$("input[name='_change']").each(function (){
		    			$(this).removeAttr("checked");   
		    		}) 
		    	}
		    }
		    function valid(fuid,skey){
		    	 $.ajax({
			            url:"<%=basePath %>system/role/valid.html",
			            dataType:"text", 
			            async: false,
			            type: 'post', 
			            data: { 
			                "id": fuid,
			                "skey":skey 
			            }, success: function (data) {
			            	 table.api().ajax.url('<%=basePath %>system/role/showRole.html?OrganizeId='+ $("input[name='parentid']").val()).load(); 
			            }
			        });
		    }
		    function del(fuid){
		    	if (!confirm("确认要删除？")) {
		            return;
		        }
		    	 $.ajax({
			            url:"<%=basePath %>system/role/delete.html",
			            dataType:"text", 
			            async: false,
			            type: 'post',  
			            data: { 
			                "id": fuid
			            }, success: function (data) {
			            	 table.api().ajax.url('<%=basePath %>system/role/showRole.html?OrganizeId='+ $("input[name='parentid']").val()).load(); 
			            }
			        });
		    }
		    
		    function showCompetence(fuid){
		    	$("#treeModal").modal("show");
		    	$("#com_jstree").jstree({
					'core' : { 
						 "themes" : { "stripes" : true },
						 "multiple" : true,
						"data":{ 
				            "url":"<%=basePath%>system/menu/treeRole.html?RoleId="+fuid+"&OrganizeId="+ $("input[name='parentid']").val(),
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
		    	$("#com_jstree").bind("loaded.jstree", function (e, data) {
		    	             data.inst.open_all(0); // -1 opens all nodes in the container
		    	 }) 
		    	 $("#RoleId").val(fuid);
		    } 
		     
		    function closeTree(){
		    	$("#treeModal").modal("hide");
		    	$("#com_jstree").jstree().destroy();
		    	
		    }
		    function saveCom(){
		    	$("#hid").html(""); 
		    	var nodes=$("#com_jstree").jstree().get_checked(true);
		    	for(var i=0; i<nodes.length; i++){
					var ch=nodes[i].children; 
					if(ch.length==0){
						s = nodes[i].id; 
						s=s.split("_")[0]; 
						var parid=nodes[i].parent;
						if(parid!='#'){
						var co=parid+";"+s;
						$("#hid").append("<input type='hidden' name='id' value='"+co+"' />");
						}
					}
				}  
		    	$("#myform").ajaxSubmit({
                    type: 'post', 
                    url: "<%=basePath%>system/role/Assign.html",  
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
