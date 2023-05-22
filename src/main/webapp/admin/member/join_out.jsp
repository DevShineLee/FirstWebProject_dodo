<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String id = request.getParameter("memberid");

String sql = "delete from member where memberid='"+id+"'";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt= conn.createStatement();
stmt.executeUpdate(sql);
//out.print(sql);
%>

<script>
	alert("강퇴처리 되었습니다.");
	location.href="/admin/";
</script>














