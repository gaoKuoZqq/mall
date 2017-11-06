<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>华为畅享6S</title>
		<link rel="stylesheet" type="text/css" href="../thirdlib/bootstrap.min.css" />
		<script src="../thirdlib/jquery-3.2.1.min.js"></script>
		<script src="../thirdlib/layer-v3.1.0/layer/layer.js"></script>
		<script src="../thirdlib/bootstrap.min.js"></script>
	</head>
<script>
    function openLogin(){
        layer.open({
            type:2,//（iframe层）
            title:'用户登录',
            area: ['350px', '300px'],
            offset: '50px',//只定义top坐标，水平保持居中
            content:"/mall/user/gologin.shtml"
        });
    }
    
    function openGoAddUser(){
        layer.open({
            type:2,//（iframe层）
            title:'用户登录',
            area: ['350px', '550px'],
            offset: '50px',//只定义top坐标，水平保持居中
            content:"/mall/user/goadd.shtml"
        });
    }

    function logOut(){
    	$.ajax(
    		"/mall/user/logout.shtml",
    	)
    	window.location.reload();
    }
    <script type="text/javascript">
	function goPage(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#goPageForm").submit();
	}
	
	function cutNumber(){
		var number = parseInt($("#quantityNow").val());
		if(number >= 2){
			$("#quantityNow").val(number - 1);
		}
	}
	
	function addNumber(){
		var number = parseInt($("#quantityNow").val());
		var stock = parseInt('${product.stock}');
		if(number < stock){
			$("#quantityNow").val(number + 1);
		}
	}
	
	function modifyNumber(){
		var stock = parseInt('${product.stock}');
		var number = parseInt($("#quantityNow").val());
		if(!isNaN(number) && number < stock && number > 0){
			$("#quantityNow").val(number);
		}else{
			 layer.msg("数量不合法");
			 $("#quantityNow").val(1);
		}
	}
	
	function addCart(){
		var product_id = '${product.id}';
		var number = $("#quantityNow").val();
		var options = {
		        url : "/mall/cart/add.shtml",
		        type : "post",
		        dataType : "json",
		        data : {
			        	"product_id" : product_id,
			        	"quantity" : number
			        	},
		        success : function(news) {
		            if (news) {
		    			layer.msg("商品已加入购物车");
		            }else{
		            	layer.msg("操作失败");
		            }
		        }
		};
		$.ajax(options);
	}
	

</script>
</script>
	<body>
		<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container" style="height: 30px; margin: 8px auto 0px;">
			<ol class="breadcrumb" style="margin-top: 7px;  margin: auto; float: left;">
				<li><a style="color:red">admin</a></li>
				<li><a href="javaScript:logOut()">注销</a></li>
			</ol>
			<div style="position:absolute;left:50%;margin-left:-200px">
				<form action="/mall/product/find.shtml" method="post">
					<input type="text" class="form-control" style="width:220px;float:left;"
					<input class="btn btn-primary" type="submit"
						style="float:left;margin-left:10px;" value="find"/>
				</form>
			</div>
			<ol class="breadcrumb" style="margin-top: 7px;  margin: auto; float: right;">
				<li><a href="/mall/home/gohome.shtml">首页</a></li>
				<li><a href="/mall/cart/gocart.shtml">购物车</a></li>
				<li><a href="/mall/order/goMyOrder.shtml">我的主页</a></li>
			</ol>
		</div>
	</nav>
	<div class="row" style="margin-top:30px;">
		<!-- 左侧留出1个格子 -->
		<div class="col-md-1 col-sm-1"></div>
		<!-- 展示区域 开始-->
		<div class="col-md-10 col-sm-10">
			<div class="row">
				<div class="col-md-4 col-sm-4">
					<img src="file:///E:/pic/${product.main_image }" class="img-thumbnail img-responsive" style="height:400px;">
				</div>
				<div class="col-md-1 col-sm-1"></div>
				<div class="col-md-5 col-sm-5">
					<h3>${product.name }<small><span
							class="label label-danger">HOT</span></small>
					</h3>
					<hr />
					<h4>${product.subtitle }</h4>
					<hr />
					<hr />
					<div style="height:65px;">
						<div style="float:left">
							<h4>
								<del>￥${product.price*1.75 }</del>
							</h4>
							<h3 style="color: red;">
								￥${product.price }<small>每件</small>
							</h3>
						</div>
						<div style="float:left;width:150px;height:60px;background-color:gray;margin-left:12%;padding-top:4px;margin-top:8px;">
							<div class="alert alert-info" role="alert" style="color:#9400D3;">
							限时折扣
							购买即享
							</div>
						</div>
					</div>
					<hr />
					<!-- 商品数量选择器 开始 -->
					<div class="row">
						<div class="col-md-5 col-sm-5">
							<div class="input-group">
								<span class="input-group-btn">
									<button onclick="cutNumber()" class="btn btn-default" type="button">-</button>
								</span>
								<input onblur="modifyNumber()" id="quantityNow" class="form-control" value="1" type="text">
								<span class="input-group-btn">
									<button onclick="addNumber()" class="btn btn-default" type="button">+</button>
								</span>
							</div>
							<p id="nowStock">&nbsp;&nbsp;库存:${product.stock } 件</p>
						</div>
					</div>
					<!-- 商品数量选择器 结束 -->
					<br/>
					<button onclick="addCart()" type="button" class="btn btn-primary btn-lg" style="width:150px;">加入购物车</button>
				</div>
				<div class="col-md-2 col-sm-2" style="height:360px;margin-top:40px;">
					<div style="background-color: gray;">
						<p style="color:white;">&nbsp;优购超市以顾客为宗旨</p>
						<p style="color:white;">&nbsp;为顾客提供优秀的产品</p>
					</div>
					<br/>
					<div class="alert alert-warning" role="alert">所有商品免运费</div>
					<div class="alert alert-success" role="alert">七天无理由退货</div>
					<div class="alert alert-info" role="alert">一月内免费更换</div>
					<div class="alert alert-danger" role="alert">终身优质服务</div>
				</div>
			</div>
		</div>
		<!-- 展示区域 结束-->
		<!-- 右侧留出1个格子 -->
		<div class="col-md-2 col-sm-2"></div>
	</div>
	<!-- 商品细节小图 -->
	<div class="row">
		<div class="col-md-1 col-sm-1"></div>
		<#list sub_images as sub_image>
		<div class="col-md-1 col-sm-1">
			<img src="file:///E:/pic/${sub_image} " class="img-circle"
			 style="display: block; width:90px; height: 90px; float: left;">
		</div>
		</#list>
	</div>
	<!-- 商品详情 -->
	<div class="row">
		<div class="col-md-1 col-sm-1"></div>
		<div class="col-md-10 col-sm-10">
			${product.detail }
		</div>
		<div class="col-md-1 col-sm-1"></div>
	</div>
	</body>

</html>