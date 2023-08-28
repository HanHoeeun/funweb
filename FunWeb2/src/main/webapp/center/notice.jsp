<%@page import="com.itwillbs.domain.PageDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.itwillbs.domain.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
List<BoardDTO> boardList 
    = (List<BoardDTO>)request.getAttribute("boardList");

PageDTO pageDTO=(PageDTO)request.getAttribute("pageDTO");
%>
<article>
<h1>Notice</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    <%
SimpleDateFormat format =new SimpleDateFormat("yyyy.MM.dd");
    for(int i=0;i<boardList.size();i++){
    	BoardDTO boardDTO=boardList.get(i);
    	%>
<tr onclick="location.href='content.bo?num=<%=boardDTO.getNum()%>'">
    <td><%=boardDTO.getNum() %></td>
    <td class="left"><%=boardDTO.getSubject() %></td>
    <td><%=boardDTO.getName() %></td>
    <td><%=format.format(boardDTO.getDate()) %></td>
    <td><%=boardDTO.getReadcount() %></td></tr>    	
    	<%
    }
    %>
</table>
<%
String id = (String)session.getAttribute("id");
if(id != null){
	%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" 
       onclick="location.href='write.bo'">
<input type="button" value="파일글쓰기" class="btn" 
       onclick="location.href='fwrite.bo'">       
</div>	
	<%
}
%>


<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="search" class="btn">
</div>

<div class="clear"></div>
<div id="page_control">
<%
// 시작페이지 1페이지 Prev 없음
// 시작페이지 11,21,31 Prev 보임
if(pageDTO.getStartPage() > pageDTO.getPageBlock()){
	%>
	<a href="list.bo?pageNum=<%=pageDTO.getStartPage()-pageDTO.getPageBlock()%>">Prev</a>
	<%
}
%> 

<%
for(int i=pageDTO.getStartPage();i<=pageDTO.getEndPage();i++){
	%>
	<a href="list.bo?pageNum=<%=i%>"><%=i %></a> 
	<%
}
%>

<%
//끝페이지번호  전체페이지수 비교 => 전체페이지수 크면 => Next보임
if(pageDTO.getEndPage() < pageDTO.getPageCount()){
	%>
	<a href="list.bo?pageNum=<%=pageDTO.getStartPage()+pageDTO.getPageBlock()%>">Next</a>
	<%
}
%>

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