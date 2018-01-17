<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String CONTEXT_PATH = request.getContextPath();
	String contextName = request.getContextPath();
	String jspBasePath = contextName + "/";
	String imgPath = jspBasePath + "images";

	ArrayList<Employee> empList = new ArrayList<Employee>();
	empList = (ArrayList<Employee>) request.getAttribute("empList");

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

	String empNo;
	String empID;
	String empPosi;
	String empName;
	String empAuth;
%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ȸ��������ý��� :: �������</title>
<!-- BootStrap�� ���� �κ�  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap�� ���� �κ�  -->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="../bower_components/html5shiv/dist/html5shiv.js"></script>
      <script src="../bower_components/respond/dest/respond.min.js"></script>
    <![endif]-->
<script>

    function f_logout()
    {
    	location.href="<%=contextName%>/login.do?act=LOGOUT";
	}
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-23019901-1' ]);
	_gaq.push([ '_setDomainName', "bootswatch.com" ]);
	_gaq.push([ '_setAllowLinker', true ]);
	_gaq.push([ '_trackPageview' ]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl': 'http://www')
				+ '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();

	function insert_click(url_param) {

		location.replace(url_param);
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
		<div class="container" >

			<div class="row">
				<div class="col-lg-12">
					<div class="page-header">
						<h4 id="tables">��� ���</h4>
					</div>
					<div class="bs-component">
						<table class="table table-striped table-hover ">
							<thead>
								<tr>
									<th>No</th>
									<th>�����ȣ</th>
									<th>���̵�</th>
									<th>�̸�</th>
									<th>����</th>
									<th>����</th>
								</tr>
							</thead>
							<tbody>
								<%
									if (empList.size() > 0) {

										for (int i = 0; i < empList.size(); i++) {

											Employee emp = empList.get(i);

											empNo = emp.getEmpNo();
											empID = emp.getEmpID();
											empName = emp.getEmpName();
											empPosi = emp.getEmpPosi();
											empAuth = emp.getEmpAuth();
								%>
								<tr>
									<td><%=virtual_no--%></td>
									<td><%=empNo%></td>
									<td><b><a
											href="<%=contextName%>/emp.do?act=EMPR&NO=<%=empNo%>&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>">
												<%=empID%></a></b></td>
									<td><%=empName%></td>
									<td><%=empPosi%></td>
									<td><%=empAuth%></td>
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
					<!-- /example -->
				</div>
			</div>
		</div>
		<div class="col-lg-offset-x">
			<ul class="pagination">
				<%
					if (cpage == 1) {
				%>
				<li class="disabled"><a
					href="<%=contextName%>/emp.do?act=EMPL&page=1">&laquo;</a></li>
				<%
					} else {
				%>
				<li class="active"><a
					href="<%=contextName%>/emp.do?act=EMPL&page=1">&laquo;</a></li>
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
					href="<%=contextName%>/emp.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
				<%
					} else {
				%>
				<li><a href="<%=contextName%>/emp.do?act=EMPL&page=<%=i%>"><%=i%></a></li>
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
					href="<%=contextName%>/emp.do?act=EMPL&page=<%=startPage - 1%>">&raquo;</a></li>
				<%
					}
				%>

			</ul>


		</div>

		<div class="col-md-offset-11">
			<p class="bs-component">
				<a
					href="javascript:insert_click('<%=contextName%>/emp.do?act=EMPCR')"
					class="btn btn-primary">��� ���</a>
			</p>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>