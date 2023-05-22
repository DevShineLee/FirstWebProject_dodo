<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("memberid");
String pass = request.getParameter("pass0");
String nickname = request.getParameter("nickname");
String name = request.getParameter("name2");
String email = request.getParameter("email");
String level = request.getParameter("level");

String sql = "select * from member where memberid = '"+id+"'";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {		//값을 불러오기
	pass = rs.getString("password");
	id = rs.getString("memberid");
	nickname = rs.getString("nickname");
	name = rs.getString("name");
	email = rs.getString("email");
	level = rs.getString("level");
}
%>

<br>
<div class="join_title"><%=id %>님을 정말 강퇴시키시겠어요? ㅠ.ㅠ</div><br>
<div class="join_input">
	관리자님의 비밀번호로 승인 해 주세요.
</div>
<br>
<div class="board_list"></div>
<br>
<br>
<form action="join_out.jsp" method="post" onsubmit="return joinOut()">
<div class="join_input">
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>아 이 디</b>
	 	<input style="margin-left: 57px" type="text" id="memberid" name="memberid" value="<%=id %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이 름</b>
	 	<input style="margin-left: 75px" type="text" id="name2" name="name" value="<%=name %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>닉 네 임</b>
	 	<input style="margin-left: 58px" type="text" id="nickname" name="nickname" value="<%=nickname %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>현재비밀번호</b>
	 	<input style="margin-left: 27px" type="text" id="pass0" name="pass0" value="<%=pass %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>이메일주소</b>
	 	<input style="margin-left: 39px" type="email" id="email" name="email" value="<%=email %>" class="input_style_3" readonly>
	</div>
	<div class="join_input">
 	<img src="/images/heart.png" width=16>&nbsp;<b>레 벨</b>
 		<input type="text" style="margin-left: 75px" id="level" name="level" value="<%=level %>" class="input_style_3" readonly>
	</div>
	<br>
	<div class="join_input">
	 	<img src="/images/heart.png" width=16>&nbsp;<b>관리자 승인</b>
	 	<input style="margin-left: 33px" type="password" id="admin_pass" name="admin_pass" class="input_style_3">
	 	<%
	 	String sql1 = "select * from member where memberid='0000'";
	 	Connection conn1 = DriverManager.getConnection(url, user, password);
	 	Statement stmt1 = conn1.createStatement();
	 	ResultSet rs1 = stmt1.executeQuery(sql1);
	 	
	 	String pass1 = "";
	 	if(rs1.next()) {
	 		pass1 = rs1.getString("password");
//	 		out.print("관리자DB비번:"+pass1+"<br>");
	 	}
	 	%>
	 	<script>
			function joinOut(){
				var pass = '<%=pass1%>';
				if(!admin_pass.value){
					alert("비밀번호를 입력하세요.");
					admin_pass.focus();
					return false;		
				}
				if(admin_pass.value != pass){
					alert("비밀번호가 틀렸습니다.");
					admin_pass.focus();
					return false;
				}
				document.submit();
			}
		</script>
	</div>
<div class="join_input" style="margin-right: 170px;">
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="강퇴처리">>
		<a href="/admin/" class="off">그냥두기</a>
	</div>
</div>
</div>
</form>
<br>

<%@ include file="/admin/include/footer.jsp" %>