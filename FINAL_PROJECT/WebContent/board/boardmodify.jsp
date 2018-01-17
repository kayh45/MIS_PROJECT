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
<title>��ȸ��������ý��� :: �Խ��� ����</title>

<!-- BootStrap�� ���� �κ�  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap�� ���� �κ�  -->

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

			if (confirm('���� �Ͻðڽ��ϱ�?')) {
				
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
			alert('������ �Է��ϼ���');
			return false;			
		}else if(document.fm.boardCont.value == ''){
			alert('������ �Է��ϼ���');
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
	var ok = confirm("���� �α׾ƿ� �Ͻðڽ��ϱ�?\n (�α��� �������� ���ư�)");
	if(ok) 	
		location.href="<%=contextName%>/login.do?act=LOGOUT";
	else;
}

function authToList() {
	
	if(<%= request.getSession().getAttribute("userAuth").toString() %> == 1){
		location.href="<%=contextName%>/emp.do?act=EMPL";
	}
	else alert("���� ������ �����ϴ�.");
}
</script>
</head>
<!-- �׺���̼� �� -->
<body>
	<div id="nav" style="background-color: black">
		<div class="core" >
			<div class="left">
					<span class = "home" ><strong><a href="<%=contextName%>/login.do?act=MAIN">��ȸ��������ý���</a></strong></span>
				<ul class =" navbar">
				<li>
					<button class = noeff  onclick = "location.href= 'banq/banqwrite.jsp'">
						<span class = "glyphicon glyphicon-pencil"></span>
						<span class="text">������</span>
					</button>
				 </li>
				<li>
					<button class = noeff  onclick = "location.href='<%=contextName%>/Resv.do?act=EMPL'" aria-hidden = "true">
						<span class = "glyphicon glyphicon-search" ></span>
						<span class="text">������ȸ</span>
					</button>
				</li>
				<li>
					<button class = noeff  onclick = "authToList();">
						<span class = "glyphicon glyphicon-sunglasses"></span>
						<span class="text">�������</span>
					</button>
				</li>
				</ul>
			</div>
			<div class="right" style = "margin : 5px 0">
			<span class = "text">
			<strong><%=request.getSession().getAttribute("userName").toString() %></strong>�� �ݰ����ϴ�.  &nbsp;
			</span>
				<div class = "item">
				<input class="btn btn-primary btn-md" type="button" value = "�α׾ƿ�" onclick ="f_logout()">
				</div>
			</div>
		</div>
	</div>
	<!--  ���� -->
<div class = "fmcontent">
	<h3>������ �Ѹ��� ����</h3>
<form method=post name = "fm" action="<%=contextName%>/board.do?act=EMPU" onsubmit="return modify_click(this);">
	<div class = "col-lg-6" style = "border : 1px solid #EAEAEA;">
	<input type = "hidden" class = form-control" name = "boardNo" value = <%= boardNo %>>
	<input type = "hidden" class = "form-control"  name = "boardWrt" value = <%=request.getSession().getAttribute("userNo").toString() %>>
	�̸�: <input type = "text" class = "form-control"  name = "boardWrtNm" value = <%=request.getSession().getAttribute("userName").toString() %> readonly><br>
	��¥: <input type = "text" class = "form-control"  name = "boardDate" value = <%= today %> readonly><br>
	����: <input type = "text" class = "form-control" name = "boardSub" value = <%= boardSub %>><br>
	����: <input type = "text" class = "form-control" name = "boardCont" value = <%= boardCont %>><br>
	<div style = "margin : 20px" align = "center">
	<input class = "btn btn-primary" type = "submit" value = "����">
	<a href = "javascript:list_click('<%=contextName%>/board.do?act=EMPL&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>')" class="btn btn-default"  type = "button" >
	���
	</a>
	</div>
	</div>
</form>
</div>
</body>
</html>