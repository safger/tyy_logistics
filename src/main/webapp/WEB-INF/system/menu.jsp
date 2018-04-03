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
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<jsp:include page="head.jsp" />
		<c:import url="/system/menuData.html"></c:import>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					系统管理<small>菜单管理</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 系统管理</a></li>
					<li class="active">菜单管理</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class=col-xs-12>
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">菜单列表</h3> 
								<button type="button" onclick="add()" class="btn btn-primary btn-sm" style="float: right;margin-right: 20px" >新增一级菜单</button>
							</div>
							<div class="box-body">
								<table class="table tree">
									<tr>
										<th>菜单名称</th>
										<th>路径</th>
										<th>排序</th>
										<th>操作</th>
									</tr>
									<c:forEach items="${parentList }" var="list" varStatus="stuts">
										<tr class="treegrid-${list.fuid }">
											<td>${list.menuName }</td>
											<td>${list.menuUrl }</td>
											<td>${list.menuOrder }</td>
											<td>
												<div class="btn-group">
													<button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
														操作<span class="caret"></span>
													</button>
													<ul class="dropdown-menu">
														<li><a href="<%=basePath%>system/menu/menu_edit.html?parentid=${list.fuid }">新增子目录</a></li>
														<li><a href="<%=basePath %>system/menu/updateShow.html?id=${list.fuid }">修改</a></li>
														<li><a href="javascript:delpar('${list.fuid }')">删除</a></li>
													</ul>
												</div>
											</td>
										</tr>
										<c:if test="${list.children != null}">
											<c:forEach items="${list.children }" var="clist" varStatus="stuts">
												<tr class="treegrid-${clist.fuid } treegrid-parent-${list.fuid }">
													<td>${clist.menuName }</td>
													<td>${clist.menuUrl }</td>
													<td>${clist.menuOrder }</td>
													<td>
														<div class="btn-group">
															<button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																操作<span class="caret"></span>
															</button>
															<ul class="dropdown-menu">
																<li><a href="<%=basePath%>system/menu/menu_edit.html?parentid=${clist.fuid }">新增子目录</a></li>
																<li><a href="<%=basePath %>system/menu/updateShow.html?id=${clist.fuid }">修改</a></li>
																<li><a href="javascript:delpar('${clist.fuid }')">删除</a></li>
															</ul>
														</div>
													</td>
												</tr>
												<c:if test="${clist.children!=null }">
													<c:forEach items="${clist.children }" var="cclist" varStatus="stuts">
														<tr class="treegrid-${cclist.fuid } treegrid-parent-${clist.fuid }">
															<td>${cclist.menuName }</td>
															<td>${cclist.menuUrl }</td>
															<td>${cclist.menuOrder }</td>
															<td>
																<div class="btn-group">
																	<button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																		操作<span class="caret"></span>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="<%=basePath%>system/menu/menu_edit.html?parentid=${cclist.fuid }">新增子目录</a></li>
																		<li><a href="<%=basePath %>system/menu/updateShow.html?id=${cclist.fuid }">修改</a></li>
																		<li><a href="javascript:delpar('${cclist.fuid }')">删除</a></li>
																	</ul>
																</div> </td>
														</tr>
													</c:forEach>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</table>
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



	<script type="text/javascript" src="<%=basePath%>js/jquery-treegrid-master/js/jquery.treegrid.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-treegrid-master/js/jquery.treegrid.bootstrap3.js"></script>
	<script type="text/javascript">
    $(document).ready(function() {  
        $('.tree').treegrid(); 
    });
	 function add(){
		 var url="<%=basePath%>system/menu/menu_edit.html";
		 window.location.href=url;
	 } 
	 function delpar(id){
		 if(!window.confirm('确定要删除吗？')){
             return ;
          } 
		 $.ajax({
		    url: "<%=basePath%>system/menu/deletePar.html?parentid=" + id + "&time=" + new Date(),
				async : false,
				contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				dataType : "text",
				success : function(data) {
					if (data == "0") {
						alert("请先删除子菜单");
					} else {
						location.reload();
					}
				}
			});
		}
	</script>
</body>
</html>
