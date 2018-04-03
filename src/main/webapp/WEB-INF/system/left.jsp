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

<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="<%=basePath%><c:choose><c:when test="${empty sessionScope.headImg}">/images/user.png</c:when><c:otherwise>/upload/L_${sessionScope.headImg }</c:otherwise></c:choose>" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>${sessionScope.userName }</p>
        </div>
      </div>
       
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">菜单</li>
        <li class="treeview"> 
          <a href="<%=basePath %>backstage/index.html">
            <i class="fa fa-dashboard"></i> <span>首页</span> 
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu"> 
            <li id="index"><a href="<%=basePath %>backstage/index.html"><i class="fa fa-circle-o"></i> 控制台</a></li>
          </ul>
        </li>
        <c:forEach items="${parentList }" var="list">
	        <li>
	        	 <a href="<%=basePath%>${list.menuUrl }">
	        	   <i class="fa fa-th"></i> 
	        	   <span>${list.menuName }</span>
	        	    <span class="pull-right-container">
		              <i class="fa fa-angle-left pull-right"></i>
		            </span>
		          </a>
		          <c:if test="${list.children!=null }">
		           	<ul class="treeview-menu">
						<c:forEach items="${list.children }" var="clist">
							 <li ><a href="<%=basePath%>${clist.menuUrl }"><i class="fa fa-circle-o"></i> ${clist.menuName}</a></li>
						</c:forEach>
		         	 </ul>
		          </c:if>
        		</li>
            </c:forEach> 
      </ul>
    </section> 
    <!-- /.sidebar -->
  </aside> 
  	<script src="<%=basePath%>Bootstrap_AdminLTE_2.3.6/plugins/jQuery/jquery-2.2.3.min.js"></script>
  <script>
		$(function() {
			var hh=window.location.href; 
			$(".treeview-menu").find("a").each(function (){
				var href=$(this).attr("href");  
				<%if(request.getServerPort()==80){ %>
					href=href.replace(":80","");
				<%}%>   
				hh=hh.replace("#",""); 
				if(href==hh){   
					$(this).parent().attr("class","active");
					$(this).parent().parent().parent().attr("class","active treeview")
				}
			}) 
		})
	</script>
