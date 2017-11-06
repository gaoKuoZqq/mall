<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.s_m_s.*" %>
<%@page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>分类信息</title>
<link rel="stylesheet"
	href="${ctx}/resources/thirdlib/bootstrap.min.css" />
<script type="text/javascript" src="${ctx}/resources/thirdlib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/thirdlib/jquery-form.js"></script>
<script type="text/javascript" src="${ctx}/resources/thirdlib/layer-v3.1.0/layer/layer.js"></script>
	<script type="text/javascript">
	function goPage(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#goPageForm").submit();
	}
	</script>
</head>
<body>
<form action="${ctx }/order/find.action" method="post" id="goPageForm">
	<input type="hidden" id="pageIndex" name="pageIndex"/>
</form>
		<!--
        	描述：头部导航开始
        -->
		<nav class="navbar navbar-default">
			<div class="container">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
						<a class="navbar-brand" href="#">商城后台管理系统</a>
					</div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li>
								<a href="${ctx}/category/find.action"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;分类管理 <span class="sr-only">(current)</span></a>
							</li>
							<li>
								<a href="${ctx}/product/find.action"><span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;商品管理 <span class="sr-only">(current)</span></a>
							</li>
							<li>
								<a href="${ctx}/carousel/find.action"><span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;轮播图管理 <span class="sr-only">(current)</span></a>
							</li>
							<li class="active">
								<a href="${ctx}/order/find.action"><span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;订单管理 <span class="sr-only">(current)</span></a>
							</li>
						</ul>

						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">admin <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li>
										<a href="#">Action</a>
									</li>
									<li>
										<a href="#">Another action</a>
									</li>
									<li>
										<a href="#">Something else here</a>
									</li>
									<li role="separator" class="divider"></li>
									<li>
										<a href="#">Separated link</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#"><span class="glyphicon glyphicon-remove-sign"></span>&nbsp;&nbsp;退出</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
		<!--
        	描述：头部导航结束
        -->
		<!--
        	描述：左侧可切换的竖向列表组,占2格,开始
        -->
		<div class="container">
			<div class="row">
				<!--
	        	描述：左侧竖向列表结束
	        	右侧功能区占10格,开始
	        -->
				<div class="col-sm-12">
					<!--
                    	描述：功能区上部小导航,开始
                    -->
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a #">订单列表</a>
						</li>
						<li role="presentation">
							<a #">订单子表</a>
						</li>
					</ul>
					<!--
                    	描述：功能区上部小导航,结束
                    	功能区,开始
                    -->
                    <form action="${ctx }/order/find.action" id="findForm" method="post">
						order_id<input name="order.id" type="text" value="${pageBean.order.id }"/>
						order_no<input name="order.order_no" type="text" value="${pageBean.order.order_no }"/>
						user_id<input name="order.user_id" type="text" value="${pageBean.order.user_id }"/>
						status<input name="order.status" type="text" value="${pageBean.order.status }"/>
						<input type="reset"/>
						<input type="submit" value="query"/>
					</form>
                    <table class="table">
                    	<tr>
                    		<td>id</td>
                    		<td>customer</td>
                    		<td>order_no</td>
                    		<td>items</td>
                    		<td>payment</td>
                    		<td>status</td>
                    		<td>update_time</td>
                    		<td>操作</td>
                    	</tr>
                    	<c:forEach items="${pageBean.objList }" var="order">
                    		<tr>
                    			<td>${order.id }</td>
	                    		<td>${order.user_id }</td>
	                    		<td>${order.order_no}</td>
	                    		<td>
	                    		<c:forEach items="${order.order_itemsList }" var="order_item">
	                    			<div float=left>
	                    				<img alt="" src="/pic/${order_item.product_image }" height=50 width=50>
	                    				<p>
	                    				<c:if test="${fn:length(order_item.product_name)>10 }">  
								        	${fn:substring(order_item.product_name, 0, 10)}...  
								        </c:if>  
								        <c:if test="${fn:length(order_item.product_name)<=10 }">  
								            ${order_item.product_name} 
								        </c:if>
								        </p>
	                    			</div>
	                    		</c:forEach>
	                    		</td>
	                    		<td>${order.payment }</td>
	                    		<td>${order.status }</td>
	                    		<td>${order.update_time }</td>
	                    		<td><a href="${ctx }/order_item/find.action?order_item.order_no=${order.order_no}">查看子表</a></td>
	                    	</tr>
                    	</c:forEach>
                    </table>
					<!-- 分页开始 -->
		       		<nav aria-label="Page navigation">
						<ul class="pagination" >
							<!-- 上一页开始 -->
							<c:if test="${pageBean.pageIndex==1 }">
								<li class="disabled">
					    			<a href="javascript:void(0);" aria-label="Previous">
					   				<span aria-hidden="true">&laquo;</span>
					   				</a>
			 					</li>
							</c:if>
							<c:if test="${pageBean.pageIndex>1 }">
								<li>
					    			<a href="javascript:goPage('${pageBean.pageIndex-1 }');" aria-label="Previous">
					   					<span aria-hidden="true">&laquo;</span>
					   				</a>
				  				</li>
							</c:if>
							<!-- 上一页结束 -->
							<c:forEach begin='1' end="${pageBean.totalPage }" var="page">
							<c:if test="${pageBean.pageIndex!=page}">
					 	       <li><a href="javascript:goPage('${page }');">${page}</a></li>
				  			</c:if>
				  			<!-- 遍历的时候page和pageIndex相等，高亮显示 -->
				  			<c:if test="${pageBean.pageIndex==page}">
						        <li class="active"><a href="javascript:goPage('${page }');">${page}</a></li>
				  			</c:if>
							</c:forEach>
							<!-- 下一页开始 -->
							<c:if test="${pageBean.pageIndex==pageBean.totalPage }">
								<li class="disabled">
						    		<a href="javascript:void(0);" aria-label="Next"/>
					   				<span aria-hidden="true">&raquo;</span>
				 				</li>
							</c:if>
							<c:if test="${pageBean.pageIndex<pageBean.totalPage }">
								<li>
					    			<a href="javascript:goPage(${pageBean.pageIndex+1 });" aria-label="Next"/>
					   				<span aria-hidden="true">&raquo;</span>
					   			</li>
							</c:if>
							<!-- 下一页结束 -->
						</ul>
					</nav>
					<!-- 分页结束 -->
				</div>
				<!--
	        	描述：右侧功能区,结束
	        -->
			</div>
		</div>
	</body>
</html>