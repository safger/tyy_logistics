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
<title>系统管理 | 系统操作日志管理</title>
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
				系统管理<small>系统操作日志管理</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
				<li><a href="#">系统操作日志管理</a></li>
				<li class="active">系统操作日志列表</li>
			</ol>
		</section>

		<!-- content -->
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-header">
							<h3 class="box-title">系统操作日志列表</h3> 
							<div class="ibox-tools rboor">
			                </div>
						</div>
						<!-- /.box-header -->
						<div class="box-body" style="border-style: solid solid none;border-color: #e7eaec;border-width: 1px 0px;">
							<table id="newAttributeTable" class="table table-bordered table-hover" style="width: 100%">
								<thead>
									<tr>
									  <th>序号</th>
					                  <th>用户名</th>
					                  <th>操作时间</th>
					                  <th>操作内容</th>
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

	<!-- DataTable插件 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/datatables/dataTables.bootstrap.min.js"></script>
	<!-- js分页模板 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/handlebars-v3.0.1.js"></script>
	<script src="<%=basePath%>js/layer/layer.js"></script>
  
	<script>
	$(function() { 
		$('#newAttributeTable').dataTable( {
			 "processing": true, 
			 "serverSide": true,
			 "searchable": true,
			 "searching": true,  
			 "aaSorting" : [[2, "desc"]], 
	         "ajax": "<%=basePath %>system/operatinglog/getData.html", 
	         "columns": [{ "data": null, 
	        	 		"title" : "序号",
		       	  		"createdCell" : function(nTd, sData, oData,
								iRow, iCol) {
							var startnum = this.api().page()
									* (this.api().page.info().length);
							$(nTd).html(iRow + 1 + startnum); // 分页行号累加：$(nTd).html(iRow+1);
						}},
						  { "data": "username",
							"title" : "用户名" },
						  { "data": "createdate",
							"title" : "创建日期" },
						  { "data": "operating",
							"title":"描述"}],
			"columnDefs": [ 
						{ "bSortable": false, "aTargets": [ 0 ] },
						{
						    "targets": [2],
						    "type" : "date",
						    "render": function (data) {
						        if (data !== null) {
						            var javascriptDate = new Date(data);
						            //console.log(data);
						            javascriptDate = javascriptDate.getFullYear() + "/" + (javascriptDate.getMonth()  + 1) + "/" + javascriptDate.getDate() + " " + javascriptDate.getHours() + ":" + javascriptDate.getMinutes() + ":" + javascriptDate.getSeconds();
						            return javascriptDate;
						        } else {
						            return "";
						        }
						    }
						},
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
	                }
	     } );
		 
		 $("input[type=search]").attr("placeholder","请输入名称");
	});
	</script>
</body>
</html>
