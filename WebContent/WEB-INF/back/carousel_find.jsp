<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.mall.*" %>
<%@page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<style type="text/css">
		.studentInfo{
			background-color: transparent;
			border: none;
		}
		.selectNo{
			appearance:none;
			-moz-appearance:none;
			-webkit-appearance:none;
			border: none;
		}
	</style>
	<script type="text/javascript">
		
		function deleteCarousel(id){
		      var isDel = confirm("您确认要删除吗？");
		      if (isDel) {
		          //要删除
		    	  $.post(
			             "${ctx}/carousel/del.action", //url
			             {"carousel_id" : id},
			             function(data) { //callback
			                if(data) {
			                	alert("成功");
			                	window.location.replace("${ctx}/carousel/find.action");
			                }else{
			                	 alert("失败");
			                  }
			             },
			             "json" //type
			      ); 
		      }
		}
		
		function modifyCarousel(id){
			layer.open(
					{
						title: '修改分类信息',
					    type: 1,
					    content: $('#modifyDiv'+id) ,//这里content是一个DOM，这个元素要放在body根节点下
					}
			);
		}

		function updateCarousel(id){
			var modifyCarouselId = $("#modifyCarouselId"+id).val();
			var modifyProduct_id = $("#modifyProduct_id"+id).val();
			var modifySort_order = $("#modifySort_order"+id).val();
			$.post(
		             "${ctx}/carousel/modify.action", //url
		             {
		            	 "id" : modifyCarouselId,
		            	 "product_id" : modifyProduct_id,
		            	 "sort_order" : modifySort_order
		             },
		             function(data) { //callback
		                if(data) {
		                	alert("成功");
		                	window.location.replace("${ctx}/carousel/find.action");
		                }else{
		                	  alert("失败");
		                  }
		             },
		             "json" //type
		      ); 
		}
	</script>
</head>
<body>
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
							<li class="active">
								<a href="${ctx}/carousel/find.action"><span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;轮播图管理 <span class="sr-only">(current)</span></a>
							</li>
							<li>
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
				<div class="col-sm-2">
					<div class="list-group">
					<a href="${ctx}/carousel/find.action" class="list-group-item active" style="color: green">轮播列表</a>
					<a href="${ctx}/carousel/goadd.action" class="list-group-item" style="color: green">添加轮播</a>
					</div>
				</div>
				<!--
	        	描述：左侧竖向列表结束
	        	右侧功能区占10格,开始
	        -->
				<div class="col-sm-10">
					<!--
                    	描述：功能区上部小导航,开始
                    -->
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="${ctx}/carousel/find.action">轮播列表</a>
						</li>
						<li role="presentation">
							<a href="${ctx}/carousel/goadd.action">添加轮播</a>
						</li>
					</ul>
					<!--
                    	描述：功能区上部小导航,结束
                    -->
					<!-- 展示列表,开始 -->
					<table class="table">
						<tr>
							<td>id</td>
							<td>name</td>
							<td>product_id</td>
							<td>sort_order</td>
							<td>update_time</td>
							<td>modify</td>
							<td>delete</td>
						</tr>
						<c:forEach items="${carouselsList}" var="carousel">
							<tr>
								<td>${carousel.id }</td>
								<td>
									<img alt="" src="/pic/${carousel.name }" style="width:150px;height:150px;"/>
								</td>
								<td>${carousel.product_id }</td>
								<c:if test="${not empty carousel.sort_order}">
									<td>${carousel.sort_order }</td>
								</c:if>
								<c:if test="${empty carousel.sort_order}">
									<td>未设置</td>
								</c:if>
								<td>${carousel.update_time }</td>
								<td>
									<a href="javascript:modifyCarousel(${carousel.id })">modify</a>
								</td>
								<td>
									<a href="javascript:deleteCarousel(${carousel.id })">delete</a>
								</td>
							</tr>
							<!-- 用于弹出更改分类信息的div -->
							<div id="modifyDiv${carousel.id }" style="display: none;">
								&nbsp;id : <a>${carousel.id }</a><br/>
								<input type="hidden" value="${carousel.id }" id="modifyCarouselId${carousel.id }"/>
								&nbsp;product_id : <input type="text" value="${carousel.product_id }" id="modifyProduct_id${carousel.id }"/><br/>
								&nbsp;sort_order : <input type="text" value="${carousel.sort_order }" id="modifySort_order${carousel.id }"/><br/>
								&nbsp;<input type="button" value="提交" onclick="updateCarousel(${carousel.id })"/>
							</div>
					</c:forEach>
					</table>
					<!-- 展示列表,结束 -->
				</div>
				<!--
	        	描述：右侧功能区,结束
	        -->
			</div>
		</div>
	</body>
</html>