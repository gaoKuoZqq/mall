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
		function findSunCategory(id){
			$("#rootId").val(id);
			$("#rootIdForm").submit();
		}
		
		function goPage(pageIndex){
			$("#pageIndex").val(pageIndex);
			$("#rootId").val('${pageBean.category.parent_id}');
			$("#rootIdForm").submit();
		}
		
		function deleteCategory(id){
		      var isDel = confirm("您确认要删除吗？");
		      if (isDel) {
		          //要删除
		    	  $.post(
			             "${ctx}/category/del.action", //url
			             {"id" : id},
			             function(data) { //callback
			                if(data) {
			                	alert("成功");
			                }else{
			                	  alert("失败");
			                  }
			             goPage($("#thisPageIndex").val());
			             },
			             "json" //type
			      ); 
		      }
		}
		
		function modifyCategory(id){
			layer.open(
					{
						title: '修改分类信息',
					    type: 1,
					    content: $('#modifyDiv'+id) ,//这里content是一个DOM，这个元素要放在body根节点下
					}
			);
		}

		function updateCategory(id){
			var modifyId = $("#modifyId"+id).val();
			var modifyName = $("#modifyName"+id).val();
			var modifyParent_id = $("#modifyParent_id"+id).val();
			var modifyStatus = $("#modifyStatus"+id).val();
			var modifySort_order = $("#modifySort_order"+id).val();
			$.post(
		             "${ctx}/category/modify.action", //url
		             {
		            	 "id" : modifyId,
		            	 "name" : modifyName,
		            	 "parent_id" : modifyParent_id,
		            	 "status" : modifyStatus,
		            	 "sort_order" : modifySort_order
		             },
		             function(data) { //callback
		                if(data) {
		                	alert("成功");
		                }else{
		                	  alert("失败");
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
				<div class="col-sm-2">
					<div class="list-group">
					<a href="${ctx}/category/find.action" class="list-group-item" style="color: green">全部分类</a>
					<c:forEach items="${rootCategoriesList}" var="category">
						<c:if test="${pageBean.category.parent_id == category.id}">
							<a href="javascript:findSunCategory(${category.id })" class="list-group-item active">${category.name }</a>
						</c:if>
						<c:if test="${pageBean.category.parent_id != category.id}">
							<a href="javascript:findSunCategory(${category.id })" class="list-group-item">${category.name }</a>
						</c:if>
					</c:forEach>
					<form action="${ctx }/category/find.action" id="rootIdForm" method="post">
						<input id="pageIndex" type="hidden" name="pageIndex"/>
						<input type="hidden" id="rootId" name="category.parent_id"/>
					</form>
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
							<a href="${ctx}/student/find.action">分类列表</a>
						</li>
						<li role="presentation">
							<a href="${ctx}/category/goadd.action">添加分类</a>
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
							<td>status</td>
							<td>sort_order</td>
							<td>update_time</td>
							<td>modify</td>
							<td>delete</td>
						</tr>
						<c:forEach items="${pageBean.objList}" var="category">
							<tr>
								<td>${category.id }</td>
								<td>${category.name }</td>
								<c:if test="${category.status==1 }">
									<td>可用</td>
								</c:if>
								<c:if test="${category.status!=1 }">
									<td>不可用</td>
								</c:if>
								<c:if test="${not empty category.sort_order}">
									<td>${category.sort_order }</td>
								</c:if>
								<c:if test="${empty category.sort_order}">
									<td>未设置</td>
								</c:if>
								<td>${category.update_time }</td>
								<td>
									<a href="javascript:modifyCategory(${category.id })">modify</a>
								</td>
								<td>
									<a href="javascript:deleteCategory(${category.id })">delete</a>
								</td>
							</tr>
							<!-- 用于弹出更改分类信息的div -->
							<div id="modifyDiv${category.id }" style="display: none;">
								&nbsp;id : <a>${category.id }</a><br/>
								<input type="hidden" value="${category.id }" id="modifyId${category.id }"/>
								&nbsp;name : <input type="text" value="${category.name }" id="modifyName${category.id }"/><br/>
								&nbsp;parent_name : <select id="modifyParent_id${category.id }">
								<c:forEach items="${rootCategoriesList}" var="rootCategory">
									<option value="0">无父类</option>
									<c:if test="${rootCategory.id==category.parent_id }">
									<option selected="selected" value="${rootCategory.id }">${rootCategory.name }</option>
									</c:if>
									<c:if test="${rootCategory.id!=category.parent_id }">
									<option value="${rootCategory.id }">${rootCategory.name }</option>
									</c:if>
								</c:forEach>
								</select><br/>
								&nbsp;status : <select id="modifyStatus${category.id }">
									<c:if test="${category.status==1 }">
										<option value="1" selected="selected">可用</option>
										<option value="2">不可用</option>
									</c:if>
									<c:if test="${category.status!=1 }">
										<option value="1">可用</option>
										<option value="2" selected="selected">不可用</option>
									</c:if>
								</select><br/>
								&nbsp;sort_order : <input type="text" value="${category.sort_order }" id="modifySort_order${category.id }"/><br/>
								&nbsp;<input type="button" value="提交" onclick="updateCategory(${category.id })"/>
							</div>
					</c:forEach>
					</table>
					<!-- 展示列表,结束 -->
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
					<!-- 用于存储当前是第几页的input -->
					<input type="hidden" id="thisPageIndex" value="${pageBean.pageIndex }"/>
				</div>
				<!--
	        	描述：右侧功能区,结束
	        -->
			</div>
		</div>
	</body>
</html>