<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
//로그인 하면 => 로그인한 정보를 세션 저장
// 세션에 로그인 정보 가져오기
String id=(String)session.getAttribute("id");
// 세션에 로그인 정보가 없으면(null) => 로그인login, 회원가입join
// 세션에 로그인 정보가 있으면 => ..님 로그아웃logout 회원수정update
if(id == null){
	%>
<div id="login"><a href="login.me">login</a> | <a href="insert.me">join</a></div>	
	<%
}else{
%>
<div id="login"><%=id %>님 | <a href="logout.me">logout</a>
                          | <a href="update.me">update</a>
                          | <a href="delete.me">delete</a>
                          | <a href="list.me">list</a></div>
<%	
}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="main.me">HOME</a></li>
	<li><a href="welcome.co">COMPANY</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="list.bo">CUSTOMER CENTER</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
</header>