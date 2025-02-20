<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.kh.common.model.PageInfo, java.util.ArrayList, com.kh.board.model.vo.Board" %>
    
<%
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	
	System.out.println(pi);
	
	int currentPage = pi.getCurrentPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Project</title>
</head>
<style>
    .outer { background: black; color:white;
    		 width:1000px; height: 500px; margin:auto; margin-top: 50px;} 
    .list-area { border : 1px solid white; text-align: center; color:white; }
	.list-area>tbody>tr:hover { background:darkgray; cursor:pointer; }

</style>
<body>
    <%@ include file="../common/menubar.jsp" %>
    <div class="outer">
        <br>
        <h2 align="center">일반 게시판</h2>
        <br>
        
        <%-- 로그인 한 경우만 글쓰기 표시되게 --%>
        <c:if test="${loginUser != null}">
        	<div align="right" style="width:850px;">
        		<a href="enroll.bo" class="btn btn-sm btn-secondary">글쓰기</a>
        	</div>
        	<br>
        </c:if>
        
        <table align="center" class="list-area">
            <thead>
                <tr>
                    <th width="70">글번호</th>
                    <th width="80">카테고리</th>
                    <th width="300">제목</th>
                    <th width="100">작성자</th>
                    <th width="50">조회수</th>
                    <th width="100">작성일</th>
                </tr>
            </thead>
            <tbody>
            	<%-- 조회 결과에(list) 따라서 데이터 표시 --%>
            	<%-- 게시글이 없으면 --%>
            	<c:choose>
            		<c:when test="${ empty list }">
		            	<tr>
		            		<td colspan="6">조회된 게시글이 없습니다</td>
		            	</tr>
		            </c:when>
            	<%-- 게시글이 있는 경우 --%>
            		<c:otherwise>
            			<c:forEach var="b" items="${list}">
			                <tr>
			                    <td>${b.boardNo}</td>
			                    <td>${b.categoryNo}</td>
			                    <td>${b.boardTitle}</td>
			                    <td>${b.boardWriter}</td>
			                    <td>${b.count}</td>
			                    <td>${b.createDate}</td>
			                </tr>
			            </c:forEach>
            		</c:otherwise>
            	</c:choose>
            </tbody>
        </table>
		<script>
			$(function(){
				$(".list-area>tbody>tr").click(function(){
					location.href = 'detail.bo?bnum='+$(this).children().eq(0).text();
				});
			});
		</script>
        <br><br>

        <div align="center">
            <% if(currentPage > 1) { %> <%-- 1번일때는 표시 안 되도록 --%>
            	<button onclick="location.href = 'list.bo?cpage=<%= currentPage-1 %>'">&lt;</button>
            <% } %>
            <%-- 페이징바 시작번호 (startPage)
				 페이징바의 표시개수(pageLimit)
				 마지막(endPage)
				 
				 현재 선택된 페이지면 클릭 할 수 없도록(disabled)
				 + 클릭하면 해당 페이지로            
             --%>
            <% for (int p = pi.getStartPage(); p <= pi.getEndPage(); p++) { %>
            	<% if (currentPage == p) { %>
            		<button disabled><%= p %></button>
            	<% } else { %>
            		<button onclick="location.href = 'list.bo?cpage=<%= p %>'"><%= p %></button>
            	<% } %>	
            <% } %>
 			<% if(currentPage < pi.getMaxPage()) { %> <%-- 1번일때는 표시 안 되도록 --%>
            	<button onclick="location.href = 'list.bo?cpage=<%= currentPage+1 %>'">&gt;</button>
            <% } %>
        </div>
    </div>
</body>
</html>