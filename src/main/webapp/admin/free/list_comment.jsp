<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String page_now = "";
if(request.getParameter("page_now") != null && !request.getParameter("page_now").equals("")){
	page_now = request.getParameter("page_now");
}else{
	page_now = "1";
}

String code2;			//댓글테이블
if(request.getParameter("code2") != null){
	code2 = request.getParameter("code2");		//현재 자기자신 페이지에서->자기 자신페이지로 넘겨줄때도 request를 쓴다!
}else{
	code2 = "";
}

///////////////////댓글 갯수
String sql_3 = "";

if(code2 != null && code2 != ""){
	sql_3 = "select count(*) as total2 from "+code2+"";
}else{
	sql_3 = "SELECT SUM(total) as total2 FROM ( SELECT COUNT(*) as total FROM comment_f UNION ALL SELECT COUNT(*) as total FROM comment_g UNION ALL SELECT COUNT(*) as total FROM comment_q UNION ALL SELECT COUNT(*) as total FROM comment) total2";
}
Connection conn_3 = DriverManager.getConnection(url, user, password);
Statement stmt_3 = conn_3.createStatement();
ResultSet rs_3 = stmt_3.executeQuery(sql_3);

int total_my_comment = 0;

if(rs_3.next()){
	total_my_comment = rs_3.getInt("total2");
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

<div class="join_title2">댓글 관리 페이지입니다.</div><br>
<div class="join_input">
	빠르게 간편하게 해당 댓글을 처리하세요.
</div>
<br>
<div class="board_list"></div>
<br>
<div class="admin_writing_wrap">
	<h2 class="admin_writing_title">전체 게시판 댓글 ★ 총 <b><%=total_my_comment %></b> 개</h2>
	<div class="admin_writing_list">
		<div class="num">번호</div>
		<div class="cat">
<!-- 			요거 요거 어렵다ㅠㅠㅠㅠ -->
			<select name="selectbox" onchange="location='list_comment.jsp?code2='+this.value;">
				<option value="" <%if(code2.equals("")){%>selected<%} %>>모 두</option>
				<option value="comment" <%if(code2.equals("comment")){%>selected<%} %>>[공 지]</option>
				<option value="comment_f" <%if(code2.equals("comment_f")){%>selected<%} %>>[자 유]</option>
				<option value="comment_g" <%if(code2.equals("comment_g")){%>selected<%} %>>[갤러리]</option>
				<option value="comment_q" <%if(code2.equals("comment_q")){%>selected<%} %>>[Q&A]</option>
			</select>
		</div>	
		<div class="sub">댓글내용</div>
		<div class="date">날짜</div>
		<div class="check">수정</div>
		<div class="del">삭제</div>
	</div>
	<div class="admin_writing_list2">
		<%
			String sql_2;
			String c_table = "";
			
			if(code2 != null && code2 != ""){
				sql_2 = "select * from "+code2+" order by tb_date desc";
//				out.print(sql_2);
			}else{
				sql_2 = "(select * from comment_f) union (select * from comment_g) union (select * from comment_q) union (select * from comment) order by tb_date desc";
			}
			Connection conn_2 = DriverManager.getConnection(url, user, password);
			Statement stmt_2 = conn_2.createStatement();
			ResultSet rs_2 = stmt_2.executeQuery(sql_2);
			//out.print(sql_2);
			
			String today_db2 = "";
			while(rs_2.next()){
				String uid2 = rs_2.getString("tb_uid");
				String uid3 = rs_2.getString("uid");
				String comment = rs_2.getString("tb_comment");
					int len_comment = comment.length(); //제목 길이
					if(len_comment >= 25){
						comment = comment.substring(0,25) + ".....";
					}else{
						comment = comment;
					}
				today_db2 = rs_2.getString("tb_date");
				c_table = rs_2.getString("tb_table");
		%>
		<div class="num">
			<%=uid3 %>
		</div>
		<div class="cat">
			<%if(c_table.equals("notice")) { %>
				[공 지]
			<%}else if(c_table.equals("free")) {%>
				[자 유]
			<%}else if(c_table.equals("gallery")) {%>
				[갤러리]
			<%}else if(c_table.equals("qna")) {%>
				[Q&A]
			<%}%>
		</div>
		<div class="sub">
			<a href="/<%=c_table%>/view.jsp?code=<%=c_table%>&uid=<%=uid2%>&c_uid=<%=uid3%>&page_now=1"><%=comment %></a>
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
		<div class="check">
			<a href="/<%=c_table%>/comment_modify.jsp?code=<%=c_table%>&uid=<%=uid2%>&c_uid=<%=uid3%>&page_now=<%=page_now%>"><input class="btn_style_6" id="" type="button" value="수정"></a>
		</div>
		<div class="del">
			<a href="/<%=c_table%>/comment_delete.jsp?code=<%=c_table%>&uid=<%=uid2%>&c_uid=<%=uid3%>&page_now=<%=page_now%>"><input class="btn_style_6" id="" type="button" value="X"></a>
		</div>
		<%} //while 닫음%>
	</div>
</div>
<br>
<div class="bt_wrap">
	<a href="/" class="on">홈으로</a>
	<a href="list.jsp" class="off">글관리</a>
</div>
<br>
<%@ include file="/admin/include/footer.jsp" %>