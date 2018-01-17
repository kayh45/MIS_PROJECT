<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>��ȸ��������ý��� :: ������ȸ</title>
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";

ArrayList<Reservation> resvList = new ArrayList<Reservation>();
resvList = (ArrayList<Reservation>) request.getAttribute("resvList");

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

String resvNo;
String costName;
String resvRoom;
String resvDate;
String resvTime;
%>

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
		margin : 50px
	}
	
	@media (max-width: 480px){
		.fmcontent {
			margin : 20px
		}
	}
</style>

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
<!--  ����  -->

<div class = "fmcontent">
<h4> ���� ��ȸ </h4>

<table class = "table">
<thead>
	<tr>
		<th>#</th>
		<th>�����ȣ</th>
		<th>���̸�</th>
		<th>��ȸ��</th>
		<th>��������</th>
		<th>����ð�</th>
	</tr>
</thead>
<tbody>
<%
									if (resvList.size() > 0) {

										for (int i = 0; i < resvList.size(); i++) {

											Reservation resv = resvList.get(i);

											resvNo = resv.getResvNo();
											costName = resv.getCostName();
											resvRoom = resv.getResvRoom();
											resvDate = resv.getResvDate();
											resvTime = resv.getResvTime();
											
											String roomName = "";
											String timeName = "";
											
											
												if (resvRoom.equals("R")) {
													roomName = "���";
												}else if (resvRoom.equals("S")) {
													roomName = "�����̾�";
												}else if (resvRoom.equals("E")) {
													roomName = "���޶���";
												}else if (resvRoom.equals("D")) {
													roomName = "�ݰ�";
												}else if (resvRoom.equals("F")) {
													roomName = "�ֿ���Ÿ";
												}
												if (resvTime.equals("1")) {
													timeName = "09:00 ~ 11:00";
												}else if (resvTime.equals("2")) {
													timeName = "12:00 ~ 14:00";
												}else if (resvTime.equals("3")) {
													timeName = "15:00 ~ 17:00";
												}else if (resvTime.equals("4")) {
													timeName = "17:00 ~ 19:00";
												}else if (resvTime.equals("5")) {
													timeName = "20:00 ~ 22:00";
												}
												System.out.println(resvRoom);
								%>
								<tr>

									<td><%=virtual_no--%></td>
									<td><b><a
											href="<%=contextName%>/Resv.do?act=EMPR&NO=<%=resvNo%>&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>">
												<%=resvNo%></a></b></td>
									<td><%=costName%></td>								
									<td><%=roomName%></td>
									<td><%=resvDate%></td>
									<td><%=timeName%></td>
								</tr>
								<%
									}

									} else {
								%>
								<tr>
									<td colspan="6" align="center">�ڷᰡ �������� �ʽ��ϴ�.</td>
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
					href="<%=contextName%>/Resv.do?act=EMPL&page=1">&laquo;</a></li>
				<%
					} else {
				%>
				<li class="active"><a
					href="<%=contextName%>/Resv.do?act=EMPL&page=1">&laquo;</a></li>
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
					href="<%=contextName%>/Resv.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
				<%
					} else {
				%>
				<li><a href="<%=contextName%>/Resv.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
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
					href="<%=contextName%>/Resv.do?act=EMPL&page=<%=startPage - 1%>">&raquo;</a></li>
				<%
					}
				%>

			</ul>


		</div>

</body>
</html>