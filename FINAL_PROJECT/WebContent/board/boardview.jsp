<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.*, java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String CONTEXT_PATH = request.getContextPath();
	String contextName = request.getContextPath();
	String jspBasePath = contextName + "/";
	String imgPath = jspBasePath + "images";

	int startPage = request.getAttribute("startPage") == null ? 1 : (Integer) request.getAttribute("startPage");
	int endPage = request.getAttribute("endPage") == null ? 1 : (Integer) request.getAttribute("endPage");
	int pageCnt = request.getAttribute("pageCnt") == null ? 1 : (Integer) request.getAttribute("pageCnt");
	int cpage = request.getAttribute("cpage") == null ? 1 : (Integer) request.getAttribute("cpage");
	int totalArticle = request.getAttribute("totalArticle") == null ? 1
			: (Integer) request.getAttribute("totalArticle");
	int virtual_no = request.getAttribute("virtual_no") == null ? 1
			: (Integer) request.getAttribute("virtual_no");

	String srch_type = request.getAttribute("srch_type") == null ? ""
			: (String) request.getAttribute("srch_type");
	String srch_keyword = request.getParameter("srch_keyword") == null ? ""
			: (String) request.getAttribute("srch_keyword");

	Board boardInfo = new Board();
	boardInfo = (Board) request.getAttribute("boardInfo");

	String boardNo = boardInfo.getBoardNo() == null ? "" : boardInfo.getBoardNo();
	String boardSub = boardInfo.getBoardSub() == null ? "" : boardInfo.getBoardSub();
	String boardCont = boardInfo.getBoardCont() == null ? "" : boardInfo.getBoardCont();
	String boardDate = boardInfo.getBoardDate() == null ? "" : boardInfo.getBoardDate();
	String boardWrt = boardInfo.getBoardWrt() == null ? "" : boardInfo.getBoardWrt();
	String boardWrtNm = boardInfo.getBoardWrtNm() == null ? "" : boardInfo.getBoardWrtNm();
	
	System.out.println(boardWrt);
	System.out.println(request.getSession().getAttribute("userNo").toString());
%>
<html>
<head>
<title>연회예약관리시스템 :: 게시판</title>

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
	border-bottom: 1px solid #EAEAEA;
}

.tbcontent {
	margin: 30px 200px
}

@media ( max-width : 800px) {
	.tbcontent {
		margin: 20px 20px
	}
}

div.row {
	text-align: center;
	border: 1px solid #EAEAEA;
}

#cont {
	background-color: #F6F6F6;
}
</style>
<script>
    function f_logout()
    {
    	location.href="<%=contextName%>/login.do?act=LOGOUT";
    }
     var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-23019901-1']);
      _gaq.push(['_setDomainName', "bootswatch.com"]);
        _gaq.push(['_setAllowLinker', true]);
      _gaq.push(['_trackPageview']);

     (function() {
       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
     })();
     
    

    </script>
    
<script type="text/javascript">
function delete_click(url_param){
    
	 if (<%= boardWrt %> == <%=request.getSession().getAttribute("userNo").toString()%>) {
		    if(confirm('정말로 삭제하시겠습니까?')){
		        location.replace(url_param);
		    }
		 }else{
			 alert("권한이 없습니다.");
		 }

    
}

function update_click(url_param){
	
	 if (<%= boardWrt %> == <%=request.getSession().getAttribute("userNo").toString()%>) {
        location.replace(url_param);
	 }else{
		 alert("권한이 없습니다.");
	 }
}

function list_click(url_param){
    
    location.replace(url_param);
}
</script>
<script>
function f_logout()
{
	location.href="<%=contextName%>/login.do?act=LOGOUT";
}
 var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-23019901-1']);
  _gaq.push(['_setDomainName', "bootswatch.com"]);
    _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);

 (function() {
   var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
   ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
 })();
 
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
		<div class="core">
			<div class="left">
				<span class="home"><strong><a
						href="<%=contextName%>/login.do?act=MAIN">연회예약관리시스템</a></strong></span>
				<ul class=" navbar">
					<li>
						<button class=noeff onclick="location.href= '<%=contextName%>/banq/banqwrite.jsp'">
							<span class="glyphicon glyphicon-pencil"></span> <span
								class="text">예약등록</span>
						</button>
					</li>
					<li>
						<button class=noeff
							onclick="location.href='<%=contextName%>/Resv.do?act=EMPL'"
							aria-hidden="true">
							<span class="glyphicon glyphicon-search"></span> <span
								class="text">예약조회</span>
						</button>
					</li>
					<li>
						<button class=noeff onclick="authToList();">
							<span class="glyphicon glyphicon-sunglasses"></span> <span
								class="text">사원관리</span>
						</button>
					</li>
				</ul>
			</div>
			<div class="right" style="margin: 5px 0">
				<span class="text"> <strong><%=request.getSession().getAttribute("userName").toString()%></strong>님
					반갑습니다. &nbsp;
				</span>
				<div class="item">
					<input class="btn btn-primary btn-md" type="button" value="로그아웃"
						onclick="f_logout()">
				</div>
			</div>
		</div>
	</div>
	<!--  내용 -->
	<div class="tbcontent">
		<h3>오늘의 한마디</h3>
		<div class="row">
			<div class="col-md-1">
				No.<%=boardNo%>
			</div>
			<div class="col-md-7">
				<%=boardSub%>
			</div>
			<div class="col-md-2">
				작성자:
				<%=boardWrtNm%>
			</div>
			<div class="col-md-2">
				날짜:
				<%=boardDate%>
			</div>
			</div>
			<div class="row">
				<div class="col-md-12" align="center"></div>
			</div>
			<div class="row">
				<div class="col-md-2" align="center"></div>
				<div class="col-md-8" id="cont" style = "height : 50px">
					<%=boardCont%>
				</div>
				<div class="col-md-2" align="center"></div>
			</div>
			<div align = "center" style = "margin : 20px">
			<a href = "javascript:update_click('<%=contextName%>/board.do?act=EMPUR&NO=<%=boardNo%>')" class="btn btn-primary">수정</a>
			<a href = "javascript:delete_click('<%=contextName%>/board.do?act=EMPD&NO=<%=boardNo%>')" class="btn btn-danger">삭제</a>
			<a href="javascript:list_click('<%=contextName%>/board.do?act=EMPL&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>')" class="btn btn-default">목록</a>
			</div>
		</div>
</body>
</html>