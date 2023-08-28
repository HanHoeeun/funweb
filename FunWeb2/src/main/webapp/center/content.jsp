<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.itwillbs.domain.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/content.jsp</title>
<link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<!-- 액션태그 : jsp문법 , 태그처럼 사용, 웹의 경로 지정(문법으로 정해놓음)  
include 액션태그 : 반복되는 화면을 파일로 만들고 파일을 가져다가 사용-->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
String id = (String)session.getAttribute("id");
BoardDTO boardDTO = (BoardDTO)request.getAttribute("boardDTO");
%>
<article>
<h1>Content Notice</h1>
<table id="notice">
<tr><td>글번호</td><td><%=boardDTO.getNum() %></td></tr>
<tr><td>글쓴이</td><td><%=boardDTO.getName() %></td></tr>
<tr><td>글쓴날짜</td><td><%=boardDTO.getDate() %></td></tr>
<tr><td>조회수</td><td><%=boardDTO.getReadcount() %></td></tr>
<tr><td>제목</td><td><%=boardDTO.getSubject() %></td></tr>
<tr><td>첨부파일</td>
    <td><a href="upload/<%=boardDTO.getFile() %>" download>
        <%=boardDTO.getFile() %></a>
        <img src="upload/<%=boardDTO.getFile() %>" 
         width="200" height="200">
        </td></tr>
<tr><td>내용</td><td><%=boardDTO.getContent() %></td></tr>    
</table>
<div id="table_search">
<%
// 로그인, 글쓴이 일치 
if(id != null){
	if(id.equals(boardDTO.getName())){
		%>
		<input type="button" value="글수정" class="btn"
			onclick="location.href='update.bo?num=<%=boardDTO.getNum()%>'">
		<input type="button" value="글삭제" class="btn"
			onclick="location.href='delete.bo?num=<%=boardDTO.getNum()%>'">
		<input type="button" value="파일 글수정" class="btn"
			onclick="location.href='fupdate.bo?num=<%=boardDTO.getNum()%>'">
		<% 
	}
}
%>
<input type="button" value="글목록" class="btn" 
       onclick="location.href='list.bo'">
</div>


<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>