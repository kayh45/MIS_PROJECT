<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";

ArrayList<Board> boardList = new ArrayList<Board>();
boardList = (ArrayList<Board>) request.getAttribute("boardList");

int startPage = request.getAttribute("startPage") == null ? 1 : (Integer) request.getAttribute("startPage");
int endPage = request.getAttribute("endPage") == null ? 1 : (Integer) request.getAttribute("endPage");
int pageCnt = request.getAttribute("pageCnt") == null ? 1 : (Integer) request.getAttribute("pageCnt");
int cpage = request.getAttribute("cpage") == null ? 1 : (Integer) request.getAttribute("cpage");
int totalArticle = request.getAttribute("totalArticle") == null
		? 1
		: (Integer) request.getAttribute("totalArticle");
int virtual_no = request.getAttribute("virtual_no") == null
		? 1
		: (Integer) request.getAttribute("virtual_no");

String srch_type = request.getAttribute("srch_type") == null
		? ""
		: (String) request.getAttribute("srch_type");
String srch_keyword = request.getAttribute("srch_keyword") == null
		? ""
		: (String) request.getAttribute("srch_keyword");

String boardNo;
String boardSub;
String boardDate;
String boardWrt;
%>
<html>
<head>
<title>연회예약관리시스템 :: 게시판 목록</title>

<!-- BootStrap을 위한 부분  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.min.css" rel="stylesheet">
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
	<h3>오늘의 한마디</h3>
		<table class = "table">
			<tr>
			<th>No.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			</tr>
		<tbody>
<%

									if (boardList.size() > 0) {

										for (int i = 0; i < boardList.size(); i++) {
											Board board = boardList.get(i);

											boardNo = board.getBoardNo();
											boardSub = board.getBoardSub();
											boardDate = board.getBoardDate();
											boardWrt = board.getBoardWrt();
%>
								<tr>
									<td><%=boardNo%></td>		
									<td><b><a
											href="<%=contextName%>/board.do?act=EMPR&NO=<%=boardNo%>&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>">
												<%=boardSub%></a></b></td>														
									<td><%=boardWrt%></td>
									<td><%=boardDate%></td>
								</tr>
								<%
									}

									} else {
								%>
								<tr>
									<td colspan="6" align="center">자료가 존재하지 않습니다.</td>
								</tr>
								<%
									}
								%>
	</tbody>
		</table>
		</div>
		<div class="col-lg-offset-x">
			<ul class="pagination">
				<%
					if (cpage == 1) {
				%>
				<li class="disabled"><a
					href="<%=contextName%>/board.do?act=EMPL&page=1">&laquo;</a></li>
				<%
					} else {
				%>
				<li class="active"><a
					href="<%=contextName%>/board.do?act=EMPL&page=1">&laquo;</a></li>
				<%
					}
				%>


				<%
					for (int i = startPage; i <= endPage; i++) {
				%>
				<%
					if (cpage == i) {
				%>
				<li class="active"><a
					href="<%=contextName%>/board.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
				<%
					} else {
				%>
				<li><a href="<%=contextName%>/board.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<%
					}
				%>


				<%
					if (endPage < 11) {
				%>
				<li class="disabled"><a href="#">&raquo;</a></li>
				<%
					} else {
				%>
				<li><a
					href="<%=contextName%>/board.do?act=EMPL&page=<%=startPage - 1%>">&raquo;</a></li>
				<%
					}
				%>

			</ul>
			<div align = "center">
				<a class = "btn btn-primary"  href = "board/boardwrite.jsp">게시물작성</a>
			</div>		
		</div>
</body>
</html>