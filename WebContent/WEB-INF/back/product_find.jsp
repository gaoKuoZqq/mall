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
			$.post(
		             "${ctx}/category/findCategoryByParent_id.action", //url
		             {"parent_id" : id},
		             function(data) {
		            	 var category_id = '${pageBean.product.category_id}';
		            	 $("option#temporary").remove();
		            	 $("a").removeClass('active');
		            	 $("#rootCategory"+id).addClass('active');
		            	 $("#parent_idInp").val(id);
		            	 for(var a in data){
		            		 if(data[a].id == category_id){
		            			 $("#categorySel").after("<option selected='selected' id='temporary' value='"+data[a].id+"'>"+data[a].name+"</option>")
		            		 }else{
		            			 $("#categorySel").after("<option id='temporary' value='"+data[a].id+"'>"+data[a].name+"</option>")
		            		 }
		            		
		            	 }
		             },
		             "json" //type
		      ); 
		}
		
		function findProduct(){
			var category_id = $("#findProductSel").val();
			$("#category_idInp").val(category_id);
			$("#category_idForm").submit();
		}
		
		$(document).ready(function(){
			$("#rootCategory${pageBean.category.parent_id}").addClass('active');
			findSunCategory('${pageBean.category.parent_id}');
		})
		
		function goPage(pageIndex){
			$("#pageIndexInp").val(pageIndex);
			findProduct();
		}
		
		function deleteProduct(id){
		      var isDel = confirm("您确认要删除吗？");
		      if (isDel) {
		    	  $.post(
			             "${ctx}/product/del.action",
			             {"id" : id},
			             function(data) { //callback
			                if(data) {
			                	alert("删除成功");
			                }else{
			                	  alert("删除失败");
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
							<li>
								<a href="${ctx}/category/find.action"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;分类管理 <span class="sr-only">(current)</span></a>
							</li>
							<li class="active">
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
					<div id="rootCategoryDiv" class="list-group">
					<c:forEach items="${rootCategoriesList}" var="category">
						<c:if test="${pageBean.category.parent_id == category.id}">
							<a id="rootCategory${category.id}" href="javascript:findSunCategory(${category.id })" class="list-group-item active">${category.name }</a>
						</c:if>
						<c:if test="${pageBean.category.parent_id != category.id}">
							<a id="rootCategory${category.id}" href="javascript:findSunCategory(${category.id })" class="list-group-item">${category.name }</a>
						</c:if>
					</c:forEach>
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
							<a href="${ctx}/product/find.action">商品列表</a>
						</li>
						<li role="presentation">
							<a href="${ctx}/product/goadd.action">添加商品</a>
						</li>
					</ul>
					<!--
                    	描述：功能区上部小导航,结束
                    -->
                    <select id="findProductSel" class="form-control"style="margin-bottom:10px;" onchange="findProduct()">
                    	<option id="categorySel" selected="selected" value="0">未选择</option>
                    </select>
                    <form id="category_idForm" action="${ctx }/product/find.action" method="post">
                    	<input type="hidden" id="pageIndexInp" name="pageIndex" value="1"/>
                    	<input type="hidden" id="category_idInp" name="product.category_id"/>
                    	<input type="hidden" id="parent_idInp" name="category.parent_id"/>
                    </form>
					<!-- 展示列表,开始 -->
					<table class="table">
						<tr>
							<td>id</td>
							<td>name</td>
							<td>main_image</td>
							<td>subtitle</td>
							<!-- <td>detail</td> -->
							<td>price</td>
							<td>stock</td>
							<td>status</td>
							<td>update_time</td>
							<td>modify</td>
							<td>delete</td>
							<td>other</td>
						</tr>
						<c:forEach items="${pageBean.objList}" var="product">
							<tr>
								<td>${product.id }</td>
								<td style="width:140px;">${product.name }</td>
								<td>
									<img src="/pic/${product.main_image}" style="width:80px;height:80px;"/>
								</td>
								<c:if test="${not empty product.subtitle }">
									<td style="width:80px">${product.subtitle}</td>
								</c:if>
								<c:if test="${empty product.subtitle }">
									<td style="width:80px">未添加副标题</td>
								</c:if>
								<!-- <c:if test="${not empty product.detail }">
									<td>${product.detail}</td>
								</c:if>
								<c:if test="${empty product.detail }">
									<td>未添加详情</td>
								</c:if> -->
								<td>${product.price }</td>
								<td>${product.stock }</td>
								<c:if test="${product.status==1 }">
									<td>在售</td>
								</c:if>
								<c:if test="${product.status==2 }">
									<td>下架</td>
								</c:if>
								<c:if test="${product.status==3 }">
									<td>删除</td>
								</c:if>
								<td>${product.update_time }</td>
								<td>
									<a href="${ctx}/product/goModify.action?id=${product.id}">modify</a>
								</td>
								<td>
									<a href="javascript:deleteProduct(${product.id })">delete</a>
								</td>
								<td><a href="javaScript:toStatic(${product.id})">静态化</a></td>
							</tr>
							<!-- 用于弹出更改分类信息的div -->
							
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
	
	<script type="text/javascript">
		function toStatic(id){
			options = {
					url : "${ctx }/product/tostatic.action?product_id="+id,
					dataType : 'json',
					success : function(result){
						if(result){
							layer.msg('静态化成功');
						}else{
							layer.msg('操作失败');
						}
					}
			}
			$.ajax(options);
		}
	</script>
</html>