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

session_id : <%=session_id %>&nbsp;&nbsp;
session_name : <%=session_name %>&nbsp;&nbsp;
session_nickname : <%=session_nickname %>&nbsp;&nbsp;
session_level : <%=session_level %>

<!-- 	header : 메인로고, 게시판목록, 게시판검색, 로그인,회원가입 -->
<div class="board_wrap">
	<a href ="/"><img src="/images/dodo.png" width=75 height=70 style="padding-bottom: 5px;"></a>
	<div class="btn_area">
		<button class="btn_style_2"><a href="/notice/list.jsp?code=notice"><b>공지사항</b></a></button>
		<img src="/images/heart.png" width=16>
		<button class="btn_style"><a href="/free/list.jsp?code=notice">자유게시판</a></button>
		<button class="btn_style"><a href="/notice/list.jsp?code=qna">질문과답변</a></button>
		<button class="btn_style"><a href="/notice/list.jsp?code=gallery">사진갤러리</a></button>
		<img src="/images/heart.png" width=16>
		<%
			if(session_id == null){
		%>
	       	<button class="btn_style"><a href="/member/login.jsp">로&nbsp;&nbsp;그&nbsp;&nbsp;인</a></button>
			<button class="btn_style"><a href="/member/join.jsp">회원가입</a></button>
		<% }else{ %>
			<%if(session_level.equals("10")){ %>
			<button class="btn_style"><a href="/admin">관리자</a></button>
			<img src="/images/heart.png" width=16>
			<%} %>
	       	<button class="btn_style"><a href="/member/logout.jsp">로그아웃</a></button>
			<button class="btn_style"><a href="/member/join_up.jsp">회원수정</a></button>
		<% } %>				
	</div>
	<div class="board_list"></div>	 <!-- 로고 밑에 까만줄 -->
