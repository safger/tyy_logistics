<%@ page language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String parentcode=request.getParameter("parentcode");		
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> 2.3.6
  </div>
  <strong>Copyright &copy; 2014-2016 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights
  reserved.
</footer>

<!-- jQuery 2.2.3 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="<%=basePath%>js/jquery-ui.min.js"></script> 
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Bootstrap 3.3.6 --> 
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/bootstrap/js/bootstrap.min.js"></script>
	<!-- 时间控件 -->    
	<script src="<%=basePath%>js/moment.min.js"></script> 
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Bootstrap WYSIHTML5 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
	<!-- 虚拟滚动条 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- 延迟点击 -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->  
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/dist/js/app.min.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/dist/js/pages/dashboard.js"></script>