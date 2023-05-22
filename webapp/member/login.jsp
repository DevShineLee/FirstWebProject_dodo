<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<% request.setCharacterEncoding("utf-8"); %>
<script>
	function checkNull(){
		if(!memberid.value){
			alert("아이디를 입력하세요.");
			memberid.focus();
			return false;		
		}
		if(!password.value){
			alert("비밀번호를 입력하세요.");
			password.focus();
			return false;		
		}
		return true;
	}
</script>

<br>
	<div class="join_title">'dodo' 에 놀러오셨군요!</div><br>
	<div class="join_input">
		로그인 정보를 입력 해 주세요.
	</div><br>
	<div class="board_list"></div>
<br>
<br>
<form action="/member/login_ok.jsp" method="post" onsubmit="return checkNull();">
<div class="join_input">
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>아 이 디</b>
	 	<input style="margin-left: 55px" type="text" id="memberid" name="memberid" value=""
	 		class="input_style_4" placeholder="ID를 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호</b>
	 	<input style="margin-left: 52px" type="password" id="password" name="password" value=""
	 		class="input_style_4" placeholder="비밀번호를 입력하세요.">
	</div>
</div>
<div class="join_input">
	<div class="bt_wrap">
		<input type="hidden" hidden="hidden">	<!-- 엔터로 넘어가는거 방지 -->
		<input class="btn_style_3" type="submit" value="로그인">>
		<a href="/" class="off">홈으로</a>
	</div>
</div>
</form>
<br>
<%@ include file="/include/footer.jsp" %>