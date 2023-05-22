<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
session.invalidate();
%>

<script>
	alert("내일 또 오실거죠?");
	location.href = "/";
</script>
