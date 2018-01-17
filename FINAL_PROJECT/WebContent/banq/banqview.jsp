<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*" %>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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


Reservation resvInfo = new Reservation();
resvInfo = (Reservation)request.getAttribute("resvInfo");

String resvNo = 		resvInfo.getResvNo() == null ? "" : resvInfo.getResvNo();
String costName = 	resvInfo.getCostName() == null ? "" : resvInfo.getCostName();
String costHp= 	resvInfo.getCostHp() == null ? "" : resvInfo.getCostHp();
String resvDate = 	resvInfo.getResvDate() == null ? "" : resvInfo.getResvDate();
String resvRoom = 		resvInfo.getResvRoom() == null ? "" : resvInfo.getResvRoom();
String resvTime = 	resvInfo.getResvTime() == null ? "" : resvInfo.getResvTime();
String resvAmnt = 		resvInfo.getResvAmnt() == null ? "" : resvInfo.getResvAmnt();

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
				timeName = "09:00~11:00";
			}else if (resvTime.equals("2")) {
				timeName = "12:00~14:00";
			}else if (resvTime.equals("3")) {
				timeName = "15:00~17:00";
			}else if (resvTime.equals("4")) {
				timeName = "17:00~19:00";
			}else if (resvTime.equals("5")) {
				timeName = "20:00~22:00";
			}
			System.out.println(resvRoom);

%>
<html>
<head>
<title>��ȸ��������ý��� :: ���� �� ��ȸ</title>

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


<script type="text/javascript">
function delete_click(url_param){
    
    
    if(confirm('������ �����Ͻðڽ��ϱ�?')){
        location.replace(url_param);
    }
    
}

function update_click(url_param){
    
        location.replace(url_param);
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
		<form class="form-inline" name = "fm"   method=post action="<%=contextName%>/Resv.do?act=EMPC" onsubmit="return modify_click(this);">
			<div><h4>�� ����</h4></div>
			<div class="form-group">
				<div id = "lab" class = "col-lg-6">
				<label for="costName"><b>�� �̸�</b></label> <input type="text"
					class="form-control" id="costName" value = <%=costName%> disabled="disabled"  placeholder="ex) ��ö��" name = "costName" >
			</div>
			</div>
			<div class="form-group">
				<div id = "lab" class = "col-lg-6">
				<label for="costHp"><b>�� ��ȭ��ȣ</b></label> <input type="text"
					class="form-control" id="costHp" value = <%=costHp%> disabled="disabled"  placeholder="ex)  010-0000-0000" name = "costHp">
			</div>
			</div><br>
			<div><h4>���� ����</h4></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvDate"><b>���� ����</b></label> <input type="text"
					class="form-control" id="resvDate" value = <%=resvDate%> disabled="disabled"  placeholder="ex) YYYY-MM-DD" name = "resvDate">
			</div></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvRoom"><b>��ȸ��</b></label>
				<input type="text"
					class="form-control" value = <%=roomName%> disabled="disabled"  id = "resvTime" name = "resvRoom">
			</div></div><br>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvTime"><b>���� �ð�</b></label> 
				<input type="text" size = "50" class="form-control" value = <%=timeName%> disabled="disabled"  id = "resvTime" name = "resvTime">
			</div></div><br>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvAmnt"><b>���� �ο�</b></label>
				<input type="text"class="form-control" value = <%=resvAmnt%> disabled="disabled"  id="resvAmnt" placeholder="ex) 00" name = "resvAmnt">
			</div></div><br><br>
			 <div class="col-lg-offset-x">

            <p class="bs-component">
              <a href="javascript:delete_click('<%=contextName%>/Resv.do?act=EMPD&NO=<%=resvNo%>')" class="btn btn-danger">����</a>
              <a href="javascript:list_click('<%=contextName%>/Resv.do?act=EMPL&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>')" class="btn btn-default">���</a>
            </p>
         </div>   
		</form>
	</div>
	
</body>
</html>