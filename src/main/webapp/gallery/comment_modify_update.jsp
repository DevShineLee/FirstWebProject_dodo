<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String c_uid = request.getParameter("c_uid");
String comment = request.getParameter("comment_modify");	//이전 파일(넘겨받은 파일)에서 쓰던 변수(인풋name) 넘겨받으면 됨.
String page_now = request.getParameter("page_now");
String field = request.getParameter("field");
String search = request.getParameter("search");

//현재시간
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String today = sf.format(nowTime);

String sql = "update comment_g set tb_comment='"+comment+"' where uid="+c_uid;

//out.print(sql);
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>";
</script>