<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/admin/include/header.jsp" %>

<%
String sql = "SELECT SUM(total) as total FROM ( SELECT COUNT(*) as total FROM free UNION ALL SELECT COUNT(*) as total FROM gallery UNION ALL SELECT COUNT(*) as total FROM qna UNION ALL SELECT COUNT(*) as total FROM notice) total";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

int total_my_writing = 0;
if(rs.next()){
	total_my_writing = rs.getInt("total");
}


String sql_3 = "SELECT SUM(total) as total2 FROM ( SELECT COUNT(*) as total FROM comment_f UNION ALL SELECT COUNT(*) as total FROM comment_g UNION ALL SELECT COUNT(*) as total FROM comment_q UNION ALL SELECT COUNT(*) as total FROM comment) total2";
Connection conn_3 = DriverManager.getConnection(url, user, password);
Statement stmt_3 = conn_3.createStatement();
ResultSet rs_3 = stmt_3.executeQuery(sql_3);

int total_my_comment = 0;
if(rs_3.next()){
	total_my_comment = rs_3.getInt("total2");
}

%>
<div class="admin_index">
	<br>
	<br>
	<h2>게시판 관리 페이지입니다.</h2>
	 &nbsp;현재까지 도도 내의<br>
	 &nbsp;총 게시글은 [ <%=total_my_writing %> ] 개,<br>
	 &nbsp;총 댓글은 [ <%=total_my_comment %> ] 개 입니다.
	<br>
</div>
<div class="admin_main2" >
	<img src="img/pen.png" width=220>
</div>
<br>
<br>
<div class="join_input">
	<div class="bt_wrap">
		<a href="list.jsp" class="on">글관리</a>
		<a href="list_comment.jsp" class="off">댓글관리</a>
	</div>
	<br>
</div>
<%@ include file="/admin/include/footer.jsp" %>