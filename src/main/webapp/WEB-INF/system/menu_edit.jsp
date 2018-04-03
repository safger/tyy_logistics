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
								<h3 class="box-title">菜单编辑</h3> 
							</div> 
							<form action="<%=basePath%>system/menu/edit.html?parentid=${parentid}"  class="form-horizontal" id="myform" method="post" >
								<div class="box-body"> 
					                <div class="form-group">
					                  <label for="inputEmail3" class="col-sm-2 control-label">名称</label>
					                  <div class="col-sm-10">
					                  	<input type="text" id="username" required="required" name="menuName" class="form-control" value='${baseMenu.menuName }' />
										<input type="hidden" name="fuid"  value='${id }' />
					                  </div>
					                </div>
					                <div class="form-group">
					                  <label for="inputEmail3" class="col-sm-2 control-label">排序</label>
					                  <div class="col-sm-10">
										<input type="number" id="sort" required="required" name="menuOrder" class="form-control" value='${baseMenu.menuOrder }' />
					                  </div>
					                </div> 
					                <div class="form-group">
					                  <label for="inputEmail3" class="col-sm-2 control-label">路径</label>
					                  <div class="col-sm-10">
					                  	<input type="text"  name="menuUrl" required="required" class="form-control" value='${baseMenu.menuUrl }' />
					                  </div>
					                </div>
					              </div>
					              <div class="box-footer" style="margin-left: 16%">    
					                <button type="submit"    class="btn btn-primary">保存</button>
					                <button type="button" onclick="resetB()"  class="btn btn-warning">重置</button>
					                <button type="button" onclick="re()"  class="btn btn-danger">返回</button>
					              </div> 
				              </form>
						</div>
					</div>
				</div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="foot.jsp" />
	</div>
	<!-- ./wrapper -->
 
	<script type="text/javascript">
	function resetB(){
		$("#myform").find(("input[type='text']")).val("");
	}
	function re(){
		window.location.href="javascript:history.go(-1);";
	}
	</script>
</body>
</html>
