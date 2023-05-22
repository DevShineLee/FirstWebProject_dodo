<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");

String uid = request.getParameter("uid");

String page_now = "";
if(request.getParameter("page_now") != null && !request.getParameter("page_now").equals("")){
	page_now = request.getParameter("page_now");
}else{
	page_now = "1";
}

String field = request.getParameter("field");
String search = request.getParameter("search");

//조회수 +1
String sql_ref = "update "+code+" set ref=ref+1 where uid="+uid+"";
Connection conn_ref=DriverManager.getConnection(url, user, password);
Statement stmt_ref=conn_ref.createStatement();
stmt_ref.executeUpdate(sql_ref);

//상세내용
String sql = "select * from "+code+" where uid = "+uid;

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String today_db = "";
if(rs.next()){
	String gongji = rs.getString("gongji");
	String subject = rs.getString("subject");
	String name = rs.getString("name");
	String level = rs.getString("level");
	String nickname = rs.getString("nickname");
	String comment = rs.getString("comment");
	today_db = rs.getString("signdate");
	String ref = rs.getString("ref");
	String id = rs.getString("id");
	String file1 = rs.getString("file1");
	
%>
<%if(gongji.equals("3")) { //비밀글이라면
	if((session_level != null && session_level.equals("10")) || (session_id != null && session_id.equals("id"))){
	
	}else{
%>
<script>
	alert("관리자 또는 작성자만 확인할 수 있습니다.");
	location.href="/";
</script>
<%
	}
}
%>

<script>
function deleteCheck(){
	var str = confirm("삭제하시겠습니까?");
	if(str == true){
		alert("삭제되었습니다.");
		location.href="delete.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
	}else{
		alert("취소되었습니다.");
	}
}
</script>

<div class="board_view_wrap">
	<div class="board_view">
	    <div class="title">
	        <%=subject%>
	    </div>
	    <div class="info">
	        <dl>
	            <dt>
					<%
					if(gongji.equals("1")){ 
						out.print("[공지]"); 
					}else if(gongji.equals("2")){ 
						out.print("[일반]");
					}else if(gongji.equals("3")){ 
						out.print("[비밀]"); 
					}else {
						out.print("누가 해킹하니?");
					}
					%>
				</dt>
	        </dl>
	        <dl>
	            <dt>번호</dt>
	            <dd><%=uid%></dd>
	        </dl>
	        <dl>
				<dt>작성자</dt>
				<%if(level.equals("10")){ %>
				<dd><%=nickname %></dd>
				<%}else{ %>
				<dd><%=nickname %>(<%=id.substring(0,4)%>***)</dd>
				<%} %>
	        </dl>
	        <dl>
	            <dt>작성일</dt>
	            <dd>
	            <%
				//현재 시간
           		String today2 = "";
           		String today3 = "";
           		Date nowTime = new Date();
           		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
           		String today = sf.format(nowTime);
           		today2 = today.substring(11,19);
           		today3 = today.substring(0,10);
				%>
				<%
				String today1 = today_db.substring(0,10);
	            if(today3.equals(today1)){ 
					String today4 = today_db.substring(11,19);%>
					<%=today4 %>
				<%}else{ %>
					<%=today1 %>
				<%}%>  
				</dd>
	        </dl>
	        <dl>
	            <dt>조회</dt>
	            <dd><%=ref%></dd>
	        </dl>
	    </div>
   	    <div class="cont">
			<%if(file1 != null && file1 != ""){ %>
				<img src="/upload/<%=file1%>" style="max-width: 970px;" onerror="this.style.display='none'">
<!-- 				<p class="cont2"></p><br> -->
			<%} %>
	    		<br><a href="/upload/<%=file1%>" download><%=file1%></a>
	   	</div>
		<div class="view_content">
			<%
			////////////개행처리
		    pageContext.setAttribute("cmt", comment);
			pageContext.setAttribute("LF", "\n");
		    %>
	    	${fn:replace(cmt, LF, '<br>')}
	    </div>
<!-- 	    댓글 작성부분 -->
		<script>
			function commentNull(){
				if(!comment.value){
					alert("댓글을 입력하세요");
					comment.focus();
					return false;
				}
				document.submit();
			}
		</script>
		<form action="comment_insert.jsp" method="post" onsubmit="return commentNull()">
		<input type ="hidden" name="code" value=<%=code %>>
		<input type ="hidden" name="uid" value=<%=uid %>>
		<input type ="hidden" name="page_now" value=<%=page_now %>>
		<input type ="hidden" name="field" value=<%=field %>>
		<input type ="hidden" name="search" value=<%=search %>>
	   	<div class="reply_write">
			<input class="reply_input" id="comment" name="comment" placeholder="댓글을 입력 해 주세요.">
			<input class="btn_style_2" type="submit" value="댓글등록">
		</div>
		</form>
		<br>
<!-- 		댓글 리스트 출력부분 -->
		<%
		String sql_comment = "select * from comment_f where tb_table='"+code+"' and tb_uid="+uid;
		Connection conn_comment = DriverManager.getConnection(url, user, password);
		Statement stmt_comment = conn_comment.createStatement();
		ResultSet rs_comment = stmt_comment.executeQuery(sql_comment);
		
		while(rs_comment.next()){
			String c_uid = rs_comment.getString("uid");
			String c_id = rs_comment.getString("tb_id");
			String c_nickname = rs_comment.getString("tb_nickname");
			String c_comment = rs_comment.getString("tb_comment");
			String c_date = rs_comment.getString("tb_date");
			String c_name = rs_comment.getString("tb_name");
			String c_level = rs_comment.getString("tb_level");
		%>
		<div class="reply_wrap">
			<div class="reply_view1">
				<%if(c_level.equals("10")){ %>
					<%=c_nickname %>
				<%}else{ %>
					<%=c_nickname %>(<%=c_id.substring(0,4)%>***)
				<%}%>
			</div>
			<div class="reply_view2"><%=c_comment %></div>
			<div class="reply_view3"><%=c_date %></div>
			<%if((session_level != null && session_level.equals("10")) || (c_id != null && session_id.equals(c_id))){	//관리자, 작성자일때%>
				<form action="comment_modify.jsp?uid=<%=uid %>&code=<%=code %>&c_uid=<%=c_uid %>&page_now=<%=page_now %>" method="post">
				<div class="reply_modify">
					<input class="btn_style_6" id="" type="submit" value="수정">
				</div>
				</form>
				<form action="comment_delete.jsp?uid=<%=uid %>&code=<%=code %>&c_uid=<%=c_uid %>&page_now=<%=page_now %>" method="post">
				<div class="reply_delete">
					<input class="btn_style_6" type="submit" value="X">
				</div>
				</form>
			<%}else{ %>
				</form>			<!--else 일때도 닫아줘야지!!!!!!!!!!!!!!! 미칭ㅋㅋㅋㅋㅋㅋ-->
			<%} %>
		</div>
		<%
		}
		%>
	</div>
	<div class="bt_wrap">
		<%if(gongji.equals("1")){	//공지글이라면
			if((session_level != null && session_level.equals("10")) || (session_id != null && session_id.equals(id))){	//관리자, 작성자일때%>
				    <a href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>" class="on">수정하기</a>
				    <button onclick="deleteCheck()" class="btn_style_4">삭제하기</button>
				    <a href="list.jsp?code=<%=code%>&page_now=<%=page_now%>" class="on">목록으로</a>
					<a href="reply.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>" class="off">답글쓰기</a>
			<%}else{ %>
			    <a href="list.jsp?code=<%=code%>&page_now=<%=page_now%>" class="on">목록으로</a>
			<%} %>			
		<%}else{	//일반 글이라면
			if((session_level != null && session_level.equals("10")) || (session_id != null && session_id.equals(id))){ //관리자 작성자일때%>
				    <a href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>" class="on">수정하기</a>
				    <button onclick="deleteCheck()" class="btn_style_4">삭제하기</button>
				    <a href="list.jsp?code=<%=code%>&page_now=<%=page_now%>" class="on">목록으로</a>
					<a href="reply.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>" class="off">답글쓰기</a>
			<%}else{ %>
			    <a href="list.jsp?code=<%=code%>&page_now=<%=page_now%>" class="on">목록으로</a>
				<a href="reply.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>" class="off">답글쓰기</a>
			<%} %>		
		<%} %>
	</div>
</div>
<%
}
%>
<br>

<%@ include file="/include/footer.jsp" %>