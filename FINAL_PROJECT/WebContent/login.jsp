<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String CONTEXT_PATH = request.getContextPath();
String contextName = request.getContextPath();
String jspBasePath = contextName + "/";
String imgPath = jspBasePath + "images";
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ȸ��������ý��� :: �α���</title>
<link href = "css/bootstrap.min.css"  rel = "stylesheet">
<link href="starter-template.css" rel="stylesheet">

<style>
	h1 {
	color:black
	}
	
	.form {
	margin : 0 150px;
	width : 40%;
	border : 1px solid #EAEAEA ;
	padding : 30px;
	background-color : #444444;
	}
	label {
	 color : white;
	 }
	 input, input:focus{
	 color : white;
	 }
	 @media (max-width : 480px) {
	 		h1 {
	 		font-size : 40px;
	 		}
	 		.form {
				margin : 0 5px;
				width : 80%;
				border : 1px solid #EAEAEA ;
				padding : 30px;
				background-color : #444444;
				}
	 }
</style>

<script language = "javascript">

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

function f_submit() {
	
	var form = document.fm;

	if (form.user.value == "") {
		alert("���̵� �Է��ϼ���");
		form.user.focus();
		return;
	}
	if (form.pass.value == ""){
		alert("��й�ȣ�� �Է��ϼ���");
		form.pass.focus();
		return;
	}
	
	form.action = "<%=contextName%>/login.do?act=LOGIN";
	form.submit();
	
}


</script>

</head>
<body>
<div class =" container">
	<div class = "starter-template">
		<h1>��ȸ��������ý���::Ver.2</h1>
		<p class = "lead">

		<form class="form" name="fm" method=post action="<%=contextName%>/login.do?act=LOGIN">
                   <div class="form-group">
                   <label for="inputEmail" class="col-lg-4 control-label">���̵�</label>
                    <input type="text" class="form-control" id="inputId" name="user" placeholder="���̵�">
                    </div>
                    <div class = "form-group">
                    <label for="inputPassword" class="col-lg-4 control-label">��й�ȣ</label>
                    <input type="password" class="form-control" id="inputPw" name="pass" placeholder="��й�ȣ">
                    </div>
                    
                    <div class = row>
                    <div class = col-lg-8>.</div>            
                	<div class="col-lg-2" style = "margin : 20px">
                		<a class="btn btn-primary btn-lg" href="javascript:f_submit()" >�α���</a><!--�ڹٽ�ũ��Ʈ �ɱ�..  -->
                	</div>
                	</div>
      </form>

	</div>
</div>

</body>
</html>