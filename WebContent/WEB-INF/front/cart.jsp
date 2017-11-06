<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
		<link href="${ctx }/resources/cart/css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/cart/css/cartstyle.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/cart/css/demo.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/cart/css/opstyle.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx }/resources/thirdlib/jquery-3.2.1.min.js"></script>
		<script type="text/javascript">
		function addNumber(id){
			var stock = $("#stock"+id).val();
			var number = parseInt($("#number"+id).val());
			var price = $("#price"+id).val();
			if(number < stock){
				number = number + 1;
				$("#number"+id).val(number);
				$("#productTotal"+id)[0].innerHTML=number*price;
				$.post(
					"${ctx}/cart/modify.shtml",
					{
						"id" : id,
						"quantity" : number,
					}
				)
				var obj=document.getElementsByName('checkboxItem');
				var sum = 0;
				for(var i=0; i<obj.length; i++){ 
					if(obj[i].checked){
						sum = parseFloat($("#productTotal"+obj[i].value)[0].innerHTML) + parseFloat(sum);
					}
				}
				$("#sum")[0].innerHTML=sum;
			}
		}
		function cutNumber(id){
			var number = parseInt($("#number"+id).val());
			var price = $("#price"+id).val();
			if(number > 1){
				number = number - 1;
				$("#number"+id).val(number);
				$("#productTotal"+id)[0].innerHTML=number*price;
				$.post(
						"${ctx}/cart/modify.shtml",
						{
							"id" : id,
							"quantity" : number,
						}
					)
				var obj=document.getElementsByName('checkboxItem');
				var sum = 0;
				for(var i=0; i<obj.length; i++){ 
					if(obj[i].checked){
						sum = parseFloat($("#productTotal"+obj[i].value)[0].innerHTML) + parseFloat(sum);
					}
				}
				$("#sum")[0].innerHTML=sum;
			}
		}
		
		function changeSelectCart(){
			var obj=document.getElementsByName('checkboxItem');
			var sum = 0;
			for(var i=0; i<obj.length; i++){ 
				if(obj[i].checked){
					sum = parseFloat($("#productTotal"+obj[i].value)[0].innerHTML) + parseFloat(sum);
				}
			}
			$("#sum")[0].innerHTML=sum;
		}
		
		function changeCheckedAll(){
			if($('#changeAllCheckbox').is(':checked')){
				$("[name='checkboxItem']").prop("checked",true);//全选 
			}else{
				$("[name='checkboxItem']").prop("checked",false);//取消全选 
			}
			var obj=document.getElementsByName('checkboxItem');
			var sum = 0;
			for(var i=0; i<obj.length; i++){ 
				if(obj[i].checked){
					sum = parseFloat($("#productTotal"+obj[i].value)[0].innerHTML) + parseFloat(sum);
				}
			}
			$("#sum")[0].innerHTML=sum;
		}
		
		function settlement(){
			var obj=document.getElementsByName('checkboxItem');
			var str = ' '; 
			for(var i=0; i<obj.length; i++){ 
				if(obj[i].checked) {
					str+=obj[i].value+' ';
				} 
			}
			$("#saveCart_ids").val(str);
			$("#settlementForm").submit();
		}
		
		function deleteCart(id){
			$.post(
				"${ctx}/cart/del.shtml",
				{"ids" : id},
				function(data){
					window.location.reload();
				}
			)
		}
		
		function deleteCheckedCart(){
			var obj=document.getElementsByName('checkboxItem');
			var str = ''; 
			for(var i=0; i<obj.length; i++){ 
				if(obj[i].checked) {
					str+=obj[i].value+' ';
				} 
			}
			$.post(
					"${ctx}/cart/del.shtml",
					{"ids" : str},
					function(data){
						window.location.reload();
					}
				)
		}
		
		function logOut(){
			$.ajax({
			    cache: false,
			    type: "POST",
			    url:"${ctx}/user/logout.shtml",
			    data:'${username}',
			    async: true,
			    success: function() {
			    	window.location.reload();
			    }
			});
		}
		</script>
</head>
	<body>
		<!-- 用于存储当前所选的cart_ids并提交到ordercontroller的表单 -->
		<form id="settlementForm" action="${ctx}/order/goadd.shtml" method="post">
			<input type="hidden" id="saveCart_ids" name="cart_ids"/>
		</form>
		<!--顶部导航条 -->
		<div class="am-container header">
			<ul class="message-l">
				<div class="topMessage">
					<div class="menu-hd">
						<c:if test="${empty username }">
						<a target="_blank" href="${ctx }/user/gologin.shtml" target="_top" class="h">亲，请登录</a>
						<a target="_blank" href="${ctx }/user/goadd.shtml" >免费注册</a>
						</c:if>
						<c:if test="${not empty username }">
						<a href="#" target="_top" class="h">欢迎 : ${username }</a>
						<a href="javaScript:logOut()" target="_top" class="h" style="color: gray">注销</a>
						</c:if>
					</div>
			</ul>
			<ul class="message-r">
				<div class="topMessage home">
					<div class="menu-hd"><a href="${ctx}/home/gohome.shtml" target="_top" class="h">商城首页</a></div>
				</div>
				<div class="topMessage my-shangcheng">
					<div class="menu-hd MyShangcheng"><a href="#" target="_top"><i class="am-icon-user am-icon-fw"></i>个人中心</a></div>
				</div>
				<div class="topMessage mini-cart">
					<div class="menu-hd"><a id="mc-menu-hd" href="#" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
				</div>
				<div class="topMessage favorite">
					<div class="menu-hd"><a href="#" target="_top"><i class="am-icon-heart am-icon-fw"></i><span>收藏夹</span></a></div>
			</ul>
			</div>

			<!--悬浮搜索框-->

			<div class="nav white">
				<div class="logo"><img src="../images/logo.png" /></div>
				<div class="logoBig">
					<li><img src="../images/logobig.png" /></li>
				</div>

				<div class="search-bar pr">
					<a name="index_none_header_sysc" href="#"></a>
					<form action="${ctx }/product/find.shtml" method="post"/>
							<input id="searchInput" type="text" name="product.name" placeholder="搜索" autocomplete="off">
							<input id="ai-topsearch" class="submit am-btn" value="搜索" index="1" type="submit">
						</form>
				</div>
			</div>

			<div class="clear"></div>

			<!--购物车 -->
			<div class="concent">
				<div id="cartTable">
					<div class="cart-table-th">
						<div class="wp">
							<div class="th th-chk">
								<div id="J_SelectAll1" class="select-all J_SelectAll">

								</div>
							</div>
							<div class="th th-item" width=400>
								<div class="td-inner">商品信息</div>
							</div>
							<div class="th th-price">
								<div class="td-inner">单价</div>
							</div>
							<div class="th th-amount">
								<div class="td-inner">数量</div>
							</div>
							<div class="th th-sum">
								<div class="td-inner">金额</div>
							</div>
							<div class="th th-op">
								<div class="td-inner">操作</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>

					<tr class="item-list">
						<div class="bundle  bundle-last ">
							<div class="bundle-main">
								<c:forEach items="${cartsList }" var="cart">
								<ul class="item-content clearfix">
									<li class="td td-chk">
										<div class="cart-checkbox ">
											<input onchange="changeSelectCart()" class="check" name="checkboxItem" value="${cart.id }" type="checkbox">
											<label for="J_CheckBox_170037950254"></label>
										</div>
									</li>
									<li class="td td-item" style="display: block;width:505px;">
										<div style="float:left;display: block;width:180px">
											<a href="#" target="_blank">
												<img src="/pic/${cart.product.main_image }" width=120 height=120></a>
										</div>
										<div style="float:left">
											<div>
												<a href="#" target="_blank" class="item-title J_MakePoint" data-point="tbcart.8.11">
													<c:if test="${fn:length(cart.product.name)>12 }">  
								                         ${fn:substring(cart.product.name, 0, 12)}...  
								                    </c:if>  
								                    <c:if test="${fn:length(cart.product.name)<=12 }">  
								                         ${cart.product.name} 
								                    </c:if>
												</a>
											</div>
										</div>
									</li>
									<li class="td td-price">
										<div class="item-price price-promo-promo">
											<div class="price-content">
												<div class="price-line">
													<em class="J_Price price-now" tabindex="0">${cart.product.price }</em>
													<input type="hidden" id="price${cart.id }" value="${cart.product.price }"/>
												</div>
											</div>
										</div>
									</li>
									<li class="td td-amount">
										<div class="amount-wrapper ">
											<div class="item-amount ">
												<div class="sl">
													<input class="min am-btn" onclick="cutNumber(${cart.id })" type="button" value="-" />
													<input class="text_box" id="number${cart.id }" type="button" value="${cart.quantity }" style="width:30px;" />
													<input class="add am-btn" onclick="addNumber(${cart.id })" type="button" value="+" />
													<br/>
													<a>库存:${cart.product.stock }</a>
													<input id="stock${cart.id }" type="hidden" value="${cart.product.stock }"/>
												</div>
											</div>
										</div>
									</li>
									<li class="td td-sum">
										<div class="td-inner">
											<em id="productTotal${cart.id }" tabindex="0" class="J_ItemSum number">${cart.quantity * cart.product.price}</em>
										</div>
									</li>
									<li class="td td-sum" style="float:right;">
										<div class="td-inner">
											<a href="javascript:deleteCart(${cart.id });" data-point-url="#">
                  							 删除&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  							</a>
										</div>
									</li>
								</ul>
								</c:forEach>
													
								
								
								
							</div>
						</div>
					</tr>
					

					
				</div>
				<div class="clear"></div>

				<div class="float-bar-wrapper">
					<div id="J_SelectAll2" class="select-all J_SelectAll">
						<div class="cart-checkbox">
							<input onchange="changeCheckedAll()" class="check-all check" id="changeAllCheckbox" name="select-all" value="true" type="checkbox">
							<label for="J_SelectAllCbx2"></label>
						</div>
						<span>全选</span>
					</div>
					<div class="operations">
						<a href="javaScript:deleteCheckedCart()" hidefocus="true" class="deleteAll">删除</a>
					</div>
					<div class="float-bar-right">
						<div class="amount-sum">
							<span class="txt">已选商品</span>
							<em id="J_SelectedItemsCount">0</em><span class="txt">件</span>
							<div class="arrow-box">
								<span class="selected-items-arrow"></span>
								<span class="arrow"></span>
							</div>
						</div>
						<div class="price-sum">
							<span class="txt">合计:</span>
							<strong class="price">¥<em id="sum">0.00</em></strong>
						</div>
						<div class="btn-area">
							<a href="javaScript:settlement()" id="J_Go" class="submit-btn submit-btn-disabled" aria-label="请注意如果没有选择宝贝，将无法结算">
								<span>结&nbsp;算</span></a>
						</div>
					</div>

				</div>

				<div class="footer">
					<div class="footer-hd">
						<p>
							<a href="#">恒望科技</a>
							<b>|</b>
							<a href="#">商城首页</a>
							<b>|</b>
							<a href="#">支付宝</a>
							<b>|</b>
							<a href="#">物流</a>
						</p>
					</div>
					<div class="footer-bd">
						<p>
							<a href="#">关于恒望</a>
							<a href="#">合作伙伴</a>
							<a href="#">联系我们</a>
							<a href="#">网站地图</a>
							<em>© 2015-2025 Hengwang.com 版权所有. 更多模板 <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></em>
						</p>
					</div>
				</div>

			</div>

		<!--引导 -->
		<div class="navCir">
			<li><a href="home.html"><i class="am-icon-home "></i>首页</a></li>
			<li><a href="sort.html"><i class="am-icon-list"></i>分类</a></li>
			<li class="active"><a href="shopcart.html"><i class="am-icon-shopping-basket"></i>购物车</a></li>	
			<li><a href="../person/index.html"><i class="am-icon-user"></i>我的</a></li>					
		</div>
	</body>
</html>