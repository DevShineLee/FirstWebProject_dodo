<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String page_now = request.getParameter("page_now");
String field = request.getParameter("field");
String search = request.getParameter("search");

//상세내용
String sql = "select * from "+code+" where uid = "+uid;

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String file1 = "";
String fid = "";
String thread = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	file1 = rs.getString("file1");
	fid = rs.getString("fid");
	thread = rs.getString("thread");
%>
<script>
	function modifyCheck(){
		if(!subject.value){
			alert("제목을 입력하세요.");
			subject.focus();
			return false;
		}
		if(!comment.value){
			alert("내용을 입력하세요.");
			comment.focus();
			return false;
		}
		document.submit();
	}
</script>

<div>
<form action="reply_insert.jsp" method="post" enctype="multipart/form-data" onsubmit="return modifyCheck()">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page_now" value="<%=page_now%>">
<input type="hidden" name="field" value="<%=field%>">
<input type="hidden" name="search" value="<%=search%>">
<input type="hidden" name="fid" value="<%=fid%>">
<input type="hidden" name="thread" value="<%=thread%>">
	<div class="board_write">
		<br>
		<div class="write_option">
			<input type="radio" name="gongji" value="1">&nbsp;공지&nbsp;&nbsp;&nbsp;
			<input type="radio" name="gongji" value="2" checked>&nbsp;일반&nbsp;&nbsp;&nbsp;
			<input type="radio" name="gongji" value="3">&nbsp;비밀&nbsp;&nbsp;&nbsp;
		</div>
	    <div class="title">
	        <dl>
	            <dt>제목</dt>
	            <dd><input type="text" id="subject" name="subject" value="RE: <%=subject%>"></dd>
	        </dl>
	    </div>
	    <div class="cont">
	        <textarea id="comment" name="comment">RE: <%=comment%></textarea>
	    </div>
	    <div class="title">
	        <dl>
	            <dt>첨 부</dt>
	            <dd>
	            	<input type="file" name="file1">
	            </dd>
	        </dl>
	    </div>
	</div>
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="답변쓰기">>
		<input class="btn_style_4" type="reset" value="다시쓰기">
	    <a href="list.jsp?code=<%=code%>" class="on">목록으로</a>
	</div>
 </form>
 </div>
 <%
 }
 %>
<br>

<%@ include file="/include/footer.jsp" %>