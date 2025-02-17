<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String ctx_Path = request.getContextPath();
	//	   /Trid
%>   
    
<!DOCTYPE html>
<html>
<head>

<style>
div#container {
    border: solid 0px red;
    width: 90%;
	height: 400px;
    margin: 10% auto;
}

div#container > input {
    border: none;
    border-bottom: 2px solid #ccc;
    padding-bottom: 5px;
    display: block;
    margin-bottom: 1%;
    outline: none;
}


button[type='button'] {
    text-align: center;
    width: 35%;
    height: 35px;
    background-color: white;
    border: solid 1px black;
    font-size: 10pt;
    margin-top: 3%;
}

button[type='button']:hover {
    text-align: center;
    width: 35%;
    height: 35px;
    background-color: #ecf2f8;
    border: solid 1px black;
    font-size: 10pt;
    margin-top: 3%;
}


div.message {
    font-size: 10pt;
    color: red;
    margin-bottom: 1%;
    display: block;
}

div#update{
	margin-bottom:4%;
}


</style>   
    

<meta charset="UTF-8">
<title>회원 전화번호 수정 페이지</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctx_Path%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctx_Path%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctx_Path%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<!-- jQueryUI CSS 및 JS -->
<link rel="stylesheet" type="text/css" href="<%= ctx_Path%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctx_Path%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 

<!-- 직접 만든 JS -->
<script type="text/javascript" src="<%= ctx_Path%>/js/member/updateMobile.js"></script>

</head>
<body>
<jsp:include page="../header.jsp"/>

    <form name="mobileUpdateFrm" action="">
		<div id="container">
			<div id="update">전화번호 수정</div>
			
			<input type="text" name="newMobile" id="newMobile" maxlength="15" class="requiredInfo" placeholder="새 전화번호" size="49%"/>
	        <input type="hidden" name="pkNum" id="pkNum" value="${sessionScope.loginuser.pk_member_no}"/>
	        <input type="text" style="display:none"/>
	        <div class="message"><i class="fa-solid fa-circle-info">&nbsp;전화번호를 입력해주십시오</i></div>
	        <div class="mobile_message"><i class="fa-solid fa-circle-info"></i></div>
	       
			<button type="button" onclick="goMobileUpdate()">전화번호 업데이트하기</button>
		</div>
	</form>

</body>
</html>