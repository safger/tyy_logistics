<%@ page import="java.util.*" contentType="text/html;charset=UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>系统管理 | 数据字典管理</title>
<!-- The styles -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.css">
<style type="text/css">
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
	<jsp:include page="head.jsp" />
	<c:import url="/system/menuData.html"></c:import>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>
				系统管理 <small>数据字典管理</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
				<li><a href="#">数据字典管理</a></li>
				<li class="active">数据字典列表</li>
			</ol>
		</section>

		<!-- content -->
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">数据字典列表</h3> 
							<div class="ibox-tools rboor">
			                        <a href="#" class="btn btn-primary btn-xs p310" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i> 新增</a> 
			                		<a href="#" class="btn btn-primary btn-xs p310" onclick="back()" style="display: none" id="backbutton"><i class="fa fa-reply"></i> <span id="backLabel">返回</span></a> 
			                </div>
						</div>
						<!-- /.box-header -->
						<div class="box-body" style="border-style: solid solid none;border-color: #e7eaec;border-width: 1px 0px;">
							<table id="newAttributeTable" class="table table-bordered table-hover" style="width: 100%">
								<thead>
									<tr>
										<th>序号</th> 
										<th>名称</th>
										<th>代码</th>
										<th>排序</th>
										<th>操作</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<jsp:include page="foot.jsp" />
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<div class="modal-body">
					<div class="box-body">
						<div class="form-group">
							<label >名称 </label>  <input type="text" class="form-control"   name="fullname" placeholder="请输入名称">
						</div>
						<div class="form-group">
							<label >代码 </label>  <input type="text" class="form-control"   name="code" placeholder="请输入代码">
						</div>
						<div class="form-group">
							<label >排序 </label>  <input type="text" class="form-control"   name="sequence" placeholder="请输入排序">
						</div>
						<div class="form-group">
							<label >描述 </label>
							<textarea class="form-control" name="description" placeholder="请输入描述"></textarea>
						</div>
						<input type="hidden" id="fuid" name="fuid"> 
						
						<input type="hidden" id="parentcode" name="parentcode"> 
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="myclose()">关闭</button>
					<button type="button" class="btn btn-primary" id="save">保存</button>
				</div>
			</div>
		</div> 
	</div>
	<!-- DataTable插件 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.min.js"></script>
	<!-- js分页模板 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/handlebars-v3.0.1.js"></script>
	<script src="<%=basePath%>js/layer/layer.js"></script>
	<!--定义操作列按钮模板-->
	<script id="tpl" type="text/x-handlebars-template">
<div class="btn-group">
  <button type="button" class="btn btn-sm  btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    操作 <span class="caret"></span>
  </button>
  <ul class="dropdown-menu"> 
	{{#each func}}
	<li><a href="#" onclick="{{this.fn}}">{{this.name}}</a></li>
    {{/each}}
  </ul>
</div>
	</script>
  
	<script>
	 var table;
	 var editFlag = false;
	 var tpl = $("#tpl").html();
	 
	 var level = 0;
	 var codeArr = new Array();
	 codeArr[level] = '';
	 
	 //预编译模板
     var template = Handlebars.compile(tpl);
	 
	 function getdata(parentcode){
		 if(table != null){
    		table.fnClearTable(); //清空一下table
    		table.fnDestroy();
    	 }	 
		 
		 if(parentcode == null){
			 parentcode = '';
		 }
		 
		 table = $('#newAttributeTable').dataTable( {
	 		 "processing": true, 
	 		 "serverSide": true,
	 		 "searchable": true,
	 		 "searching": true,
	         "ajax": "<%=basePath%>system/data/getData.html?parentcode="+parentcode,
	         "columns": [{ "data": null,
	        	  			"title" : "序号",
	        	  			"createdCell" : function(nTd, sData, oData,
									iRow, iCol) {
								var startnum = this.api().page()
										* (this.api().page.info().length);
								$(nTd).html(iRow + 1 + startnum); // 分页行号累加：$(nTd).html(iRow+1);
							}},
							 { "data": "fullname","title" : "名称" },
							 { "data": "code","title" : "代码" },
							 { "data": "sequence","title" : "排序" },
						  	 { "data" : null,"title" : "操作"}],
			"columnDefs": [
						{ "bSortable": false, "aTargets": [ 4 ] },
	                    {
	                         targets:4,
	                         render: function (a, b, c, d) {
	                             var context =
	                             {
	                                 func: [
	                                     {"name": "修改", "fn": "edit(\'" + c.fuid + "\')", "type": "primary"},
	                                     {"name": "删除", "fn": "del(\'" + c.fuid + "\')", "type": "danger"},
	                                     {"name": "编辑子目录", "fn": "editChild(\'" + c.code + "\')", "type": "danger"}
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
	                     "search": "搜索 ： _INPUT_"
	                 },
	                 initComplete: function () {
	                     //$("#mytool").append('<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">添加</button>');
	                 }
	      } );
	 }	 
	 
	 $(function() {
		 getdata(null);
		 
		 $("#save").click(add);
		 
		 $("input[type=search]").attr("placeholder","请输入名称");
	 })
	
	 	/**
	     * 添加数据
	     **/
		 function add() {
		 	var code = $("input[name='code']").val();
		 	
		 	if($("input[name='code']").val().length != 3){
	 			layer.msg("请输入长度为3位的代码");
	 			return;
	 		}
		 	
		 	if(level != 0){
		 		code = codeArr[level] + code;
		 	}
		 
	        $.ajax({ 
	            url:"<%=basePath%>system/data/edit.html",
	            type: 'post',
	            data: {
	            	"fullname":$("input[name='fullname']").val(),
	            	"code":code,
	            	"sequence":$("input[name='sequence']").val(),
	            	"description":$("textarea[name='description']").val(), 
	            	"fuid":$("input[name='fuid']").val(),
	            },
	            dataType : "json", 
	            success: function (res) {
	            	if(res.code == "0"){
	            		table.api().ajax.reload(null, false); 
		                $("#myModal").modal("hide");
		                $("#myModalLabel").text("新增");
		                clear();
	            	}else{
	            		layer.msg(res.msg);
	            	}
	            }
	        });
	    }
	
	    /**
	     *编辑方法
	     **/
	     /**
	      *编辑方法
	      **/
	     function edit(fuid) {
	     	$.ajax({
	     		url:"<%=basePath%>system/data/getEditData.html",
	     		type: 'post',
	     		data:{"fuid":fuid},
	     		dataType:"json",
	     		success:function(res){
	     			var s = res.data.datadictionary;
	     			editFlag = true;
	     	        $("#myModalLabel").text("修改");
	            	$("input[name='fullname']").val(s.fullname);
	            	$("input[name='code']").val(s.code); 
	            	$("input[name='sequence']").val(s.sequence);
	            	$("textarea[name='description']").val(s.description); 
	            	$("input[name='fuid']").val(s.fuid);
	            	
	            	$("input[name='code']").attr("disabled",true);
	            	 
	     	        $("#myModal").modal("show"); 
	     		}
	     	});
	     }
		
	    function editChild(code){
	    	if(level == 0){
	    		$("#backLabel").html("返回主目录");
	    	}else{
	    		$("#backLabel").html("返回"+level+"级目录");
	    	}
	    	
			$("#backbutton").show();
	    	
	    	level = level + 1;
	    	codeArr[level] = code;
	    	
	    	getdata(code); 
	    }
	    
	    /**
	     * 清除
	     */
	     function clear() {
	     	$(".modal-content").find("input").each(function (){
	     		$(this).val("");
	     		$(this).attr("disabled",false); 
	     	}) 
	     	$(".modal-content").find("textarea").each(function (){
	     		$(this).val("");
	     	})
	         editFlag = false;
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
	            url: "<%=basePath%>system/data/delete.html",
				data : {
					"fuid" : fuid
				},
				success : function(data) {
					table.api().ajax.reload(null, false); 
				}
			});
		}
	    
	    function back(){
	    	level = level - 1; 
	    	if(level > 0){
	    		if(level == 1){
	    			$("#backLabel").html("返回主目录");
	    		}else{
	    			$("#backLabel").html("返回"+(level-1)+"级目录");
	    		}
	    	}else{
	    		$("#backbutton").hide(); 
	    	}
	    	 
	    	getdata(codeArr[level]);
	    }
	    
	    function myclose(){
	    	clear();
	    } 
	</script>
</body>
</html>
