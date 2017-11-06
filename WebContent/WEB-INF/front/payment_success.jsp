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
		<link href="${ctx }/resources/home/css/admin.css" rel="stylesheet" type="text/css" />
		<link href="${ctx }/resources/payment_success/css/sustyle.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx }/resources/introduction/js/jquery.min.js"></script>
		<script type="text/javascript">
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
		</script>
</head>
<body>


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
						<div class="menu-hd"><a target="_blank" id="mc-menu-hd" href="javaScript:goCart()" target="_top"><i class="am-icon-shopping-cart  am-icon-fw"></i><span>购物车</span><strong id="J_MiniCartNum" class="h">0</strong></a></div>
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



<div class="take-delivery">
 <div class="status">
   <h2>您已成功付款</h2>
   <div class="successInfo">
     <ul>
       <li>付款金额<em>¥${payment }</em></li>
       <div class="user-info">
         <p>收货人：${shipping.receiver_name }</p>
         <p>联系电话：${shipping.receiver_mobile }</p>
         <p>收货地址：${shipping.receiver_province }${shipping.receiver_city }${shipping.receiver_district }${shipping.receiver_address }</p>
       </div>
             请认真核对您的收货信息，如有错误请联系客服
                               
     </ul>
     <div class="option">
       <span class="info">您不可以</span>
        <a href="" class="J_MakePoint">查看<span>已买到的宝贝</span></a>
        <a href="" class="J_MakePoint">查看<span>交易详情</span></a>
     </div>
    </div>
  </div>
</div>


<div class="footer" >
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


</body>
</html>