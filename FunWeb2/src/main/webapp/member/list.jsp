<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.itwillbs.domain.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/list.jsp</title>
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
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
List<MemberDTO> memberList
   =(List<MemberDTO>)request.getAttribute("memberList");
%>
<article>
<h1>List Us</h1>
<table id="notice">
<tr><th class="tno">Id</th>
    <th class="twrite">Pass</th>
    <th class="tdate">Name</th>
    <th class="tread">Date</th></tr>
 <%
 // import="java.text.SimpleDateFormat"
 // 날짜 => 원하는 포맷으로 변경하면 => 문자열 결과 리턴 
 SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
 for(int i=0;i<memberList.size();i++){
	 MemberDTO memberDTO =memberList.get(i);
	 %>
<tr><td><%=memberDTO.getId() %></td>
    <td><%=memberDTO.getPass() %></td>
    <td><%=memberDTO.getName() %></td>
    <td><%=format.format(memberDTO.getDate()) %></td></tr> 	 
	 <%
 }
 %>   
</table>

<input type="button" value="버튼" class="btn">
<table id="notice" class="table2">
<tr><th class="tno">Id</th>
    <th class="twrite">Pass</th>
    <th class="tdate">Name</th>
    <th class="tread">Date</th></tr>
   
</table>

</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>

<script type="text/javascript" 
        src="script/jquery-3.7.0.js"></script>
        
<script type="text/javascript">
	$(document).ready(function(){
// 		class="btn" 버튼을 클릭했을때
		$('.btn').click(function(){
// 			alert("클릭");

			$.ajax({
				url:'listjson.me',
				// 파라미터없으면 생략
// 				data:{'id':$('.id').val()},
				//리턴한 데이터 타입 지정
				dataType:'json',
				success:function(result){
					// result json데이터 형태로 가져오고 
					// 반복시켜서 접근해서 => table 출력
					$.each(result,function(index,item){
						// class="table2" 에 뒤부분 추가하면서 출력
						$('.table2').append("<tr><td>"+item.id+"</td><td>"+item.pass+"</td><td>"+item.name+"</td><td>"+item.date+"</td></tr>");
					});
				}
			});//ajax()
			
			// 클릭 이벤트를 한번만하고 종료
			$(this).unbind();
			
		});//click()
		
		// xml(extensible markup language)
		// 인터넷 웹페이지를 만드는 html을 획기적으로 개선하여 만든 언어
		// 디비에서 가져온 데이터를 태그형태로 데이터 표현
		// <members>
		//  <person><id>kim</id><pass>p123</pass><name>김길동</name></person>
		//  <person><id>lee</id><pass>p456</pass><name>이길동</name></person>
		// </members>
		
		// json (제이슨 : JavaScript Object Notation)
		// 웹과 컴퓨터 프로그램에서 용량이 적은 데이터를 교환하기 위해 
		// 데이터 객체를 속성 · 값의 쌍 형태로 표현하는 형식.
		// 자바스크립트(JavaScript) 토대로 개발되었다
		// 디비에서 가져온 데이터를 '속성' : '값' 형태로 데이터 표현
		// [
		//	{"id":"kim","pass":"p123","name":"김길동"},
		//	{"id":"lee","pass":"p456","name":"이길동"},
		//	{"id":"hong","pass":"p789","name":"홍길동"},
		// ]
		
		// 화면이 안바뀌면서 아이디 중복,아이디 사용가능 출력
		// join.me에서 idCheck.me 페이지로 갔다가 출력결과를 가지고
		// 다시와서 join.me 에서 결과 값을 출력
// 		ajax : 비동기식 자바스크립트 XML
//            (Asynchronous Javascript And XML)의 약자.

		
	});
</script>


</body>
</html>