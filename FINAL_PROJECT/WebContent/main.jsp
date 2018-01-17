<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="com.kayh.web.model.*" %>
	<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>연회예약관리시스템 :: 메인페이지</title>
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";

ArrayList<Board> boardList = new ArrayList<Board>();
boardList = (ArrayList<Board>) request.getAttribute("boardList");

String boardNo;
String boardWrtNm;
String boardCont;

%>
<!-- BootStrap을 위한 부분  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap을 위한 부분  -->

<script language = "javascript">

function f_logout() {
	var ok = confirm("정말 로그아웃 하시겠습니까?\n (로그인 페이지로 돌아감)");
	if(ok) 	
		location.href="<%=contextName%>/login.do?act=LOGOUT";
	else;
}

function authToList() {
	
	if(<%= request.getSession().getAttribute("userAuth").toString() %> == 1){
		location.href="<%=contextName%>/emp.do?act=EMPL";
	}
	else alert("접근 권한이 없습니다.");
}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<div id="nav" style="background-color: black">
		<div class="core" >
			<div class="left">
					<span class = "home" ><strong><a href="<%=contextName%>/login.do?act=MAIN">연회예약관리시스템</a></strong></span>
				<ul class =" navbar">
				<li>
					<button class = noeff  onclick = "location.href= 'banq/banqwrite.jsp'">
						<span class = "glyphicon glyphicon-pencil"></span>
						<span class="text">예약등록</span>
					</button>
				 </li>
				<li>
					<button class = noeff  onclick = "location.href='<%=contextName%>/Resv.do?act=EMPL'" aria-hidden = "true">
						<span class = "glyphicon glyphicon-search" ></span>
						<span class="text">예약조회</span>
					</button>
				</li>
				<li>
					<button class = noeff  onclick = "authToList();">
						<span class = "glyphicon glyphicon-sunglasses"></span>
						<span class="text">사원관리</span>
					</button>
				</li>
				</ul>
			</div>
			<div class="right" style = "margin : 5px 0">
			<span class = "text">
			<strong><%=request.getSession().getAttribute("userName").toString() %></strong>님 반갑습니다.  &nbsp;
			</span>
				<div class = "item">
				<input class="btn btn-primary btn-md" type="button" value = "로그아웃" onclick ="f_logout()">
				</div>
			</div>
		</div>
	</div>
	<!-- 내용 --><br>
		<div class = "container">
			<div class = "row">
				<h5><a href = "board.do?act=EMPL">오늘의 한마디</a></h5>
			</div>
			<img class = "imgsize" src = "<%= contextName %>/IMG/BNQROOM.jpg" >
			<h4>연회예약관리시스템입니다.</h4>
			
		</div>
</body>
</html>