<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="com.kayh.web.model.*" %>
	<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>��ȸ��������ý��� :: ����������</title>
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
<!-- BootStrap�� ���� �κ�  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap�� ���� �κ�  -->

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
<body>
	<!-- �׺���̼� �� -->
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
	<!-- ���� --><br>
		<div class = "container">
			<div class = "row">
				<h5><a href = "board.do?act=EMPL">������ �Ѹ���</a></h5>
			</div>
			<img class = "imgsize" src = "<%= contextName %>/IMG/BNQROOM.jpg" >
			<h4>��ȸ��������ý����Դϴ�.</h4>
			
		</div>
</body>
</html>