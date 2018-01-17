<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";
%>
<html>
<head>
<title>��ȸ��������ý��� :: ������</title>

<!-- BootStrap�� ���� �κ�  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
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
		

		if (document.fm.costName.value == '') {
			alert('�� �̸��� �Է��ϼ���');
			return false;			
		}else if(document.fm.costHp.value == ''){
			alert('�� ��ȭ��ȣ�� �Է��ϼ���');
			return false;			
		}else if(document.fm.resvDate.value == ''){
			alert('�������ڸ� �Է��ϼ���');
			return false;					
		}else if(document.fm.resvRoom.value == ''){
			alert('��ȸ���� �����ϼ���');
			return false;			
		}else if(document.fm.resvTime.value == '0'){
			alert('�ð��� �����ϼ���');
			return false;
		}else if(document.fm.resvAmnt.value == '0'){
			alert('���� �ο��� �Է��ϼ���');
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
$(function() {
$( "#datepicker" ).datepicker(
{
        dateFormat:    'yy-mm-dd'
}
 
);
});
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
					<button class = noeff  onclick = "location.href= 'banqwrite.jsp'">
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
				<label for="costName">�� �̸�</label> <input type="text"
					class="form-control" id="costName" placeholder="ex) ��ö��" name = "costName">
			</div>
			</div>
			<div class="form-group">
				<div id = "lab" class = "col-lg-6">
				<label for="costHp">�� ��ȭ��ȣ</label> <input type="text"
					class="form-control" id="costHp" placeholder="ex)  010-0000-0000" name = "costHp">
			</div>
			</div><br>
			<div><h4>���� ����</h4></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvDate">���� ����</label> <input type="text"
					class="form-control"  id="datepicker" placeholder="ex) YYYY-MM-DD" name = "resvDate" readonly>
			</div></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvRoom">��ȸ��</label>
				<select class = "form-control" id = "resvTime" name = "resvRoom">
					<option value = "R">���</option>
					<option value = "S">�����̾�</option>
					<option value = "E">���޶���</option>
					<option value = "D">�ݰ�</option>
					<option value = "F">�ֿ���Ÿ</option>
				</select>
			</div></div><br>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvTime">���� �ð�</label> 
				<select class = "form-control" id = "resvTime" name = "resvTime">
					<option value = "1">09:00 ~ 11:00</option>
					<option value = "2">12:00 ~ 14:00</option>
					<option value = "3">15:00 ~ 17:00</option>
					<option value = "4">17:00 ~ 19:00</option>
					<option value = "5">20:00 ~ 22:00</option>
				</select>
			</div></div><br>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvAmnt">���� �ο�</label>
				<input type="text"class="form-control" id="resvAmnt" placeholder="ex) 00" name = "resvAmnt">
			</div></div><br><br>
			<div class = "container">
				<button type="submit" class="btn btn-primary">���</button> <button class="btn btn-danger">���</button>
			</div>
		</form>
	</div>

</body>
</html>