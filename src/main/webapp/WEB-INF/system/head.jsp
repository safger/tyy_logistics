<%@ page language="java"
	import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/font-awesome-4.6.3/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/ionicons-master/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/iCheck/flat/blue.css">
<!-- Morris chart -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/morris/morris.css">
<!-- jvectormap -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

 
<header class="main-header">
    <!-- Logo -->
    <a href="<%=basePath %>backstage/index.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>管</b>控</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>管控系统</b> | 权限系统</span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav"> 
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="<%=basePath%><c:choose><c:when test="${empty sessionScope.headImg}">/images/user.png</c:when><c:otherwise>/upload/L_${sessionScope.headImg }</c:otherwise></c:choose>" class="user-image" alt="User Image">
              <span class="hidden-xs">${sessionScope.userName }</span> 
            </a>
            <ul class="dropdown-menu"> 
              <!-- User image -->    
              <li class="user-header">
                <img src="<%=basePath%><c:choose><c:when test="${empty sessionScope.headImg}">/images/user.png</c:when><c:otherwise>/upload/L_${sessionScope.headImg }</c:otherwise></c:choose>" class="img-circle" alt="User Image">

                <p>
                  ${sessionScope.userName }    
                  <small>注册时间 ：${sessionScope.CreateTime }</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer"> 
                <div class="pull-left">  
                  <a href="<%=basePath %>backstage/cuser/show.html" class="btn btn-primary btn-flat">基本资料</a>
                </div>
                <div class="pull-right">  
                  <a href="<%=basePath %>system/logout.html" class="btn btn-primary btn-flat">登出</a>
                </div>
              </li> 
            </ul> 
          </li>
          <!-- Control Sidebar Toggle Button -->
        </ul>
      </div>
    </nav>
  </header>