<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String field = request.getParameter("field");
String search = request.getParameter("search");
String code = request.getParameter("code");
String mem_id = request.getParameter("id");

String sql = "select * from "+code+" where memberid = '"+mem_id+"'";

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = "";
String pass = "";
String name = "";
String nickname = "";
String email = "";
String level = "";

while (rs.next()) {
	id = rs.getString("memberid");
	pass = rs.getString("password");
	name = rs.getString("name");
	nickname = rs.getString("nickname");
	email = rs.getString("email");
	level = rs.getString("level");
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
	
	//nickname 중복체크
	function idCheck() {
		//새창 만들기
		window.open("idCheckForm.jsp", "idwin", "width=450, height=400");
	}
	
	//nickname 중복체크
	function nickCheck() {
		//새창 만들기
		window.open("nickCheckForm.jsp", "idwin", "width=450, height=400");
	}
</script>

<br>
<div class="join_title">'dodo' 수정하실 회원이 있으신가요?</div><br>
<div class="join_input">
	관리자 회원정보수정
</div><br>
<div class="board_list"></div>
<br>
<br>
<form action="join_update.jsp" method="post" onsubmit="return checkJoin()">
<div class="join_input">
	<div class="join_input">
<!-- 		아이디 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>아 이 디</b>
	 	<input style="margin-left: 57px" type="text" id="memberid" name="memberid" value="<%=id %>" class="input_style_3">
	 	<input type="button" onclick="idCheck()" value="중복확인" class="input_style_2">
<!-- 자식창에서 닉네임 중복확인 결과 전송 Y or N -->
		<input type="hidden" id="val" name="val">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이 름</b>
	 	<input style="margin-left: 75px" type="text" id="name2" name="name" value="<%=name %>" class="input_style_3">
	</div>
	<div class="join_input">
<!-- 		닉네임 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>닉 네 임</b>
	 	<input style="margin-left: 58px" type="text" id="nickname" name="nickname" value="<%=nickname %>" class="input_style_3">
	 	<input type="button" onclick="nickCheck()" value="중복확인" class="input_style_2">
<!-- 자식창에서 닉네임 중복확인 결과 전송 Y or N -->
		<input type="hidden" id="val1" name="val1">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>현재비밀번호</b>
	 	<input style="margin-left: 27px" type="text" id="pass0" name="pass0" value="<%=pass %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>새비밀번호</b>
	 	<input style="margin-left: 40px" type="password" id="pass1" name="pass1" class="input_style_3" placeholder="변경 할 비밀번호를 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호확인</b>
	 	<input style="margin-left: 27px" type="password" id="pass2" name="pass2" class="input_style_3" placeholder="비밀번호를 한번 더 입력하세요.">
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이메일주소</b>
	 	<input style="margin-left: 39px" type="email" id="email" name="email" value="<%=email %>"
	 		class="input_style_3">
	</div>
	<div class="join_input">
<!-- 	<img src="/images/heart.png" width=16>&nbsp;<b>레 벨</b> -->
 		<input type="hidden" style="margin-left: 75px" id="level" name="level" value="<%=level %>" class="input_style_3">
	</div>
</div>
<div class="join_input" style="margin-right: 170px;">
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="회원수정">>
		<input class="btn_style_4" type="reset" value="비우기">
	</div>
</div>
</form>
<form action="join_out_form.jsp?memberid=<%=id %>" method="post">
<div class="join_input">
	<div class="bt_wrap">
		<input class="btn_style_5" type="submit" value="강퇴처리">>
	</div>
</div>
</form>
<br>

<%@ include file="/admin/include/footer.jsp" %>