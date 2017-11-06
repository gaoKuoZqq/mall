<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
		<link href="${ctx }/resources/order/css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/order/css/demo.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/order/css/cartstyle.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/order/css/jsstyle.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx }/resources/order/js/address.js"></script>
		<script type="text/javascript" src="${ctx}/resources/thirdlib/layer-v3.1.0/layer/layer.js"></script>
		<script type="text/javascript">
		function findCity(){
			var parent_id = $("#provinceSelect").val();
			$.post(
				"${ctx}/location/findcity.shtml",
				{"parent_id" : parent_id},
				function(data){
					$("option#temporaryCity").remove();
					for(var a in data){
	            		$("#cityNoSelected").after("<option id='temporaryCity' value='"+data[a].id+"'>"+data[a].name+"</option>")
	            	 }
				},
				"json"
			)
		}
		
		function findArea(){
			var parent_id = $("#citySelect").val();
			$.post(
				"${ctx}/location/findarea.shtml",
				{"parent_id" : parent_id},
				function(data){
					$("option#temporaryArea").remove();
					for(var a in data){
	            		$("#areaNoSelected").after("<option id='temporaryArea' value='"+data[a].id+"'>"+data[a].name+"</option>")
	            	 }
				},
				"json"
			)
		}
		
		function addShipping(){
			var receiver_name = $("#receiver_name").val();
			var receiver_mobile = $("#receiver_mobile").val();
			var receiver_province = $("#provinceSelect").find("option:selected").text();
			var receiver_city = $("#citySelect").find("option:selected").text();
			var receiver_district = $("#areaSelect").find("option:selected").text();
			var receiver_address = $("#receiver_address").val();
			$.post(
				"${ctx}/shipping/add.shtml",
				{
					"receiver_name" : receiver_name,
					"receiver_mobile" : receiver_mobile,
					"receiver_province" : receiver_province,
					"receiver_city" : receiver_city,
					"receiver_district" : receiver_district,
					"receiver_address" : receiver_address,
				},
				function(data){
					if(data){
						window.location.reload();
					}else{
						alert("保存失败");
					}
				},
				"json"
			)
		}
		
		function deleteShipping(shipping_id){
			$.post(
					"${ctx}/shipping/del.shtml",
					{
						"shipping_id" : shipping_id
					},
					function(data){
						if(data){
							window.location.reload();
						}else{
							alert("操作失败");
						}
					},
					"json"
				)
		}
		
		function checkAddress(shipping_id){
			$("[name='defaultAddress']").prop("checked",false);//取消全部已选
			$("#defaultAddress"+shipping_id).prop("checked",true);
		}
		
		function modifyReceiverInfo(shipping_id){
			layer.open(
					{
						title: '修改收货信息',
					    type: 1,
					    content: $("#modifyReceiverDiv"+shipping_id) ,//这里content是一个DOM，这个元素要放在body根节点下
					}
			);
		}
		
		function modifyShipping(shipping_id){
			var receiver_name = $("#receiver_nameM").val();
			var receiver_mobile = $("#receiver_mobileM").val();
			var receiver_address = $("#receiver_addressM").val();
			$.post(
				"${ctx}/shipping/modify.shtml",
				{
					"id" : shipping_id,
					"receiver_name" : receiver_name,
					"receiver_mobile" : receiver_mobile,
					"receiver_address" : receiver_address,
				},
				function(data){
					if(data){
						window.location.reload();
					}else{
						alert("保存失败");
					}
				},
				"json"
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
		
		function goCart(){
			var username = '${username}';
			if(username == null || username == ""){
				location.href="${ctx}/user/gologin.shtml";
			}else{
				location.href="${ctx}/cart/gocart.shtml?username="+username+"";
			}
		}
		
		$(document).ready(function(){
			var shipping_id = $("input:checked").val();
			var receiverLocation = $("#displayReceiver"+shipping_id).html();
			var receiverInfo = $("#displayReceiverInfo"+shipping_id).html();
			$("#finallyLocation").html(receiverLocation);
			$("#finallyInfo").html(receiverInfo);
		})
		
		function commitOrder(){
			var shipping_id = $("input[name=defaultAddress]:checked").val();
			$("#saveAddOrderShipping_id").val(shipping_id);
			$("#addOrderForm").submit();
		}
		</script>
</head>
	<body>
		<!-- 用于提交订单的form -->
		<form id="addOrderForm" action="${ctx}/order/add.shtml" method="post">
			<input name="shipping_id" type="hidden" id="saveAddOrderShipping_id"/>
			<input name="cart_ids" type="hidden" id="saveAddOrderCart_ids" value="${cart_ids}"/>
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
					<div class="menu-hd"><a id="mc-menu-hd" href="javaScript:goCart()" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
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
			<div class="concent">
				<!--地址 -->
				<div class="paycont">
					<div class="address">
						<h3>确认收货地址 </h3>
						<div class="control">
							<div class="tc-btn createAddr theme-login am-btn am-btn-danger">使用新地址</div>
						</div>
						<div class="clear"></div>
						<p>最多三条收货信息</p>
						<ul>
							<div class="per-border"></div>
							<li class="user-addresslist defaultAddr" style="width:1000px;">
								<c:forEach items="${shippingsList }" var="shipping" varStatus="status">
								<c:if test="${status.first }">
								<div class="address-left">
									<div class="user DefaultAddr">
										<input value="${shipping.id }" id="defaultAddress${shipping.id }" checked="checked" type="checkbox" name="defaultAddress" onchange="checkAddress(${shipping.id })"/> 
										<span class="buy-address-detail">   
                   						<span class="buy-user">${shipping.receiver_name } </span>
										<span class="buy-phone">${shipping.receiver_mobile }</span>
										</span>
									</div>
									<div id="displayReceiverInfo${shipping.id }" style="display: none;">
										<span class="buy-address-detail">   
                   						<span class="buy-user">${shipping.receiver_name } </span>
										<span class="buy-phone">${shipping.receiver_mobile }</span>
										</span>
									</div>
									<div class="default-address DefaultAddr" id="displayReceiver${shipping.id }">
										<span class="buy-line-title buy-line-title-type">收货地址：</span>
										<span class="buy--address-detail"/>
								  		<span class="province">${shipping.receiver_province }</span>
										<span class="city">${shipping.receiver_city }</span>
										<span class="dist">${shipping.receiver_district }</span>
										<span class="street">${shipping.receiver_address }</span>
									</div>
									<div class="address-right">
										<a href="../person/address.html">
										<span class="am-icon-angle-right am-icon-lg"></span></a>
									</div>
									<div class="clear"></div>
									<div class="new-addr-btn">
										<span class="new-addr-bar hidden">|</span>
										<a href="javaScript:modifyReceiverInfo(${shipping.id })">编辑</a>
										<span class="new-addr-bar">|</span>
										<a href="javascript:deleteShipping(${shipping.id });">删除</a>
									</div>
								</div>
								<div id="modifyReceiverDiv${shipping.id }" style="display:none;">
									<form class="am-form am-form-horizontal">
										<div class="am-form-group">
											<label for="user-name" class="am-form-label">收货人</label>
											<div class="am-form-content">
												<input value="${shipping.receiver_name }" type="text" placeholder="收货人" id="receiver_nameM">
											</div>
										</div>
				
										<div class="am-form-group">
											<label for="user-phone" class="am-form-label">手机号码</label>
											<div class="am-form-content">
												<input value="${shipping.receiver_mobile }" id="receiver_mobileM" placeholder="手机号必填" type="email">
											</div>
										</div>
				
										<div class="am-form-group">
											<label for="user-phone" class="am-form-label">
												所在地 : 
											</label>
											<span style="display: block; margin-top: 8px;">&nbsp;&nbsp;&nbsp;${shipping.receiver_province }&nbsp;${shipping.receiver_city }
												&nbsp;${shipping.receiver_district }</span>
										</div>
				
										<div class="am-form-group">
											<label for="user-intro" class="am-form-label">详细地址</label>
											<div class="am-form-content">
												<textarea class="" rows="3" id="receiver_addressM" >${shipping.receiver_address }</textarea>
												<small>50字以内写出你的详细地址...</small>
											</div>
										</div>
				
										<div class="am-form-group theme-poptit">
											<div class="am-u-sm-9 am-u-sm-push-3">
												<div class="am-btn am-btn-danger"><a href="javaScript:modifyShipping(${shipping.id })">保存</a></div>
											</div>
										</div>
									</form>
								</div>
								</c:if>
								
								<c:if test="${status.count>1 }">
								<div class="address-left">
									<div class="user DefaultAddr">
										<input id="defaultAddress${shipping.id }" type="checkbox" name="defaultAddress" onchange="checkAddress(${shipping.id })"/> 
										<span class="buy-address-detail">   
                   						<span class="buy-user">${shipping.receiver_name } </span>
										<span class="buy-phone">${shipping.receiver_mobile }</span>
										</span>
									</div>
									<div class="default-address DefaultAddr">
										<span class="buy-line-title buy-line-title-type">收货地址：</span>
										<span class="buy--address-detail"/>
								  		<span class="province">${shipping.receiver_province }</span>
										<span class="city">${shipping.receiver_city }</span>
										<span class="dist">${shipping.receiver_district }</span>
										<span class="street">${shipping.receiver_address }</span>
									</div>
									<div class="address-right">
										<a href="../person/address.html">
										<span class="am-icon-angle-right am-icon-lg"></span></a>
									</div>
									<div class="clear"></div>
									<div class="new-addr-btn">
										<span class="new-addr-bar hidden">|</span>
										<a href="javaScript:modifyReceiverInfo(${shipping.id })">编辑</a>
										<span class="new-addr-bar">|</span>
										<a href="javascript:deleteShipping(${shipping.id });">删除</a>
									</div>
								</div>
								<div id="modifyReceiverDiv${shipping.id }" style="display:none;">
									<form class="am-form am-form-horizontal">
										<div class="am-form-group">
											<label for="user-name" class="am-form-label">收货人</label>
											<div class="am-form-content">
												<input value="${shipping.receiver_name }" type="text" placeholder="收货人" id="receiver_nameM">
											</div>
										</div>
				
										<div class="am-form-group">
											<label for="user-phone" class="am-form-label">手机号码</label>
											<div class="am-form-content">
												<input value="${shipping.receiver_mobile }" id="receiver_mobileM" placeholder="手机号必填" type="email">
											</div>
										</div>
				
										<div class="am-form-group">
											<label for="user-phone" class="am-form-label">
												所在地 : 
											</label>
											<span style="display: block; margin-top: 8px;">&nbsp;&nbsp;&nbsp;${shipping.receiver_province }&nbsp;${shipping.receiver_city }
												&nbsp;${shipping.receiver_district }</span>
										</div>
				
										<div class="am-form-group">
											<label for="user-intro" class="am-form-label">详细地址</label>
											<div class="am-form-content">
												<textarea class="" rows="3" id="receiver_addressM" >${shipping.receiver_address }</textarea>
												<small>50字以内写出你的详细地址...</small>
											</div>
										</div>
				
										<div class="am-form-group theme-poptit">
											<div class="am-u-sm-9 am-u-sm-push-3">
												<div class="am-btn am-btn-danger"><a href="javaScript:modifyShipping(${shipping.id })">保存</a></div>
											</div>
										</div>
									</form>
								</div>
								</c:if>
								</c:forEach>
							</li>
							<div class="per-border"></div>
						</ul>
						<div class="clear"></div>
					</div>
					<!--物流 -->
					<div class="logistics">
						<h3>选择物流方式</h3>
						<ul class="op_express_delivery_hot">
							<li data-value="yuantong" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -468px"></i>圆通<span></span></li>
							<li data-value="shentong" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -1008px"></i>申通<span></span></li>
							<li data-value="yunda" class="OP_LOG_BTN  "><i class="c-gap-right" style="background-position:0px -576px"></i>韵达<span></span></li>
							<li data-value="zhongtong" class="OP_LOG_BTN op_express_delivery_hot_last "><i class="c-gap-right" style="background-position:0px -324px"></i>中通<span></span></li>
							<li data-value="shunfeng" class="OP_LOG_BTN  op_express_delivery_hot_bottom"><i class="c-gap-right" style="background-position:0px -180px"></i>顺丰<span></span></li>
						</ul>
					</div>
					<div class="clear"></div>

					<!--支付方式-->
					<div class="logistics">
						<h3>选择支付方式</h3>
						<ul class="pay-list">
							<li class="pay card"><img src="../images/wangyin.jpg" />银联<span></span></li>
							<li class="pay qq"><img src="../images/weizhifu.jpg" />微信<span></span></li>
							<li class="pay taobao"><img src="../images/zhifubao.jpg" />支付宝<span></span></li>
						</ul>
					</div>
					<div class="clear"></div>

					<!--订单 -->
					<div class="concent">
						<div id="payTable">
							<h3>确认订单信息</h3>
							<div class="cart-table-th">
								<div class="wp">

									<div class="th th-item">
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
									<div class="th th-oplist">
										<div class="td-inner">配送方式</div>
									</div>

								</div>
							</div>
							<div class="clear"></div>

							<tr class="item-list">
								<div class="bundle  bundle-last">

									<div class="bundle-main">
										<c:forEach items="${cartsList }" var="cart">
											<ul class="item-content clearfix">
												<li class="td td-chk">
													<div class="cart-checkbox ">
														<label for="J_CheckBox_170037950254"></label>
													</div>
												</li>
												<li class="td td-item" style="display: block;width:490px;">
													<div style="float:left;display: block;width:180px">
														<a href="#" target="_blank">
															<img src="/pic/${cart.product.main_image }" width=120 height=120></a>
													</div>
													<div style="float:left">
														<div>
															<a href="#" target="_blank" class="item-title J_MakePoint" data-point="tbcart.8.11">${cart.product.name}</a>
														</div>
													</div>
												</li>
												<li class="td td-price">
													<div class="item-price price-promo-promo">
														<div class="price-content">
															<div class="price-line"><br/>
																<em class="J_Price price-now" tabindex="0">${cart.product.price }</em>
																<input type="hidden" id="price${cart.id }" value="${cart.product.price }"/>
															</div>
														</div>
													</div>
												</li>
												<li class="td td-amount">
													<div class="amount-wrapper ">
														<div class="item-amount ">
															<div class="sl"><br/>
																<input class="text_box" id="number${cart.id }" type="button" value="${cart.quantity }" style="width:30px;" />
															</div>
														</div>
													</div>
												</li>
												<li class="td td-sum">
													<div class="td-inner"><br/>
														<em id="productTotal${cart.id }" tabindex="0" class="J_ItemSum number">${cart.quantity * cart.product.price}</em>
													</div>
												</li>
												<li class="td td-sum" style="float:right;">
													<div class="td-inner">
														<a data-point-url="#">
			                  							 删除&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                  							</a>
													</div>
												</li>
											</ul>
											</c:forEach>
										<div class="clear"></div>

									</div>
							</tr>
							<div class="clear"></div>
							</div>
							</div>
							<div class="clear"></div>
							<div class="pay-total">
						<!--留言-->
							<div class="order-extra">
								<div class="order-user-info">
									<div id="holyshit257" class="memo">
										<label>买家留言：</label>
										<input type="text" title="选填,对本次交易的说明（建议填写已经和卖家达成一致的说明）" placeholder="选填,建议填写和卖家达成一致的说明" class="memo-input J_MakePoint c2c-text-default memo-close">
										<div class="msg hidden J-msg">
											<p class="error">最多输入500个字符</p>
										</div>
									</div>
								</div>

							</div>
							<div class="clear"></div>
							</div>
							<!--含运费小计 -->
							<div class="buy-point-discharge ">
								<p class="price g_price ">
									合计  <span>¥</span><em class="pay-sum">${payment }</em>
								</p>
							</div>

							<!--信息 -->
							<div class="order-go clearfix">
								<div class="pay-confirm clearfix">
									<div class="box">
										<div tabindex="0" id="holyshit267" class="realPay"><em class="t">实付款：</em>
											<span class="price g_price ">
                                    <span>¥</span> <em class="style-large-bold-red " id="J_ActualFee">${payment }</em>
											</span>
										</div>

										<div id="holyshit268" class="pay-address">

											<p id="finallyLocation" class="buy-footer-address">
												<span class="buy-line-title buy-line-title-type">寄送至：</span>
												<span class="buy--address-detail">
								   <span class="province">湖北</span>省
												<span class="city">武汉</span>市
												<span class="dist">洪山</span>区
												<span class="street">雄楚大道666号(中南财经政法大学)</span>
												</span>
												</span>
											</p>
											<p id="finallyInfo" class="buy-footer-address">
												<span class="buy-line-title">收货人：</span>
												<span class="buy-address-detail">   
                                         <span class="buy-user">艾迪 </span>
												<span class="buy-phone">15871145629</span>
												</span>
											</p>
										</div>
									</div>

									<div id="holyshit269" class="submitOrder">
										<div class="go-btn-wrap">
											<a id="J_Go" href="javaScript:commitOrder()" class="btn-go" tabindex="0" title="点击此按钮，提交订单">提交订单</a>
										</div>
									</div>
									<div class="clear"></div>
								</div>
							</div>
						</div>

						<div class="clear"></div>
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
			<div class="theme-popover-mask"></div>
			<div class="theme-popover">

				<!--标题 -->
				<div class="am-cf am-padding">
					<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">新增地址</strong> / <small>Add address</small></div>
				</div>
				<hr/>

				<div class="am-u-md-12">
					<form class="am-form am-form-horizontal">

						<div class="am-form-group">
							<label for="user-name" class="am-form-label">收货人</label>
							<div class="am-form-content">
								<input type="text" placeholder="收货人" id="receiver_name">
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-phone" class="am-form-label">手机号码</label>
							<div class="am-form-content">
								<input id="receiver_mobile" placeholder="手机号必填" type="email">
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-phone" class="am-form-label">所在地</label>
							<div class="am-form-content address">
								<select onchange="findCity()" id="provinceSelect">
								<option selected="selected" id="provinceNoSelected" value="noSelected">未选择</option>
								<c:forEach items="${provinceslist }" var="province">
									<option value="${province.id }">${province.name }</option>
								</c:forEach>
								</select>
								<select  onchange="findArea()" id="citySelect">
									<option id="cityNoSelected" value="noSelected">未选择</option>
								</select>
								<select id="areaSelect">
									<option id="areaNoSelected" value="noSelected">未选择</option>
								</select>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-intro" class="am-form-label">详细地址</label>
							<div class="am-form-content">
								<textarea class="" rows="3" id="receiver_address" placeholder="输入详细地址"></textarea>
								<small>50字以内写出你的详细地址...</small>
							</div>
						</div>

						<div class="am-form-group theme-poptit">
							<div class="am-u-sm-9 am-u-sm-push-3">
								<div class="am-btn am-btn-danger"><a href="javaScript:addShipping()">保存</a></div>
								<div class="am-btn am-btn-danger close">取消</div>
							</div>
						</div>
					</form>
				</div>

			</div>

			<div class="clear"></div>
	</body>
</html>