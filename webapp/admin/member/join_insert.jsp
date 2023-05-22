<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");

//String 변수이름 = request.getParameter("input의 name값");
String id = request.getParameter("memberid");
String pass = request.getParameter("password");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String level = request.getParameter("level");

String sql = "insert into member2 values('"+id+"', '"+pass+"', '"+name+"', '"+nickname+"', '"+email+"', '"+level+"')";
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
%>

<br>
<div class="join_title"> <%=nickname %>님 회원가입 직권처리 완료.</div><br>
<div class="join_input">
	아이디 : <%=id%><br>
	이름 : <%=name%><br>
	닉네임 : <%=nickname%><br>
	비밀번호 : <%=pass%><br>
	메일주소 : <%=email%><br>
	현재 레벨 : <%=level%><br>
</div><br>
<div class="join_input">
	<div class="bt_wrap">
		<a href="/admin/member/list.jsp?code=<%=code %>" class="on">회원목록</a>
		<a href="/" class="off">홈으로</a>
	</div>
</div>
<br>

<%@ include file="/admin/include/footer.jsp" %>

<%-- id : <%=id%> <br> --%>
<%-- pass : <%=pass%> <br> --%>
<%-- name : <%=name%> <br> --%>
<%-- email : <%=email%> <br> --%>
<%-- level : <%=level%> <br> --%>