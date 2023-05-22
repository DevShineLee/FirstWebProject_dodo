<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/dbconnection.jsp" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiException"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<title>dodo</title>
	<link rel="shortcut icon" type="image⁄x-icon" href="/images/dodo.ico">
	<link rel="stylesheet" href="/css/css.css?after">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap" rel="stylesheet">
</head>
<body>
<%
String session_id = (String)session.getAttribute("id");
String session_name = (String)session.getAttribute("name");
String session_nickname = (String)session.getAttribute("nickname");
String session_level = (String)session.getAttribute("level");
String session_password = (String)session.getAttribute("password");
%>
<div class="session_main">
	<%if(session_id != null && !session_id.equals("")) {%>
		<br><%=session_nickname %>님 안녕하세요!<br><br>
		<h2><img src="/images/heart.png" width=16>&nbsp;로그인 정보&nbsp;<img src="/images/heart.png" width=16></h2><br>
		<ul style="padding-left: 10px; text-align: left;">
			<li>⦁ 아이디 : <%=session_id %></li>
			<li>⦁ 이&nbsp;&nbsp;&nbsp;름 : <%=session_name %></li>
			<li>⦁ 닉네임 : <%=session_nickname %></li>
<%-- 			<li>⦁ 레&nbsp;&nbsp;&nbsp;벨 : <%=session_level %> level</li> --%>
		</ul>
	<%}else{ %>
		<br>오랜만이에요.<br><br>
		<h2><img src="/images/heart.png" width=16>&nbsp;어서오세요!&nbsp;<img src="/images/heart.png" width=16></h2><br>
		회원이시면 로그인을,<br>
		아니시면 회원가입을<br>
		해주세요 ♩♪♬<br>
	<%} %>
</div>
<!-- 	header : 메인로고, 게시판목록, 게시판검색, 로그인,회원가입 -->
<div class="board_wrap">
	<br>
	<a href ="/"><img src="/images/dodo.png" width=75 height=70 style="padding-bottom: 5px;"></a>
	<div class="btn_area">
		<a href="/notice/list.jsp?code=notice" class="btn_style_7">공지사항</a>
		<img src="/images/heart.png" width=16>
		<a href="/free/list.jsp?code=free" class="btn_style_8">자유게시판</a>
		<a href="/gallery/list.jsp?code=gallery" class="btn_style_8">사진갤러리</a>
		<a href="/qna/list.jsp?code=qna" class="btn_style_8">질문과답변</a>
		<img src="/images/heart.png" width=16>
		<%
			if(session_id == null){
		%>
	       	<a href="/member/login.jsp" class="btn_style_8">로&nbsp;&nbsp;그&nbsp;&nbsp;인</a>
			<a href="/member/join.jsp" class="btn_style_8">회원가입</a>
		<% }else{ %>
			<%if(session_level.equals("10")){ %>
			<a href="/admin/" class="btn_style_7">관리자</a>
			<img src="/images/heart.png" width=16>
			<%} %>
	       	<a href="/member/logout.jsp" class="btn_style_8">로그아웃</a>
	       	<a href="/member/my_page.jsp" class="btn_style_8">마이페이지</a>
<!-- 			<button class="btn_style"><a href="/member/join_up.jsp">회원수정</a></button> -->
		<% } %>				
	</div>
	<div class="board_list"></div>	 <!-- 로고 밑에 까만줄 -->
