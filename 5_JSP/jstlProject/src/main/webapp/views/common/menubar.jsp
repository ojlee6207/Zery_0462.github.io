
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//Member loginUser = (Member)session.getAttribute("loginUser");
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Project</title>
<style>
    .login-area > * {
        float:right;
    }

    .login-area a {
        text-decoration: none;
        color:black;
        font-size: 12px;
    }

    .nav-area { background-color: black;}
    .menu { 
        display : table-cell; /* table의 cell 처럼 바꿔주는 속성, 옆으로 배치 됨*/
        width:150px; height:50px;
    } 
    .menu a {
        text-decoration: none;
        color:white;
        font-size:20px;
        font-weight: bold;
        display : block;
        width:100%; height:100%;
        line-height:50px;
    }
	.menu a:hover, .login-user a:hover {
		background: darkgrey;
	}
</style>
<!-- bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	
	<c:if test="${ alertMsg != null }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
    <h1 align="center">Welcome Zery World</h1>

    <div class="login-area">
        <c:choose>
	        <c:when test = "${loginUser==null}">
	        <!-- 1) 로그인 전 -->
	        <form action="login.me" method="post">
	            <table>
	                <tr>
	                    <th>아이디</th>
	                    <td><input type="text" name="userId" required /></td>
	                </tr>
	                <tr>
	                    <th>비밀번호</th>
	                    <td><input type="password" name="userPwd" required /></td>
	                </tr>
	                <tr>
	                    <th colspan="2">
	                        <button type="submit">로그인</button>
	                        <button type="button" onclick="enrollPage()">회원가입</button>
	                    </th>
	                </tr>
	            </table>
	            <script>
	            	function enrollPage() {
	            		// 회원가입 페이지 요청
	            		// location.href= "<%= contextPath %>/views/member/memberEnrollForm.jsp";
	            		// directory 구조가 url에 그대로 노출 => 보안 취약
	            		
	            		location.href="enrollForm.me";
	            	}
	            </script>
	        </form>
			</c:when>
	        <c:otherwise>
		        <!-- 2) 로그인 후 -->
		        <br><br>
		        <div class=login-user align="center">
		            <b>${ loginUser.userName }</b>님의 방문을 환영합니다.
		            <br><br>
		            <a href="myPage.me">마이페이지</a>
		            <a href="logout.me">로그아웃</a>
		        </div>
		    </c:otherwise>
        </c:choose>
    </div>
    <!-- clear : float 스타일 속성의 영향을 받지 않도록 처리 -->
    <br clear="both">;

    <div class="nav-area" align="center">
        <div class="menu"><a href="<%= contextPath %>">Home</a></div>
        <div class="menu"><a href="list.no">공지사항</a></div>
        <div class="menu"><a href="list.bo?cpage=1">일반게시판</a></div>
        <div class="menu"><a href="<%= contextPath %>">사진게시판</a></div>
        
    </div>
</body>
</html>