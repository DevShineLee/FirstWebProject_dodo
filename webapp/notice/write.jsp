<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
	function writeCheck(){
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

<%
String code = request.getParameter("code"); //데이타베이스 테이블명
%>

<br>
<div class="board_title">
    <div class="join_title">
    	공지사항
	</div>
</div>
<div class="join_info">
	&nbsp;&nbsp;&nbsp;공지사항을 작성 해 주세요.
</div>

<br>
<form action="write_insert.jsp" method="post" enctype="multipart/form-data" onsubmit="return writeCheck()">
<input type="hidden" name="code" value="<%=code%>">
<div class="board_write_wrap">
	<div class="board_write">
		<br>
		<div class="write_option">
			<%if(session_level != null && session_level.equals("10")){ //관리자 작성자일때%>
				<input type="radio" name="gongji" value="1">&nbsp;공지&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gongji" value="2" checked>&nbsp;일반&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gongji" value="3">&nbsp;비밀&nbsp;&nbsp;&nbsp;
			<%}else{ %>
				<input type="radio" style="margin-left: 25px;" name="gongji" value="2" checked>&nbsp;일반&nbsp;&nbsp;&nbsp;
				<input type="radio" style="margin-left: 20px;" name="gongji" value="3">&nbsp;비밀&nbsp;&nbsp;&nbsp;
			<%} %>
		</div>
	    <div class="title">
	        <dl>
	            <dt>제 목</dt>
	            <dd><input type="text" id="subject" name="subject" placeholder="제목 입력"></dd>
	        </dl>
	    </div>
	    <div class="cont">
	        <textarea id="comment" name="comment" placeholder="내용 입력"></textarea>
	    </div>
	    <div class="title">
	        <dl>
	            <dt>첨 부</dt>
	            <dd><input type="file" name="file1" ></dd>
	        </dl>
	    </div>
	</div>
	<div class="bt_wrap">
		<input class="btn_style_3" type="submit" value="등 록">>
		<input class="btn_style_4" type="reset" value="다시쓰기">
	    <a href="list.jsp?code=<%=code%>" class="on">목록으로</a>
	</div>
 </div>
 </form>
<br>

<%@ include file="/include/footer.jsp" %>