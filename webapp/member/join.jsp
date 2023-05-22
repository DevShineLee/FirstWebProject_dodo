<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
	function checkJoin(){
		if(!memberid.value){
			alert("아이디를 입력하세요.");
			memberid.focus();
			return false;		
		}
		if(memberid.value.length < 4 ){
			alert("아이디를 4자리 이상 입력하세요.");
			memberid.focus();
			return false;		
		}
		if(!password.value){
			alert("비밀번호를 입력하세요.");
			password.focus();
			return false;		
		}
		if(password.value.length < 4){
			alert("비밀번호를 4자리 이상 입력하세요.");
			password.focus();
			return false;
		}
		if(!password2.value){
			alert("비밀번호를 재입력하세요.");
			password2.focus();
			return false;		
		}
		if(password.value != password2.value){
			alert("비밀번호가 일치하지 않습니다.");
			password.focus();
			return false;
		}
		if(!nickname.value){
			alert("닉네임을 입력하세요.");
			nickname.focus();
			return false;		
		}
		if(nickname.value.length > 5 ){
			alert("닉네임을 5글자 이하로 입력하세요.");
			nickname.focus();
			return false;		
		}
		if(!name2.value){
			alert("이름을 입력하세요.");
			name2.focus();
			return false;		
		}
		if(!email.value){
			alert("메일주소를 입력하세요.");
			email.focus();
			return false;		
		}
		document.submit();
	}
	
	//id 중복체크 
	function idCheck(){ 
		//새창 만들기 
		window.open("idCheckForm.jsp", "idwin", "width=400, height=350"); } 
	//email 중복체크 
	function emailCheck(){ 
		//새창 만들기 window.open("emailCheckForm.jsp", "emailwin", "width=400, height=350"); }
	//emailCheck() end
</script>

<br>
<div class="join_title">'dodo' 회원가입을 환영합니다 !</div><br>
<div class="join_input">
	다양한 반려동물 정보와 일상을 공유해보세요.
</div>
<br>
<div class="board_list"></div>
<br>
<br>
<form action="join_insert.jsp" method="post" onsubmit="return checkJoin()">
<div class="join_input">
	<div class="join_input">
<!-- 		아이디 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>아 이 디</b>
	 	<input style="margin-left: 57px" type="text" id="memberid" name="memberid" value=""
	 		class="input_style_3" placeholder="ID는 변경할수 없으니 신중히 입력하세요.">
	 	<input type="button" onclick="idCheck()" value="중복확인" class="input_style_2">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이 름</b>
	 	<input style="margin-left: 75px" type="text" id="name2" name="name" value=""
	 		class="input_style_3" placeholder="이름을 입력하세요.">
	</div>
	<div class="join_input">
<!-- 		닉네임 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>닉 네 임</b>
	 	<input style="margin-left: 58px" type="text" id="nickname" name="nickname" value=""
	 		class="input_style_3" placeholder="닉네임은 변경할수 없으니 신중히 입력하세요.">
	 	<input type="button" onclick="return validation()" value="중복확인" class="input_style_2">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호</b>
	 	<input style="margin-left: 54px" type="password" id="password" name="password" value=""
	 		class="input_style_3" placeholder="비밀번호를 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호확인</b>
	 	<input style="margin-left: 27px" type="password" id="password2" name="password2" value="" 
	 		class="input_style_3" placeholder="비밀번호를 한번 더 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이메일주소</b>
	 	<input style="margin-left: 39px" type="email" id="email" name="email" value=""
	 		class="input_style_3" placeholder="메일주소를 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>레 벨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</b>
	 	<input type="hidden" style="margin-left: 75px" id="level" name="level" value="1" class="input_style_3">
	</div>
</div>
<div class="join_input">
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="회원가입">>
		<input class="btn_style_4" type="reset" value="비우기">
	</div>
</div>
</form>
<br>

<%@ include file="/include/footer.jsp" %>