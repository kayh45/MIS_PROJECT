<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.kayh.web.model.*" %>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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



Employee empInfo = new Employee();
empInfo = (Employee)request.getAttribute("empInfo");

String empNo = 		empInfo.getEmpNo() == null ? "" : empInfo.getEmpNo();
String empID = 	empInfo.getEmpID() == null ? "" : empInfo.getEmpID();
String empName = 	empInfo.getEmpName() == null ? "" : empInfo.getEmpName();
String empPosi = 	empInfo.getEmpPosi() == null ? "" : empInfo.getEmpPosi();
String empDept = 	empInfo.getEmpDept() == null ? "" : empInfo.getEmpDept();
String empHp = 		empInfo.getEmpHp() == null ? "" : empInfo.getEmpHp();
String empEmail = 	empInfo.getEmpEmail() == null ? "" : empInfo.getEmpEmail();
String empPw = 		empInfo.getEmpPw() == null ? "" : empInfo.getEmpPw();
String empAuth = 	empInfo.getEmpAuth() == null ? "2" : empInfo.getEmpAuth(); 


%>

<title>::: 주문관리 시스템  :::</title>

<!-- BootStrap을 위한 부분  -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">
<!-- BootStrap을 위한 부분  -->

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

function modify_click(url_param) {
		
		if (validation()) {

			if (confirm('수정 하시겠습니까?')) {
				
				location.replace(url_param);

			}else{
				
				return false;
			} 

		}else{
			
			return false;
		}
}

	function validation() {
		

		if (document.fm.empName.value == '') {
			alert('이름을 입력하세요');
			return false;
			
		}else if(document.fm.empID.value == ''){
			alert('아이디를 입력하세요');
			return false;			
			
		}else if(document.fm.empDept.value == ''){
			alert('부서를 입력하세요');
			return false;			
			
		}else if(document.fm.empPw.value == ''){
			alert('비밀번호를 입력하세요');
			return false;			
		}
		else if(document.fm.empAuth.value == '0'){
			alert('권한을 선택하세요');
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
</head>
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
     <div class="bs-docs-section" style = "margin : 20px 70px">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h3 id="tables">사원 수정</h3>
            </div>
            <div class="bs-component">
<form name="fm" method=post action="<%=contextName%>/emp.do?act=EMPU" onsubmit="return modify_click(this);" >
             <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">사원번호</h3>
                </div>
                <div class="panel-body">
                <%=empNo%>
                <input type="hidden" class="form-control" id="inputEmail" value="<%=empNo%>" name="NO">
                </div>
              </div>  
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">아이디</h3>
                </div>
                <div class="panel-body">
                <%=empID %>
                <input type="hidden" class="form-control" id="inputEmail" value="<%=empID %>" name="empID">
                </div>
              </div>
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">이름</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empName %>" name="empName">
                </div>
              </div>          
               <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">부서</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empDept %>" name="empDept">
                </div>
              </div>     
               <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">직급</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empPosi %>" name="empPosi">
                </div>
              </div>     
               <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">연락처</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empHp %>" name="empHp">
                </div>
              </div>     
               <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">이메일</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empEmail %>" name="empEmail">
                </div>
              </div>  
  
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">비밀번호</h3>
                </div>
                <div class="panel-body">
                <input type="text" class="form-control" id="inputEmail" value="<%=empPw %>" name="empPw">
                </div>
              </div>    
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">권한</h3>
                </div>
                <div class="panel-body">
           <select class="form-control" id="select" name="empAuth">
           <option value="1" <%if(empAuth.equals("관리자")){ %>selected="selected" <%} %>>관리자</option>
           <option value="2" <%if(empAuth.equals("일반사용자")){ %>selected="selected" <%} %>>일반사용자</option>
           </select>
                </div>
              </div>
              <div class="col-lg-offset-x">   
              <p class="bs-component">
                      <button type="submit" class="btn btn-primary">수정</button>
                      <a href="javascript:list_click('<%=contextName%>/emp.do?act=EMPL&page=<%=cpage%>&srch_type=<%=srch_type%>&srch_keyword=<%=srch_keyword%>')" class="btn btn-default">취소</a>
             </p>
             </div>
 </form>
</div>
</div>
</div>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>