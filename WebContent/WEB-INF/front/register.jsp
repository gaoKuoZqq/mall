<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx }/resources/thirdlib/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function addUser(){
	$.ajax({
	    cache: false,
	    type: "POST",
	    url:"${ctx}/user/add.shtml",
	    data:$('#addUserForm').serialize(),// 你的formid
	    async: true,
	    success: function(data) {
	    	if(data){
	    		alert("注册成功");
	    		window.location.href = "${ctx}/user/login.shtml";
	    	}else{
	    		alert("注册失败");
	    	}
	    }
	});
}
</script>
</head>
<body>
	<form id="addUserForm"><br/>
		用户名: <input type="text" name="username"/><br/>
		密码: <input type="text" name="password"/><br/>
		email: <input type="text" name="email"/><br/>
		phone: <input type="text" name="phone"/><br/>
		question: <input type="text" name="question"/><br/>
		answer: <input type="text" name="answer"/><br/>
		<input type="reset" value="重置"/>
		<input type="button" onclick="addUser()" value="提交"/>
	</form>
</body>
</html>