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
		<!-- Left side column. contains the logo and sidebar -->     
		<c:import url="/system/menuData.html"></c:import>  
		<!-- Content Wrapper. Contains page content -->	 
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					管控系统 <small>权限系统</small>
				</h1> 
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
					<li class="active">控制台</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<!-- Small boxes (Stat box) -->
				<div class="row">
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-aqua">
							<div class="inner">
								<h3>${interCount }</h3>

								<p>网吧总数</p>
							</div>
							<div class="icon">
								<i class="ion-ios-bookmarks"></i>
							</div>
							<a href="<%=basePath%>backstage/internetcafes/show.html" class="small-box-footer">查看详情 <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-green">
							<div class="inner">
								<h3>${onlineCount }</h3>

								<p>PC在线总数</p>
							</div>
							<div class="icon">
								<i class="ion-monitor"></i>
							</div>
							<a href="<%=basePath%>backstage/computer/show.html" class="small-box-footer">查看详情 <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-red">
							<div class="inner">
								<h3>${pcCount }</h3>
								<p>PC总数</p>
							</div>
							<div class="icon">
								<i class="ion ion-pie-graph"></i>
							</div>
							<a href="<%=basePath%>backstage/computer/show.html" class="small-box-footer">查看详情 <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>
					<!-- ./col -->
					<!-- ./col -->
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-yellow">
							<div class="inner">
								<h3>${memberCount }</h3>

								<p>成员账户</p>
							</div>
							<div class="icon">
								<i class="ion ion-person-add"></i>
							</div>
							<a href="<%=basePath%>backstage/member/show.html" class="small-box-footer">查看详情 <i class="fa fa-arrow-circle-right"></i></a>
						</div>
					</div>

				</div>
				<!-- /.row -->
				<!-- Main row -->
				<div class="row">
					<!-- Left col -->
					<section class="col-lg-7 connectedSortable">

						<div class="box">
							<div class="box-header with-border">
								<h3 class="box-title">网吧列表</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table class="table table-bordered" id="interTable" style="font-size: 1.5rem;margin-bottom: 0px;"> 
									<thead>
										<tr>
											<th style="width: 10px">#</th>
											<th>网吧名称</th>
											<th>在线PC</th> 
											<th>Label</th>
										</tr>
									</thead> 
								</table>
							</div>
							<!-- /.box-body -->
							<!-- <div class="box-footer clearfix">
								<ul class="pagination pagination-sm no-margin pull-right">
									<li><a href="#">«</a></li>
									<li><a href="#">1</a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">»</a></li>
								</ul>
							</div> -->
						</div>
						<div class="box">
							<div class="box-header with-border">
								<h3 class="box-title">电脑列表</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table class="table table-bordered" id="computerTable" style="font-size: 1.5rem;margin-bottom: 0px;"> 
									<thead>
										<tr>
											<th style="width: 10px">#</th>
											<th>所属网吧</th>
											<th>机器名称</th> 
											<th>状态</th>
											<th>mac</th>
										</tr>
									</thead> 
								</table>
							</div>
							<!-- /.box-body -->
							<!-- <div class="box-footer clearfix">
								<ul class="pagination pagination-sm no-margin pull-right">
									<li><a href="#">«</a></li>
									<li><a href="#">1</a></li>
									<li><a href="#">2</a></li>
									<li><a href="#">3</a></li>
									<li><a href="#">»</a></li>
								</ul>
							</div> -->
						</div>



					</section>
					<!-- /.Left col -->
					<!-- right col (We are only adding the ID to make the widgets sortable)-->
					<section class="col-lg-5 connectedSortable">
						<div class="box box-info">
							<div class="box-header">
								<i class="glyphicon glyphicon-cloud"></i>

								<h3 class="box-title">云端维护</h3>
								<!-- tools box -->
								<div class="pull-right box-tools">
									<button type="button" class="btn btn-info btn-sm" data-widget="remove" data-toggle="tooltip" title="Remove">
										<i class="fa fa-times"></i>
									</button>
								</div>
								<!-- /. tools -->
							</div> 
							  
							<div class="box-body" >
									<input id="mySwitch" class="form-control" data-off-color="warning"  data-off-text="关闭" data-on-text="开启"  type="checkbox"> <span style="font-size: 12px;margin-left: 20px">注：此开关为一键开启或关闭所有网吧的云端维护功能</span> 
							</div>
						</div>  
						<!-- solid sales graph -->
						<%-- <div class="box box-info">
							<div class="box-header with-border">
								<h3 class="box-title">每日开机量</h3>

								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool" data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
									<button type="button" class="btn btn-box-tool" data-widget="remove">
										<i class="fa fa-times"></i>
									</button>
								</div>
							</div>
							<div class="box-body chart-responsive">
								<div class="chart" id="line-chart" style="height: 300px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
									<svg height="300" version="1.1" width="582" xmlns="http://www.w3.org/2000/svg" style="overflow: hidden; position: relative;">
										<desc style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">Created with Raphaël 2.1.0</desc>
										<defs style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></defs>
										<text x="48.5" y="263" text-anchor="end" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: end; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">0</tspan></text>
										<path fill="none" stroke="#aaaaaa" d="M61,263H557" stroke-width="0.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<text x="48.5" y="203.5" text-anchor="end" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: end; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">5,000</tspan></text>
										<path fill="none" stroke="#aaaaaa" d="M61,203.5H557" stroke-width="0.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<text x="48.5" y="144" text-anchor="end" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: end; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">10,000</tspan></text>
										<path fill="none" stroke="#aaaaaa" d="M61,144H557" stroke-width="0.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<text x="48.5" y="84.5" text-anchor="end" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: end; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">15,000</tspan></text>
										<path fill="none" stroke="#aaaaaa" d="M61,84.5H557" stroke-width="0.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<text x="48.5" y="24.99999999999997" text-anchor="end" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: end; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal">
										<tspan dy="3.9999999999999716" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">20,000</tspan></text>
										<path fill="none" stroke="#aaaaaa" d="M61,24.99999999999997H557" stroke-width="0.5" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<text x="465.99635479951394" y="275.5" text-anchor="middle" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal" transform="matrix(1,0,0,1,0,6)">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">2013</tspan></text>
										<text x="245.4179829890644" y="275.5" text-anchor="middle" font="10px &quot;Arial&quot;" stroke="none" fill="#888888" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: sans-serif;" font-size="12px" font-family="sans-serif" font-weight="normal" transform="matrix(1,0,0,1,0,6)">
										<tspan dy="4" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">2012</tspan></text>
										<path fill="none" stroke="#3c8dbc"
											d="M61,231.2746C74.86148238153098,230.9414,102.58444714459296,233.282725,116.44592952612393,229.9418C130.3074119076549,226.600875,158.0303766707169,206.02637650273223,171.89185905224787,204.5472C185.60267314702307,203.08410150273224,213.0243013365735,220.995975,226.7351154313487,218.1727C240.4459295261239,215.349425,267.8675577156743,184.77624412568306,281.57837181044954,181.961C295.43985419198054,179.11481912568308,323.1628189550425,192.56687499999998,337.0243013365735,195.527C350.88578371810445,198.487125,378.60874848116646,219.70539398907104,392.4702308626974,205.642C406.18104495747264,191.73146898907103,433.60267314702304,92.4066788674033,447.31348724179827,83.63129999999998C460.8736330498177,74.9523538674033,487.9939246658566,126.05476730769232,501.55407047387604,135.8247C515.415552855407,145.81174230769233,543.138517618469,155.95057500000001,557,162.6592"
											stroke-width="3" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
										<circle cx="61" cy="231.2746" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="116.44592952612393" cy="229.9418" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="171.89185905224787" cy="204.5472" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="226.7351154313487" cy="218.1727" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="281.57837181044954" cy="181.961" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="337.0243013365735" cy="195.527" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="392.4702308626974" cy="205.642" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="447.31348724179827" cy="83.63129999999998" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="501.55407047387604" cy="135.8247" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle>
										<circle cx="557" cy="162.6592" r="4" fill="#3c8dbc" stroke="#ffffff" stroke-width="1" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></circle></svg>
									<div class="morris-hover morris-default-style" style="left: 14.5px; top: 157px; display: none;">
										<div class="morris-hover-row-label">2011 Q1</div>
										<div class="morris-hover-point" style="color: #3c8dbc">Item 1: 2,666</div>
									</div>
								</div>
							</div>
							<!-- /.box-body -->
						</div> --%> 
						<div class="box box-danger">
				            <div class="box-header with-border">
				              <h3 class="box-title">PC在线比例</h3>
				
				              <div class="box-tools pull-right">
				                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
				                </button>
				                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				              </div>
				            </div>
				            <div class="box-body chart-responsive">
				              <div class="chart" id="sales-chart" style="height: 300px; position: relative;"></div>
				            </div>
				            <!-- /.box-body -->
				          </div>
						<!-- /.box -->

					</section>
					<!-- right col -->
				</div>
				<!-- /.row (main row) -->

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="foot.jsp" />
		<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
	<script type="text/javascript">
	
	$(function() {
	})
	</script>
</body>
</html>
