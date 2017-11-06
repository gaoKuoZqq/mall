<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.s_m_s.*" %>
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
	<script type="text/javascript">
		function addCategory(){
			 //定义参数
	        /* var options = {
	            url:"${ctx}/category/add.action",
	            dataType:"json",
	            type:"post",
	            success: function(data) {
	                if(data){
	                	layer.msg('添加成功');
	                	//$("#addForm")[0].reset();
	                }else{
	                	layer.msg('添加失败');
	                }
	            }
	        };
	         $("#addForm").ajaxSubmit(options); */
	         var name = $("#name").val();
	         var parent_id = $("#parent_id").val();
	         var status = $("#status").val();
	         var sort_order = $("#sort_order").val();
			$.post(
		             "${ctx}/category/add.action", //url
		             {
		            	 "name" : name,
		            	 "parent_id" : parent_id,
		            	 "status" : status,
		            	 "sort_order" : sort_order
		             },
		             function(data) { //callback
		                if(data) {
		                	alert("添加成功");
		                	location.href="${ctx}/category/goadd.action"
		                }else{
		                	layer.msg('添加失败');
		                  }
		             goPage($("#thisPageIndex").val());
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
							<li class="active">
								<a href="${ctx}/category/find.action"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;分类管理 <span class="sr-only">(current)</span></a>
							</li>
							<li>
								<a href="${ctx}/product/find.action"><span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;商品管理 <span class="sr-only">(current)</span></a>
							</li>
							<li>
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
				<!--
	        	描述：左侧竖向列表结束
	        	右侧功能区占10格,开始
	        -->
				<div class="col-sm-12">
					<!--
                    	描述：功能区上部小导航,开始
                    -->
					<ul class="nav nav-tabs">
						<li role="presentation">
							<a href="${ctx}/category/find.action">分类列表</a>
						</li>
						<li role="presentation" class="active">
							<a href="${ctx}/category/goadd.action">添加分类</a>
						</li>
					</ul>
					<!--
                    	描述：功能区上部小导航,结束
                    	功能区,开始
                    -->
					<form id="addForm">
						<div class="form-group" style="margin-top:10px;">
							分类名称
							<input id="name" class="form-control" id="exampleInputEmail1" placeholder="例 : 战斗机">
							父类:<select id="parent_id" class="form-control"style="margin-bottom:10px;" >
								<option value="0">无父类</option>
								<c:forEach items="${rootCategoriesList}" var="rootCategory">
								<option value="${rootCategory.id }">${rootCategory.name }</option>
								</c:forEach>
							</select>
							&nbsp;status : <select id="status" class="form-control"style="margin-bottom:10px;" >
										<option value="1">可用</option>
										<option value="2">不可用</option>
							</select>
							权重:
							<input id="sort_order" class="form-control" id="exampleInputEmail1" placeholder="例 : 1">
						</div>
						<input type="reset" value="重置" class="btn btn-danger btn-sm btn-block"/>
						<input type="button" value="添加" class="btn btn-success btn-sm btn-block" onclick="addCategory()"/>
					<!-- 功能区,结束 -->
					</form>
				</div>
				<!--
	        	描述：右侧功能区,结束
	        -->
			</div>
		</div>
	</body>
</html>