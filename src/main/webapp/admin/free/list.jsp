<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code;			//게시판테이블
if(request.getParameter("code") != null){
	code = request.getParameter("code");		//현재 자기자신 페이지에서->자기 자신페이지로 넘겨줄때도 request를 쓴다!
}else{
	code = "";
}

String page_now = "";
if(request.getParameter("page_now") != null && !request.getParameter("page_now").equals("")){
	page_now = request.getParameter("page_now");
}else{
	page_now = "1";
}

///////////////////글 갯수
String sql = "";
if(code != null && code != ""){
	sql = "select count(*) as total from "+code+"";
}else{
	sql = "SELECT SUM(total) as total FROM ( SELECT COUNT(*) as total FROM free UNION ALL SELECT COUNT(*) as total FROM gallery UNION ALL SELECT COUNT(*) as total FROM qna UNION ALL SELECT COUNT(*) as total FROM notice) total";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
//out.print(sql);
int total_my_writing = 0;

if(rs.next()){
	total_my_writing = rs.getInt("total");
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

<div class="join_title2">게시글 관리 페이지입니다.</div><br>
<div class="join_input">
	빠르고 간편하게 해당 게시글을 처리하세요.
</div>
<br>
<div class="board_list"></div>
<br>
<div class="admin_writing_wrap">
	<h2 class="admin_writing_title">전체 게시판 글 수 ★ 총 <b><%=total_my_writing %></b> 개</h2>
	<div class="admin_writing_list">
		<div class="num">번호</div>
		<div class="cat">
<!-- 			요거 요거 어렵다ㅠㅠㅠㅠ -->
			<select name="selectbox" onchange="location='list.jsp?code='+this.value;">
				<option value="" <%if(code.equals("")){%>selected<%} %>>모 두</option>
				<option value="notice" <%if(code.equals("notice")){%>selected<%} %>>[공 지]</option>
				<option value="free" <%if(code.equals("free")){%>selected<%} %>>[자 유]</option>
				<option value="gallery" <%if(code.equals("gallery")){%>selected<%} %>>[갤러리]</option>
				<option value="qna" <%if(code.equals("qna")){%>selected<%} %>>[Q&A]</option>
			</select>
		</div>		
		<div class="sub">글제목</div>
		<div class="date">날짜</div>
		<div class="check">수정</div>
		<div class="del">삭제</div>
	</div>
	<div class="admin_writing_list2">
		<%
			String sql_1;
		
			if(code != null && code != ""){
				sql_1 = "select * from "+code+" order by signdate desc";
			}else{
				sql_1 = "(select * from free) union (select * from gallery) union (select * from qna) union (select * from notice) order by signdate desc";
			}
			Connection conn_1 = DriverManager.getConnection(url, user, password);
			Statement stmt_1 = conn.createStatement();
			ResultSet rs_1 = stmt.executeQuery(sql_1);
			
			String today_db = "";
			while(rs_1.next()){
				String uid = rs_1.getString("uid");
				String subject = rs_1.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 25){
						subject = subject.substring(0,25) + ".....";
					}else{
						subject = subject;
					}
				today_db = rs_1.getString("signdate");
				code = rs_1.getString("table_name");		// 이거는 게시판 유형 정하는 변수밖에 안됨.
		%>
		<div class="num">
			<%=uid %>
		</div>
		<div class="cat">
			<%if(code.equals("notice")) { %>
				[공 지]
			<%}else if(code.equals("free")) {%>
				[자 유]
			<%}else if(code.equals("gallery")) {%>
				[갤러리]
			<%}else if(code.equals("qna")) {%>
				[Q&A]
			<%}%>
		</div>
		<div class="sub">
			<a href="/<%=code %>/view.jsp?code=<%=code %>&uid=<%=uid%>"><%=subject %></a>
		</div>
		<div class="date">
			<%
			String today1 = today_db.substring(0,10);
            if(today3.equals(today1)){ 
				String today4 = today_db.substring(11,19);%>
				<%=today4 %>
			<%}else{ %>
				<%=today1 %>
			<%} %>
		</div>
		<div class="check">
			<a href="/<%=code %>/modify.jsp?code=<%=code %>&uid=<%=uid%>&page_now=<%=page_now%>"><input class="btn_style_6" id="" type="button" value="수정"></a>
		</div>
		<div class="del">
			<a href="/<%=code %>/delete.jsp?code=<%=code %>&uid=<%=uid%>&page_now=<%=page_now%>"><input class="btn_style_6" id="" type="button" value="X"></a>
		</div>
		<%}	//while 닫음 %>
	</div>
</div>
<br>
<div class="bt_wrap">
	<a href="/admin/" class="on">홈으로</a>
	<a href="list_comment.jsp" class="off">댓글관리</a>
</div>
<br>
<%@ include file="/admin/include/footer.jsp" %>