<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
session.invalidate();

String sql = "delete from member2 where memberid='"+session_id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt= conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("더이상 회원이 아닙니다.");
	location.href="/";
</script>














