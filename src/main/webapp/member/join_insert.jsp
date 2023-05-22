<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//String 변수이름 = request.getParameter("input의 name값");
String id = request.getParameter("memberid");
String pass = request.getParameter("password");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String level = request.getParameter("level");

String sql = "insert into member values('"+id+"', '"+pass+"', '"+name+"', '"+nickname+"', '"+email+"', '"+level+"')";
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
%>

<br>
<div class="join_title"> <%=nickname %>님! 'dodo' 회원이 되신것을 축하합니다</div><br>
<div class="join_input">
	활동을 열심히 하시면 레벨이 올라갑니다!<br>
	현재 레벨 : <%=level%>
</div><br>
<div class="join_input">
	<div class="bt_wrap">
		<a href="login.jsp" class="on">로그인하기</a>
		<a href="/" class="off">홈으로</a>
	</div>
</div>
<br>

<%@ include file="/include/footer.jsp" %>

<%-- id : <%=id%> <br> --%>
<%-- pass : <%=pass%> <br> --%>
<%-- name : <%=name%> <br> --%>
<%-- email : <%=email%> <br> --%>
<%-- level : <%=level%> <br> --%>