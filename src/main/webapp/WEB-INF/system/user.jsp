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
 <link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-validator/css/formValidation.min.css">
 
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
					系统管理<small>用户管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">用户管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row"> 
					<div class=col-xs-12>
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">用户管理</h3>
							</div>
							<div class="box-body">
								<div class="row-fluid">
									<div class="panel panel-info">
										<div class="panel-heading">
											<h3 class="panel-title">用户列表</h3>
										</div>
										<div class="panel-body">
											<div id="jstree_demo_div"></div>
										</div>
									</div>  
									<div class="panel panel-info pa">
										<div class="panel-heading">
											<h3 class="panel-title">用户信息</h3>
											<div class="ibox-tools rboor" style="display: none;"> 
						                        <a href="javascript:addShow()" class="btn btn-primary btn-xs p310"  ><i class="fa fa-plus"></i> 新增</a>  
						                        <a href="javascript:showRole()" class="btn btn-primary btn-xs p310" ><i class="fa fa-calendar-check-o"></i> 分配角色</a>
						                    </div> 
										</div> 
										<div class="panel-body">
										  <table id="newAttributeTable" class="table table-bordered table-hover" style="width: 100%">
							                <thead> 
							                <tr>
							                  <th>序号</th>
							                  <th>用户名</th>
							                  <th>姓名</th>
							                  <th>角色</th>
							                  <th>最后登录时间</th>
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
				<form id="editForm" method="post" action=""  >
					<div class="modal-body">
						<div class="box-body">
							<div class="form-group">
								<label>用户名 </label> 
								<input type="hidden"  name="fuid" value="">
								<input type="hidden"  name="OrganizeId" value="">  
								<input type="text" class="form-control"  name="username"  placeholder="请输入名称">
							</div>
							<div class="form-group"> 
								<label>密码</label> <input type="password" class="form-control"   name="userpassword" placeholder="请输入密码">
							</div>
							<div class="form-group">
								<label>姓名</label> <input type="text" class="form-control"  name="realname" placeholder="请输入姓名">
							</div>
							<div class="form-group">
								<label>手机</label> <input type="number" class="form-control"  name="mobile" placeholder="请输入手机">
							</div>
							<div class="form-group">
			                  <label>备注</label> 
			                  <textarea class="form-control" rows="3" name="description" placeholder="请输入备注"></textarea>
			                </div>
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
	<div class="modal fade" id="roleModal" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">选择角色</h4>
				</div>
					<div class="modal-body">
						<div class="box-body">
							 <div class="form-group" id="ch">
				
				                   
				              </div>
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveRole()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ./wrapper -->
		<!-- DataTable插件 -->
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/jquery.dataTables.min.js"></script>
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.min.js"></script>
		<script src="<%=basePath%>js/jsTree/jstree.min.js"></script>
		<!-- js分页模板 -->
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/handlebars-v3.0.1.js"></script> 
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-validator/js/formValidation.min.js"></script> 
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-validator/js/framework/bootstrap.min.js"></script>
		<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-validator/js/language/zh_CN.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
		  
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
			//树形插件------------------------------
			$("#jstree_demo_div").jstree({
				'core' : {
					"multiple" : false,
					 "themes" : { "stripes" : true },
					"data":{  
			            "url":"<%=basePath%>system/organize/tree.html",
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
				$(".ibox-tools").css("display","block");
				showUser(OrganizeId); 
			});  
			
			 //-----------------------------------表单验证
			$('#editForm').formValidation({ 
		 	        fields: {
		 	            username: {
		 	                validators: {
		 	                    notEmpty: {
		 	                        message: '用户名必须设置'
		 	                    },
		 	                    stringLength: {
		 	                        min: 5, 
		 	                        max: 30,
		 	                        message: '用户名必须在6-30个字符之间'
		 	                    },
		 	                    regexp: { 
		 	                        regexp: /^[a-zA-Z0-9_\.]+$/,
		 	                        message: '用户名只能由英文字母，数字，点和下划线'
		 	                    }, 
		 	                   callback: {       
		 	                      message: '用户名已经注册',         
		 	                      callback: function(value, validator) { 
		 	                          //用ajax提交到后台，进行校验。如 果校验失败  return false; 校验成功 return true;
		 	                          var re=false;
		 	                          var fuid=$("input[name='fuid']").val();
		 	                          if(fuid!=null&&fuid.length>0){
		 	                        	 re=true;
		 	                          }else{
		 	                        	 $.ajax({
												url : "/system/IsExist.html?username=" + $("input[name='username']").val() + "&time=" + new Date(),
												async : false,
												dataType:"text",
												success : function(data) {
														if(data=='true'){
															re=true;
														}  
													}
												}); 
		 	                          } 
		 	                          return re; 
		 	                      }
		 	                  } 
		 	                }
		 	            },
		 	           userpassword: {
		 	                validators: {
		 	                    notEmpty: {
		 	                        message: '密码不能为空'
		 	                    },
		 	                    different: {
		 	                        field: 'username',
		 	                        message: '密码不能和用户名相同'
		 	                    }
		 	                }
		 	            },
		 	           realname: {
		 	                validators: {
		 	                    notEmpty: {
		 	                        message: '姓名不能为空'
		 	                    }
		 	                }
		 	            }
		 	        } 
		 	    });  
			 $("#save").click(add);
		});
		
		
		
		function showUser(OrganizeId){
			if(table==null){
				table = $('#newAttributeTable').dataTable( {
					 "processing": true, 
					 "serverSide": true,
					 "searchable": true,
					 "searching": true,  
					 "aaSorting" : [[3, "desc"]], 
			         "ajax": "<%=basePath %>system/usershow.html?OrganizeId="+OrganizeId,
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
									
								  { "data": "username",
									"title" : "用户名" },
								  { "data": "realname",
									"title" : "姓名" },
								  { "data": "roleid", 
									"title" : "角色"},  
								  { "data": "lastvisit",
									"title":"最后登录时间"},
								  { "data" : null,
									"title" : "操作"
									}],
					"columnDefs": [ 
								{ "bSortable": false, "aTargets": [ 0, 5 ] },
								{
								    "targets": [4],
								    "type" : "date",
								    "render": function (data) {
								        if (data !== null) {
								            var javascriptDate = new Date(data);
								            javascriptDate = javascriptDate.getFullYear() + "/" + (javascriptDate.getMonth()  + 1) + "/" + javascriptDate.getDate() + " " + javascriptDate.getHours() + ":" + javascriptDate.getMinutes() + ":" + javascriptDate.getSeconds();
								            return javascriptDate;
								        } else { 
								            return "";
								        }
								    } 
								}, 
			                    {
			                        targets: 5,
			                        render: function (data, type, row,   meta) {
			                            var context =
			                            {
			                                func: [
			                                    {"name": "修改","fn": "edit(\'" + row.fuid + "\')", "type": "primary"},
			                                    {"name": "删除", "fn": "del(\'" + row.fuid + "\')", "type": "danger"}
			                                ]
			                            };
			                            
			                            var html = template(context);
			                            return html;
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
				 
				 
				 $("input[type=search]").attr("placeholder","请输入名称");
			}else{ 
				 table.api().ajax.url('<%=basePath %>system/usershow.html?OrganizeId='+OrganizeId).load();
			}
			
		}

		 

		 	/**
		     * 添加数据
		     **/
		    function add() {    
		    	$('#editForm').formValidation('validate');    
		    	if($('#editForm').data('formValidation').isValid()){
		    		$("#editForm").ajaxSubmit({ 
					       type: 'post', 
					        async: false,
					        url: "<%=basePath%>system/edit.html",
					        dataType:"json", 
							success : function(data) { 
								 table.api().ajax.url('<%=basePath %>system/usershow.html?OrganizeId='+$("input[name=OrganizeId]").val()).load();
				                $("#myModal").modal("hide");  
				                clear();  
							},
							error : function(XmlHttpRequest, textStatus, errorThrown) {
								alert("error");
							}
						});   	
		    	}
		    }

		 	
		 	function addShow(){ 
		 		var id=$("input[name='OrganizeId']").val();
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
		    		url:"<%=basePath%>system/update_show.html",
		    		data:{"id":fuid},
		    		dataType:"json",
		    		success:function(s){ 
		    	        $("#myModalLabel").text("修改");
		    	        $("input[name='fuid']").val(s.fuid); 
		    	        $("input[name='username']").val(s.username); 
		    	        $("input[name='userpassword']").val(s.userpassword); 
		    	        $("input[name='realname']").val(s.realname); 
		    	        $("input[name='mobile']").val(s.mobile); 
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
		    		if($(this).attr("name")!='OrganizeId'){
			    		$(this).val("");
		    		}
		    	}) 
		    	$(".modal-content").find("textarea").each(function (){
		    		$(this).val("");
		    	})
		        editFlag = false; 
		    	$('#editForm').data('formValidation').resetForm();
		    }

		    /**
		     * 删除数据
		     * @param name
		     */
		    function del(fuid) {
		    	if (!confirm("确认要删除？")) {
		            return;
		        }
		        $.ajax({
		            url: "<%=basePath%>system/delete.html",
		            dataType:"text",
		            data: {
		                "id": fuid
		            }, success: function (data) { 
		            	table.api().ajax.url('<%=basePath %>system/usershow.html?OrganizeId='+$("input[name=OrganizeId]").val()).load();
		            }
		        });
		    }
		    
		    function showRole(){
		    	var OrganizeId=$("input[name='OrganizeId']").val();
				if(OrganizeId==null||OrganizeId.length==0){
					alert("请先选择组织!");
					return;  
				}
				var uu=$("input[name='_change']:checked");
				if(uu.length==0){
					alert("请先选择人员!");
					return;  					
				}
				 $.ajax({
			            url: "<%=basePath%>system/role/showChange.html",
			            dataType:"json",
			            type: "post",
			            data: {
			                "OrganizeId": OrganizeId
			            }, success: function (data) { 
			            	var ht="";
			            	if(data!=null&&data.length>0){
			            		for(var a=0;a<data.length;a++){
			            			ht+='<div class="checkbox">';
					            	ht+='<label>';
					            	ht+=' <input name="ro" type="checkbox" value="'+data[a].fuid+'">';
					            	ht+=data[a].realname;
					            	ht+=' </label>';
					            	ht+=' </div>';
			            		}
			            	}
		                	$("#ch").html(ht); 
			            	$("#roleModal").modal('toggle');
			            }
			        });
				
		    }
		    
		    function saveRole(){
		    	var val=$("input[name=_change]:checked");
			 	 if(val.length==0){
			 	 	alert("请先选择人员");
			 	 	return;
			 	 }else{
			 		var userid="";
			 		val.each(function (){
			 			userid+=$(this).val()+',';
			 		})
			 		userid=userid.substring(0,userid.length-1);
			 		var roleid="";
			 		$("input[name=ro]:checked").each(function (){
			 			roleid+=$(this).val()+',';
			 		}) 
			 		roleid=roleid.substring(0,roleid.length-1);
			 		 $.ajax({ 
				            url: "<%=basePath %>system/AssignRoles.html", 
				            dataType:"json",
				            type: "post",
				            data: {
				                "userid": userid,
				                "roleid":roleid,
				                "OrganizeId":$("input[name='OrganizeId']").val()
				            }, success: function (data) { 
				            	$("#roleModal").modal('hide'); 
				            	table.api().ajax.url('<%=basePath %>system/usershow.html?OrganizeId='+$("input[name=OrganizeId]").val()).load();
				            }
				        });
				 }
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
		    
	</script>
</body>
</html>
