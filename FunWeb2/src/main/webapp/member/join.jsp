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
<article>
<h1>Join Us</h1>
<form action="insertPro.me" id="join" method="post">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id">
<input type="button" value="dup. check" class="dup"><br>
<label></label>
<div class="divdup"></div>
<br>

<label>Password</label>
<input type="password" name="pass" class="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2"><br>
<label>Name</label>
<input type="text" name="name" class="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<input type="text" name="address"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
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
// 		id="join" 폼을 전송했을때
		$('#join').submit(function(){
// 			alert("동작");
//          class="id"  value 비어있으면
			if($('.id').val()==""){
				// 아이디 입력하세요
				alert("아이디 입력하세요");
				$('.id').focus();
				//submit버튼이 동작하지 못하게 막음
				return false;
			}
			if($('.pass').val()==""){
				alert("비밀번호를 입력하세요");
				$('.pass').focus();
				return false;
			}
			if($('.name').val()==""){
				alert("이름을 입력하세요");
				$('.name').focus();
				return false;
			}
		}); // submit event

		// class="dup" 버튼 클릭 시 
		$('.dup').click(function() {
			// alert("클릭");
			$.ajax({
				url:'idCheck.me',
				// 파라미터이름 : val() 값
				data:{'id':$('.id').val()},
				success:function(result){					
					// result 아이디 중복, 아이디 사용 가능 결과 받아오는 변수
					// class="divdup" 안에 아이디 중복 값을 넣기
					$('.divdup').html(result);
				}
			});//ajax()
			
		});//click()
		// 화면이 안바뀌면서 아이디 중복/사용 가능 출력
		// join.me에서 idCheck.me 페이지로 갔다가 출력결과를 가지고 
		// 다시 와서 join.me에서 결과값 출력
		// ajax : 비동기식 자바스크립트 XML
		//    		(Asynchronous Javascript And XML) 의 약자
		
		
	});
</script>


</body>
</html>