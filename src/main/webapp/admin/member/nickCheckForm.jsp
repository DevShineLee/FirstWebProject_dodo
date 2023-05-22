<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnection.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<!DOCTYPE html> 
<html>
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap" rel="stylesheet">
<meta charset="UTF-8"> 
<title>idCheckForm.jsp</title> 
</head>
<style>
	* {
		font-family: 'Gowun Batang', serif;
	}
	
	body {
		background-color: #eceeed;
		text-align: center;
	}
	
	.btn_style {
		width: 75px;
		height: 25px;
		border: 1px solid #837272;
		border-radius: 3px;
		background: #eceeed;
		color: #837272;
		text-decoration: none;
		margin-right:0px;
		cursor: pointer;
	}

	.btn_style:hover {
		background: #837272;
	    color: #eceeed;
	}
	
	.btn_style2 {
		width: 75px;
		height: 25px;
		border: 1px solid #837272;
		border-radius: 3px;
		background: #837272;
		color: #eceeed;
		text-decoration: none;
		margin-right:0px;
		cursor: pointer;
	}

	.btn_style2:hover {
		background: #eceeed;
	    color: #837272;
	}
</style>
<%
request.setCharacterEncoding("utf-8");

String nick;	//인풋에서 입력한 넥네임
if(request.getParameter("nick") != null){	// null일 경우에 사용할수 있는 아이디로 뜨는것 방지
	nick = request.getParameter("nick");
}else{
	nick = "";
}
String sql = "select * from member where nickname='"+nick+"'";
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

//out.print("멤버닉네임:" + sql + "<br>");
//out.print("입력닉네임:" + nick + "<br>");
String ok = "";
String str = "";

if(rs.next() == true && nick != null){
	String usernick = rs.getString("nickname");	//DB에서 읽어온 아이디
//	out.print("sql결과값:" + usernick);
	if(usernick.equals(nick)){
		str = "<br><font color=red>사용할 수 없는 닉네임입니다.</font><br>";
		
	}
	ok = "N";
}else if(rs.next() == false && nick != null && !nick.equals("")) {	//rs값이 없을때!!! mysql 결과가 Empty set일때!!! 올~ㅋ
	str = "<br><font color=blue>멋진 닉네임이네요!</font><br>";
	ok = "Y";
}else{
	str = "<br><font color=#837272>원하시는 닉네임을 6자 이하로 입력해주세요.<br>특수문자는 사용불가합니다.</font><br>";
}
%>
<script> 
function parent_ok(){
	window.opener.document.getElementById("nickname").value = nick.value;
	window.opener.document.getElementById("val1").value = nick_ok.value;
	window.close();
}
</script>
<body>
	<div>
		<h2><img src="/images/heart.png" width=22> 닉네임 중복확인 <img src="/images/heart.png" width=22></h2>
 		<form action="nickCheckForm.jsp" method="post">
		닉네임 :
			<input type="text" id="nick" name="nick" maxlength="6" pattern="[^!@#$%^&*()_-+=[]{}~?:;`|/<>'"]+" autofocus value="<%=nick%>">
			<input type="hidden" id="nick_ok" value="<%=ok%>">
 			<input type="submit" class="btn_style" value="중복확인">
  		</form>
	</div>

	<%=str %>
	<br><br><img src="/images/dodo.png" width=100><br><br>
	<div>
		<%if(ok.equals("Y")) {%>
		<input type="button" class="btn_style2" value="사용하기" onclick="parent_ok()">
		<%}%>
		<%if(ok.equals("N")) {%>
		<a href="nickCheckForm.jsp"><input type="button" class="btn_style2" value="다시하기"></a>
		<%}%>
		<%if(ok.equals("")) {%>
		<input type="button" class="btn_style2" value="닫기" onclick="window.close()">
		<%}%>
	</div>
</body>
</html>