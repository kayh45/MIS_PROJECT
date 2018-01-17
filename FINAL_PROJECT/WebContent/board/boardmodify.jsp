<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.kayh.web.model.*" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.*, java.text.*"  %>
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";

int startPage= request.getAttribute("startPage") == null ? 1 : (Integer)request.getAttribute("startPage");
int endPage= request.getAttribute("endPage") == null ? 1 : (Integer)request.getAttribute("endPage");
int pageCnt= request.getAttribute("pageCnt") == null ? 1 : (Integer)request.getAttribute("pageCnt");
int cpage = request.getAttribute("cpage") == null ? 1 : (Integer)request.getAttribute("cpage");
int totalArticle = request.getAttribute("totalArticle") == null ? 1 : (Integer)request.getAttribute("totalArticle");
int virtual_no = request.getAttribute("virtual_no") == null ? 1 : (Integer)request.getAttribute("virtual_no");

String srch_type = request.getAttribute("srch_type") == null ? "" : (String)request.getAttribute("srch_type");
String srch_keyword = request.getParameter("srch_keyword")== null ? "" :  (String)request.getAttribute("srch_keyword");    

Board boardInfo = new Board();
boardInfo = (Board) request.getAttribute("boardInfo");

String boardNo = boardInfo.getBoardNo() == null ? "" : boardInfo.getBoardNo();
String boardSub = boardInfo.getBoardSub() == null ? "" : boardInfo.getBoardSub();
String boardCont = boardInfo.getBoardCont() == null ? "" : boardInfo.getBoardCont();
String boardDate = boardInfo.getBoardDate() == null ? "" : boardInfo.getBoardDate();
String boardWrt = boardInfo.getBoardWrt() == null ? "" : boardInfo.getBoardWrt();
String boardWrtNm = boardInfo.getBoardWrtNm() == null ? "" : boardInfo.getBoardWrtNm();

%>


<%

 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
 String today = formatter.format(new java.util.Date());
 
 
%>
<html>
<head>
<title>연회예약관리시스템 :: 게시판 수정</title>

<!-- BootStrap을 위한 부분  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap을 위한 부분  -->

<style>
	#lab {
		
		border-bottom : 1px solid #EAEAEA;
	}
	.fmcontent {
		margin : 20px 100px
	}
	
	@media (max-width: 480px){
		.fmcontent {
			margin : 20px
		}
	}
</style>
<script>
function modify_click(url_param) {
		
		if (validation()) {

			if (confirm('저장 하시겠습니까?')) {
				
				location.replace(url_param);

			}else{
				
				return false;
			} 

		}else{
			
			return false;
		}
}

	function validation() {
		

		if (document.fm.boardSub.value == '') {
			alert('제목을 입력하세요');
			return false;			
		}else if(document.fm.boardCont.value == ''){
			alert('내용을 입력하세요');
			return false;			
		}else{
			
			return true;
		}
		
	}

function list_click(url_param){
    
    location.replace(url_param);
    

}
</script>
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
<!-- 네비게이션 바 -->
<body>
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
	<!--  내용 -->
<div class = "fmcontent">
	<h3>오늘의 한마디 수정</h3>
<form method=post name = "fm" action="<%=contextName%>/board.do?act=EMPU" onsubmit="return modify_click(this);">
	<div class = "col-lg-6" style = "border : 1px solid #EAEAEA;">
	<input type = "hidden" class = "form-control" name = "boardNo" value = <%= boardNo %>>
	<input type = "hidden" class = "form-control"  name = "boardWrt" value = <%=request.getSession().getAttribute("userNo").toString() %>>
	이름: <input type = "text" class = "form-control"  name = "boardWrtNm" value = <%=request.getSession().getAttribute("userName").toString() %> readonly><br>
	날짜: <input type = "text" class = "form-control"  name = "boardDate" value = <%= today %> readonly><br>
	제목: <input type = "text" class = "form-control" name = "boardSub" value = <%= boardSub %>><br>
	내용: <input type = "text" class = "form-control" name = "boardCont" value = <%= boardCont %>><br>
	<div style = "margin : 20px" align = "center">
	<input class = "btn btn-primary" type = "submit" value = "수정">
	<a href = "javascript:list_click('<%=contextName%>/board.do?act=EMPL&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>')" class="btn btn-default"  type = "button" >
	취소
	</a>
	</div>
	</div>
</form>
</div>
</body>
</html>