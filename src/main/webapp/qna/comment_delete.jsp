<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String page_now = request.getParameter("page_now");
String c_uid = request.getParameter("c_uid");

String sql = "delete from comment_q where uid="+c_uid+"";
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
//out.print(sql);
stmt.executeUpdate(sql);

%>

<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>";
</script>
