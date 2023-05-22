<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String pass = request.getParameter("password");

String sql = "select * from member2 where memberid = '"+session_id+"'";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {		//값을 불러오기
	pass = rs.getString("password");
}
%>

<script>
	function joinOut(){
		var pass = '<%=pass%>';
		if(!pass1.value){
			alert("비밀번호를 입력하세요.");
			pass1.focus();
			return false;		
		}
		if(pass1.value != pass){
			alert("비밀번호가 틀렸습니다.");
			pass1.focus();
			return false;
		}
		document.submit();
	}
</script>

<br>
<div class="join_title">'dodo' 를 정말 떠나시려구요? ㅠ.ㅠ</div><br>
<div class="join_input">
	정말 탈퇴하시려면 비밀번호를 입력해주세요.
</div>
<br>
<div class="board_list"></div>
<br>
<br>
<form action="join_out.jsp" method="post" onsubmit="return joinOut()">
<div class="join_input">
	<div class="join_input">
<!-- 		아이디 중복확인 추가 -->
	 	<img src="/images/heart.png" width=16>&nbsp;<b>
	 	&nbsp;&nbsp; ID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=session_id%></b>
	</div>
	<br>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>비밀번호</b>
	 	<input style="margin-left: 50px" type="password" id="pass1" name="pass1" class="input_style_3" placeholder="비밀번호를 입력해주세요">
	</div>
<div class="join_input" style="margin-right: 170px;">
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="떠나기">>
		<a href="/" class="off">계속있기</a>
	</div>
</div>
</div>
</form>
<br>

<%@ include file="/include/footer.jsp" %>