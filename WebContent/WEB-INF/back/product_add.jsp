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
<script type="text/javascript" src="${ctx}/resources/thirdlib/layer-v3.1.0/layer/layer.js"></script>
<script charset="utf-8" src="${ctx}/resources/thirdlib/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx}/resources/thirdlib/kindeditor/lang/zh_CN.js"></script>
<!-- <script>
        KindEditor.ready(function(K) {
        	KindEditor.options.filterMode = false;
                window.editor = K.create('#editor_id');
                
                var options = {
    			        cssPath : '/css/index.css',
    			        filterMode : true
    			};
    			var editor = K.create('textarea[name="content"]', options);
    			// 取得HTML内容
    			html = editor.html();

    			// 同步数据后可以直接取得textarea的value
    			editor.sync();
    			html = document.getElementById('editor_id').value; // 原生API
    			html = K('#editor_id').val(); // KindEditor Node API
    			html = $('#editor_id').val(); // jQuery
    			console.log(html);
        });
        
</script> -->


	<script type="text/javascript">
		function addProduct(){
			var name = $("#name").val();
			var subtitle = $("#subtitle").val();
			var stock = $("#stock").val();
			var price = $("#price").val();
			var status = $("#status").val();
			var main_image = $("#main_image").val();
			var sub_images = $("#sub_images").val();
			var detail = $("#detail").val();
			var category_id = $("#category_id").val();
			console.log(name);
			console.log(subtitle);
			console.log(stock);
			console.log(price);
			console.log(status);
			console.log(main_image);
			console.log(sub_images);
			console.log(detail);
			console.log(category_id);
			if(price=="" || stock=="" || name==""){
				alert("信息不完整");
				return;
			}
			$.post(
		             "${ctx}/product/add.action", //url
		             {
		            	 "name" : name,
		            	 "subtitle" : subtitle,
		            	 "stock" : stock,
		            	 "price" : price,
		            	 "status" : status,
		            	 "main_image" : main_image,
		            	 "sub_images" : sub_images,
		            	 "detail" : detail,
		            	 "category_id" : category_id,
		             },
		             function(data) {
		            	 if(data){
		            		 layer.msg('添加成功');
		            	 }else{
		            		 layer.msg('添加失败');
		            	 }
		             },
		             "json" //type
		      ); 
		}
		
		function uploadPic(){
			//定义参数
	        var options = {
	            url:"${ctx}/upload/uploadPic.action",
	            dataType:"json",
	            type:"post",
	            success: function(data) {
	                $("#imgId").attr("src","/pic/" + data.fileName);
	                $("#main_image").val(data.fileName);
	            }
	        };
	         $("#addForm").ajaxSubmit(options);
		}
		
		function findCategory(){
			var id = $("#rootCategory").val();
			$.post(
		             "${ctx}/category/findCategoryByParent_id.action", //url
		             {"parent_id" : id},
		             function(data) {
		            	 $("option#temporary").remove();
		            	 for(var a in data){
		            		 $("#beforeOption").after("<option id='temporary' value='"+data[a].id+"'>"+data[a].name+"</option>")
		            	 }
		             },
		             "json" //type
		      ); 
		}
		$(document).ready(function(){
			findCategory()
		})
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
							<a href="${ctx}/product/find.action">商品列表</a>
						</li>
						<li role="presentation" class="active">
							<a href="${ctx}/product/goadd.action">添加商品</a>
						</li>
					</ul>
					<!--
                    	描述：功能区上部小导航,结束
                    	功能区,开始
                    -->
					<form id="addForm" action="${ctx }/product/add.action" method="post" enctype="multipart/form-data">
						<div class="form-group" style="margin-top:10px;"/>
							商品名称
							<input id="name" id="name" class="form-control" placeholder="例 : 波音404"/>
							根分类: <select id="rootCategory" onchange="findCategory()">
								<c:forEach items="${rootCategoriesList}" var="category">
									<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
							二级分类:<select id="category_id">
								<option id="beforeOption" value="nothing">请选择</option>
							</select><br/>
							商品副标题
							<input id="subtitle" class="form-control"/>
							库存数量
							<input id="stock" class="form-control"/>
							价格
							<input id="price" class="form-control"/>
							状态
							<select id="status" class="form-control"style="margin-bottom:10px;">
								<option value="1">在售</option>
								<option value="2">下架</option>
							</select>
							<!-- kindEditor -->
							 <div  class="form-group">
						  	 <label >产品主图</label>
						  	 <div>
					           <img alt="" id="imgId" src="" width=100 height=100>
					           <input type="hidden" name="main_image" id="main_image"/>
					           <input type="file" name="pictureFile" onchange="uploadPic();"/>
			      			 </div>
							 </div>
							 <div class="form-group">
							  	<label>商品图片</label>
							  	 <a href="javascript:void(0)" class="picFileUpload" id="picFileUpload">上传图片</a>
				                 <input type="hidden" name="sub_images" id="sub_images"/>
				                 <div id="J_imageView"></div>
							 </div>
							 <div class="form-group">
							  	<label>商品描述</label>
							  	 <textarea style="width:900px;height:300px;visibility:hidden;" name="detail" id="detail"></textarea>
							 </div>
						</div>
						<input type="reset" value="重置" class="btn btn-danger btn-sm btn-block"/>
						<input type="button" value="添加" class="btn btn-success btn-sm btn-block" onclick="addProduct()"/>
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
<script type="text/javascript">
var myKindEditor ;
KindEditor.ready(function(K) {
	var kingEditorParams = {
			//指定上传文件参数名称
			filePostName  : "pictureFile",
			//指定上传文件请求的url。
			uploadJson : '${ctx}/upload/pic.action',
			//上传类型，分别为image、flash、media、file
			dir : "image",
			afterBlur:function(){this.sync();}
	}
	var editor = K.editor(kingEditorParams);
	//多图片上传
	K('#picFileUpload').click(function() {
		editor.loadPlugin('multiimage', function() {
			editor.plugin.multiImageDialog({
				clickFn : function(urlList) {
					console.log(urlList);
					var div = K('#J_imageView');
					var imgArray = [];
					div.html('');
					K.each(urlList, function(i, data) {
						imgArray.push(data.url);
						div.append('<img src="' + data.url + '" width="80" height="50">');
					});
					$("#sub_images").val(imgArray.join(","));
					editor.hideDialog();
				}
			});
		});
	});
	
	//富文本编辑器
	myKindEditor = KindEditor.create('#addForm[name=detail]', kingEditorParams);
});
</script>