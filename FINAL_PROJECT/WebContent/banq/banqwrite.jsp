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
<title>연회예약관리시스템 :: 예약등록</title>

<!-- BootStrap을 위한 부분  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<!-- BootStrap을 위한 부분  -->

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
		

		if (document.fm.costName.value == '') {
			alert('고객 이름을 입력하세요');
			return false;			
		}else if(document.fm.costHp.value == ''){
			alert('고객 전화번호를 입력하세요');
			return false;			
		}else if(document.fm.resvDate.value == ''){
			alert('예약일자를 입력하세요');
			return false;					
		}else if(document.fm.resvRoom.value == ''){
			alert('연회실을 선택하세요');
			return false;			
		}else if(document.fm.resvTime.value == '0'){
			alert('시간을 선택하세요');
			return false;
		}else if(document.fm.resvAmnt.value == '0'){
			alert('참석 인원을 입력하세요');
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
<!-- 네비게이션 바 -->

	<div id="nav" style="background-color: black">
		<div class="core" >
			<div class="left">
					<span class = "home" ><strong><a href="<%=contextName%>/login.do?act=MAIN">연회예약관리시스템</a></strong></span>
				<ul class =" navbar">
				<li>
					<button class = noeff  onclick = "location.href= 'banqwrite.jsp'">
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
		<form class="form-inline" name = "fm"   method=post action="<%=contextName%>/Resv.do?act=EMPC" onsubmit="return modify_click(this);">
			<div><h4>고객 정보</h4></div>
			<div class="form-group">
				<div id = "lab" class = "col-lg-6">
				<label for="costName">고객 이름</label> <input type="text"
					class="form-control" id="costName" placeholder="ex) 김철수" name = "costName">
			</div>
			</div>
			<div class="form-group">
				<div id = "lab" class = "col-lg-6">
				<label for="costHp">고객 전화번호</label> <input type="text"
					class="form-control" id="costHp" placeholder="ex)  010-0000-0000" name = "costHp">
			</div>
			</div><br>
			<div><h4>예약 정보</h4></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvDate">예약 일자</label> <input type="text"
					class="form-control"  id="datepicker" placeholder="ex) YYYY-MM-DD" name = "resvDate" readonly>
			</div></div>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvRoom">연회실</label>
				<select class = "form-control" id = "resvTime" name = "resvRoom">
					<option value = "R">루비</option>
					<option value = "S">사파이어</option>
					<option value = "E">에메랄드</option>
					<option value = "D">금강</option>
					<option value = "F">휘에스타</option>
				</select>
			</div></div><br>
			<div class="form-group">
			<div id = "lab" class = "col-lg-6">
				<label for="resvTime">예약 시간</label> 
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
				<label for="resvAmnt">참석 인원</label>
				<input type="text"class="form-control" id="resvAmnt" placeholder="ex) 00" name = "resvAmnt">
			</div></div><br><br>
			<div class = "container">
				<button type="submit" class="btn btn-primary">등록</button> <button class="btn btn-danger">취소</button>
			</div>
		</form>
	</div>
	</div>
</body>
</html>