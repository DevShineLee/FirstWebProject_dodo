<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String sql = "select * from member2 where memberid = '" + session_id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String mem_id = "";
String mem_pass = "";
String mem_name = "";
String mem_nickname = "";
String mem_email = "";
String mem_level = "";

while (rs.next()) {
	mem_id = rs.getString("memberid");
	mem_pass = rs.getString("password");
	mem_name = rs.getString("name");
	mem_nickname = rs.getString("nickname");
	mem_email = rs.getString("email");
	mem_level = rs.getString("level");
}
%>

<script>
	function checkJoin(){
		if(pass1.value != pass2.value){
			alert("비밀번호가 일치하지 않습니다.");
			pass2.focus();
			return false;
		}
		document.submit();
	}
</script>

<br>
<div class="join_title">'dodo' 수정하실 정보가 있으신가요?</div><br>
<div class="join_input">
	회원정보수정
</div><br>
<div class="board_list"></div>
<br>
<br>
<form action="join_update.jsp" method="post" onsubmit="return checkJoin()">
<div class="join_input">
	<div class="join_input">
<!-- 		아이디 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>아 이 디</b>
	 	<input style="margin-left: 57px" type="text" id="memberid" name="memberid" value="<%=mem_id %>"
	 		readonly class="input_style_3">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이 름</b>
	 	<input style="margin-left: 75px" type="text" id="name2" name="name" value="<%=mem_name %>"
	 		readonly class="input_style_3">
	</div>
	<div class="join_input">
<!-- 		닉네임 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>닉 네 임</b>
	 	<input style="margin-left: 58px" type="text" id="nickname" name="nickname" value="<%=mem_nickname %>"
	 		readonly class="input_style_3" >
	 	<input type="button" onclick="return validation()" value="중복확인" class="input_style_2">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>현재비밀번호</b>
	 	<input style="margin-left: 27px" type="text" id="pass0" name="pass0" value="<%=mem_pass %>" readonly class="input_style_3">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>새비밀번호</b>
	 	<input style="margin-left: 40px" type="password" id="pass1" name="pass1" value=""
	 		class="input_style_3" placeholder="변경 할 비밀번호를 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호확인</b>
	 	<input style="margin-left: 27px" type="password" id="pass2" name="pass2" value="" 
	 		class="input_style_3" placeholder="비밀번호를 한번 더 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이메일주소</b>
	 	<input style="margin-left: 40px" type="email" id="email" name="email" value="<%=mem_email %>"
	 		class="input_style_3">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>레 벨</b>
	 	<%if(session_level != null && session_level.equals("10")){ %>
	 		<input style="margin-left: 75px" id="level" name="level" value="<%=mem_level %>" class="input_style_3">
		<%}else{ %>
	 		<input style="margin-left: 75px" id="level" name="level" value="<%=mem_level %>" readonly class="input_style_3">
		<%} %>
	</div>
</div>
<div class="join_input" style="margin-right: 170px;">
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="회원수정">>
		<input class="btn_style_4" type="reset" value="비우기">
	</div>
</div>
</form>
<form action="join_out_form.jsp" method="post">
<div class="join_input">
	<div class="bt_wrap">
		<input class="btn_style_5" type="submit" value="회원탈퇴">>
	</div>
</div>
</form>
<br>

<%@ include file="/include/footer.jsp" %>