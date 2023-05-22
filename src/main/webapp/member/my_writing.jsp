<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//////페이징
int page_now = 1;	//현재 페이지 값
if(request.getParameter("page_now") != null){
page_now = Integer.parseInt(request.getParameter("page_now"));
}

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

//현재 시간
String today2 = "";
String today3 = "";
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = sf.format(nowTime);
today2 = today.substring(11,19);
today3 = today.substring(0,10);
%>
	
<div class="join_title2">[<%=session_id %>] 님의 활동내역입니다.</div><br>
<div class="join_input">
	빠르게 내가 쓴 글이나 댓글 페이지로 이동하세요.
</div>
<br>
<div class="board_list"></div>
<br>
<div class="my_writing_wrap">
	<h2 class="my_writing_title">내가 쓴 글 ★ 총 <b><%=total_my_writing %></b> 개</h2>
	<div class="my_writing_list2">
		<div class="num">번호</div>
		<div class="sub">글제목</div>
		<div class="date">날짜</div>
	</div>
	<div class="my_writing_list">
		<%
			String sql_1 = "(select * from free where id='"+session_id+"') union (select * from gallery where id='"+session_id+"') union (select * from qna where id='"+session_id+"') union (select * from notice where id='"+session_id+"') order by signdate desc";
			Connection conn_1 = DriverManager.getConnection(url, user, password);
			Statement stmt_1 = conn.createStatement();
			ResultSet rs_1 = stmt.executeQuery(sql_1);
			
			String today_db = "";
			while(rs_1.next()){
				int uid = rs_1.getInt("uid");
				String subject = rs_1.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 10){
						subject = subject.substring(0,10) + ".....";
					}else{
						subject = subject;
					}
				today_db = rs_1.getString("signdate");
				String code = rs_1.getString("table_name");
		%>
		<div class="num">
			<%=uid %>
		</div>
		<div class="sub">
		<%
		if(code.equals("notice")) { %>
			<a href="/notice/view.jsp?code=notice&uid=<%=uid%>">[공 지] <%=subject %></a>
		<%}else if(code.equals("free")) {%>
			<a href="/free/view.jsp?code=free&uid=<%=uid%>">[자 유] <%=subject %></a>
		<%}else if(code.equals("gallery")) {%>
			<a href="/gallery/view.jsp?code=gallery&uid=<%=uid%>">[갤러리] <%=subject %></a>
		<%}else if(code.equals("qna")) {%>
			<a href="/qna/view.jsp?code=qna&uid=<%=uid%>">[Q&A] <%=subject %></a>
		<%}else{ %>
			<a href=""><%=subject %></a>
		<%} %>
		</div>
		<div class="date">
			<%
			String today1 = today_db.substring(0,10);
            if(today3.equals(today1)){ 
				String today4 = today_db.substring(11,19);%>
				<%=today4 %>
			<%}else{ %>
				<%=today1 %>
			<%}%>  
		</div>
		<%} %>
	</div>
</div>
<div class="my_writing_wrap">
	<h2 class="my_writing_title">내가 쓴 댓글 ★ 총 <b><%=total_my_comment %></b> 개</h2>
	<div class="my_writing_list2">
		<div class="num">번호</div>
		<div class="sub">댓글내용</div>
		<div class="date">날짜</div>
	</div>
	<div class="my_writing_list">
		<%
			String sql_2 = "(select * from comment_f where tb_id='"+session_id+"') union (select * from comment_g where tb_id='"+session_id+"') union (select * from comment_q where tb_id='"+session_id+"') union (select * from comment where tb_id='"+session_id+"') order by tb_date desc";
			Connection conn_2 = DriverManager.getConnection(url, user, password);
			Statement stmt_2 = conn.createStatement();
			ResultSet rs_2 = stmt.executeQuery(sql_2);
			
			String today_db2 = "";
			while(rs_2.next()){
				int uid2 = rs_2.getInt("tb_uid");
				int uid3 = rs_2.getInt("uid");
				String comment = rs_2.getString("tb_comment");
					int len_comment = comment.length(); //제목 길이
					if(len_comment >= 10){
						comment = comment.substring(0,10) + ".....";
					}else{
						comment = comment;
					}
				today_db2 = rs_2.getString("tb_date");
				String code2 = rs_2.getString("tb_table");
		%>
		<div class="num">
			<%=uid3 %>
		</div>
		<div class="sub">
					<%
		if(code2.equals("notice")) { %>
			<a href="/notice/view.jsp?code=notice&uid=<%=uid2%>"> [공 지] <%=comment %></a>
		<%}else if(code2.equals("free")) {%>
			<a href="/free/view.jsp?code=free&uid=<%=uid2%>"> [자 유] <%=comment %></a>
		<%}else if(code2.equals("gallery")) {%>
			<a href="/gallery/view.jsp?code=gallery&uid=<%=uid2%>"> [갤러리] <%=comment %></a>
		<%}else if(code2.equals("qna")) {%>
			<a href="/qna/view.jsp?code=qna&uid=<%=uid2%>"> [Q&A] <%=comment %></a>
		<%}else{ %>
			<a href=""><%=comment %></a>
		<%} %>
		</div>
		<div class="date">
			<%
			String today5 = today_db2.substring(0,10);
            if(today3.equals(today5)){ 
				String today6 = today_db2.substring(11,19);%>
				<%=today6 %>
			<%}else{ %>
				<%=today5 %>
			<%}%>
		</div>
		<%} %>
	</div>
</div>
<br>
<div class="bt_wrap">
	<a href="/" class="on">홈으로</a>
</div>
<br>
<%@ include file="/include/footer.jsp" %>