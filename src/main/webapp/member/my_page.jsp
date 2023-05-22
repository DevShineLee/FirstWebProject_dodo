<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

////////////////글 갯수
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
%>

<br>
<br>
<div class="join_title">[<%=session_id %>] 님의 마이페이지 입니다.</div><br>
<div class="join_input">
<br>
	회원정보를 수정하거나 나의 활동내역을 확인하세요.
</div>
<br>
<br>
<div class="board_list"></div>
<br>
<div class="my_page_title">
	<div class="my_page_list">
		<img src="/images/heart.png" width=20> 나의 회원 정보 수정하기
		<br>
		<br>
		<br>
		<br>
		<a href="join_up.jsp" ><button class="btn_style_3">수정하기</button></a>
	</div>
	<div class="my_page_list">
		<img src="/images/heart.png" width=20> 나의 활동 내역 보러가기
		<br><font size="3">	내가 쓴 글 : 총 <%=total_my_writing %> 개</font>
		<br><font size="3">	내가 쓴 댓글 : 총  <%=total_my_comment %> 개</font>
		<br>
		<br>
		<a href="my_writing.jsp"><button class="btn_style_4">상세보기</button></a>
	</div>
</div>
<br>
<div class="join_input">
	<div class="bt_wrap">
		<a href="/" class="on">홈으로</a>
	</div>
</div>
<br>
<br>
<%@ include file="/include/footer.jsp" %>