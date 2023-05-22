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

String sql = "select * from "+code+" where uid = "+uid;

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()){	
	String gj = rs.getString("gongji");
	String subject = rs.getString("subject");
	String comment = rs.getString("comment");
	String file1 = rs.getString("file1");
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
<form action="modify_update.jsp" method="post" enctype="multipart/form-data" onsubmit="return modifyCheck()">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page_now" value="<%=page_now%>">
<input type="hidden" name="field" value="<%=field%>">
<input type="hidden" name="search" value="<%=search%>">
	<div class="board_write">
		<br>
		<div class="write_option">
			<%if(session_level != null && session_level.equals("10")){%>
				<input type="radio" name="gongji" value="1">&nbsp;공지&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gongji" value="2" checked>&nbsp;일반&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gongji" value="3">&nbsp;비밀&nbsp;&nbsp;&nbsp;
			<%}else{ %>
				<input type="radio" name="gongji" value="2" checked>&nbsp;일반&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gongji" value="3">&nbsp;비밀&nbsp;&nbsp;&nbsp;
			<%} %>
		</div>
	    <div class="title">
	        <dl>
	            <dt>제목</dt>
	            <dd><input type="text" id="subject" name="subject" value="<%=subject %>"></dd>
	        </dl>
	    </div>
	    <div class="cont">
	        <textarea id="comment" name="comment"><%=comment %></textarea>
	    </div>
	    <div class="title">
	        <dl>
	            <dt>첨 부</dt>
	            <dd>
	            	<input type="file" name="file1">
	            	<%
	            	if(file1.equals("")){
						out.print("파일을 첨부해주세요.");
	            	}else{
	            		out.print("파일명: "+file1);
	            	}
	            	%>
	            </dd>
	        </dl>
	    </div>
	</div>
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="수정하기">>
		<input class="btn_style_4" type="reset" value="다시쓰기">
	</div>
 </form>
 </div>
<%
}
%>
<br>

<%@ include file="/include/footer.jsp" %>