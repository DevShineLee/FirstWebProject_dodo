<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

///////////////////글 갯수
int total_my_writing = 0;

String sql = "SELECT SUM(total) FROM ( SELECT COUNT(*) as total FROM free where id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM gallery where id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM qna where id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM notice where id='"+session_id+"') total"; //7줄 까지만 불러오기
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
if(rs.next()){
	total_my_writing = rs.getInt("SUM(total)");
}

///////////////////댓글 갯수
int total_my_comment = 0;

String sql2 = "SELECT SUM(total) FROM ( SELECT COUNT(*) as total FROM comment_f where tb_id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM comment_g where tb_id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM comment_q where tb_id='"+session_id+"' UNION ALL SELECT COUNT(*) as total FROM comment where tb_id='"+session_id+"') total"; //7줄 까지만 불러오기
Connection conn2 = DriverManager.getConnection(url, user, password);
Statement stmt2 = conn.createStatement();
ResultSet rs2 = stmt.executeQuery(sql2);
if(rs2.next()){
	total_my_comment = rs2.getInt("SUM(total)");
}

String code = request.getParameter("code");
%>
	
<div class="join_title2">[<%=session_id %>] 님의 활동내역입니다.</div><br>
<div class="join_input">
	빠르게 내가 쓴 글이나 댓글 페이지로 이동하세요.
</div>
<br>
<div class="board_list"></div>
<br>
<div class="my_writing_wrap">
	<h2 class="my_writing_title">내가 쓴 글 ★ 총 <%=total_my_writing %> 개</h2>
	<div class="my_writing_list">
		<div class="cat">
			<select>
				<option>모두</option>
				<option>자유</option>
				<option>갤러리</option>
				<option>qna</option>
			</select>
		</div>
		<div class="num">번호</div>
		<div class="sub">글제목</div>
		<div class="date">날짜</div>
	</div>
	<div class="my_writing_list">
		<%
			String sql_1 = "select * from free where id='"+session_id+"' union select * from gallery where id='"+session_id+"' union select * from qna where id='"+session_id+"' union select * from notice where id='"+session_id+"'";
			Connection conn_1 = DriverManager.getConnection(url, user, password);
			Statement stmt_1 = conn.createStatement();
			ResultSet rs_1 = stmt.executeQuery(sql_1);
			while(rs_1.next()){
				int uid = rs_1.getInt("uid");
				String subject = rs_1.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 10){
						subject = subject.substring(0,10) + ".....";
					}else{
						subject = subject;
					}
				String date = rs_1.getString("signdate").substring(0,10);
		%>
		<div class="cat">
			모두
		</div>
		<div class="num">
			<%=uid %>
		</div>
		<div class="sub">
			<a href=""><%=subject %></a>
		</div>
		<div class="date">
			<%=date %>
		</div>
		<%} %>
	</div>
</div>
<div class="my_writing_wrap">
	<h2 class="my_writing_title">내가 쓴 댓글 ★ 총 <%=total_my_comment %> 개</h2>
	<div class="my_writing_list">
		<div class="cat">
			<select>
				<option>모두</option>
				<option>자유</option>
				<option>갤러리</option>
				<option>qna</option>
			</select>
		</div>
		<div class="num">번호</div>
		<div class="sub">댓글내용</div>
		<div class="date">날짜</div>
	</div>
	<div class="my_writing_list">
		<%
			String sql_2 = "select * from comment_f where tb_id='"+session_id+"' union select * from comment_g where tb_id='"+session_id+"' union select * from comment_q where tb_id='"+session_id+"' union select * from comment where tb_id='"+session_id+"'";
			Connection conn_2 = DriverManager.getConnection(url, user, password);
			Statement stmt_2 = conn.createStatement();
			ResultSet rs_2 = stmt.executeQuery(sql_2);
			while(rs_2.next()){
				int uid2 = rs_2.getInt("uid");
				String comment = rs_2.getString("tb_comment");
					int len_comment = comment.length(); //제목 길이
					if(len_comment >= 10){
						comment = comment.substring(0,10) + ".....";
					}else{
						comment = comment;
					}
				String date2 = rs_2.getString("tb_date").substring(0,10);
		%>
		<div class="cat">
			모두
		</div>
		<div class="num">
			<%=uid2 %>
		</div>
		<div class="sub">
			<a href=""><%=comment %></a>
		</div>
		<div class="date">
			<%=date2 %>
		</div>
		<%} %>
	</div>
</div>
<br>
<div class="my_writing_null"></div>
<div class="join_input">
	<div class="bt_wrap">
		<a href="/" class="on">홈으로</a>
	</div>
</div>
<br>
<br>
<%@ include file="/include/footer.jsp" %>