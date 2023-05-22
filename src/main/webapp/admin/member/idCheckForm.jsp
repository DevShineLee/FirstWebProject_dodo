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

String id;	//인풋에서 입력한 아이디
if(request.getParameter("id") != null){	// null일 경우에 사용할수 있는 아이디로 뜨는것 방지
	id = request.getParameter("id");
}else{
	id = "";
}
String sql = "select * from member where memberid='"+id+"'";
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

//out.print("멤버아이디:" + sql + "<br>");
//out.print("입력아이디:" + id + "<br>");
String ok = "";
String str = "";

if(rs.next() == true && id != null){
	String userid = rs.getString("memberid");	//DB에서 읽어온 아이디
	//out.print("sql결과값:" + userid);
	if(userid.equals(id)){
		str = "<br><font color=red>사용할 수 없는 아이디입니다.</font><br>";
		
	}
	ok = "N";
}else if(rs.next() == false && id != null && !id.equals("")) {	//rs값이 없을때!!! mysql 결과가 Empty set일때!!! 올~ㅋ
	str = "<br><font color=blue>멋진 아이디네요!</font><br>";
	ok = "Y";
}else{
	str = "<br><font color=#837272>아이디는 영어 또는 숫자 4~20자로 입력하세요.<br>특수문자 '_' 사용 가능합니다.</font>";
}
%>
<script> 
function blankCheck(f){
	var id=f.id.value; id=id.trim(); 
	if(id.length<4){ alert("아이디는 4자 이상 입력해주세요.");
		return false;
	} //if end 
	document.submit();
} //blankCheck() end

function parent_ok(){
	window.opener.document.getElementById("memberid").value = id2.value;
	window.opener.document.getElementById("val").value = id_ok.value;
	window.close();
}
</script>
<body>
	<div>
		<h2><img src="/images/heart.png" width=22> 아이디 중복확인 <img src="/images/heart.png" width=22></h2>
 		<form action="idCheckForm.jsp" method="post" onsubmit="return blankCheck(this)">
		아이디 :
			<input type="text" id="id2" name="id" pattern="^([a-z0-9_]){4,20}$" maxlength="20" autofocus value="<%=id%>">
			<input type="hidden" id="id_ok" value="<%=ok%>">
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
		<a href="idCheckForm.jsp"><input type="button" class="btn_style2" value="다시하기"></a>
		<%}%>
		<%if(ok.equals("")) {%>
		<input type="button" class="btn_style2" value="닫기" onclick="window.close()">
		<%}%>
	</div>
</body>
</html>