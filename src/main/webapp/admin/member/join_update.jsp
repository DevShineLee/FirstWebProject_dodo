<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("memberid");	//변경불가
String pass1 = request.getParameter("pass1");
String pass2 = request.getParameter("pass2");
String name = request.getParameter("name");		//변경불가
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String level = request.getParameter("level");

String sql = "";
if(!pass1.equals("") && !pass2.equals("") && pass1.equals(pass2)){
	sql = "update member set name = '"+name+"', nickname = '"+nickname+"', password = '"+pass1+"',email = '"+email+"', level = '"+level+"' where memberid = '"+id+"'";
}else{
	sql = "update member set name = '"+name+"', nickname = '"+nickname+"', email = '"+email+"', level = '"+level+"' where memberid = '"+id+"'";
}

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("성공적으로 수정되었어요.");
	location.href = "/admin/";
</script>

<%-- id : <%=id%><br> --%>
<%-- pass : <%=pass1%><br> --%>
<%-- name : <%=name%><br> --%>
<%-- name : <%=nickname%><br> --%>
<%-- email : <%=email%><br> --%>
<%-- level : <%=level%><br> --%>