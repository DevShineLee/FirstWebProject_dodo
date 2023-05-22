<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("memberid");			// id 값을 저장하는 변수.
String pass = request.getParameter("password");

//회원이 존재하는지 여부 확인
String sql = "select * from member where memberid = '"+id+"'";
String sql2 = "select * from member where memberid = '"+id+"' and password = '"+pass+"'";

Connection conn=DriverManager.getConnection(url, user, password); //데이터베이스 접속
Statement stmt=conn.createStatement();	//쿼리 준비단계
ResultSet rs = stmt.executeQuery(sql2);	//쿼리문 전송해서 rs변수에 담음
//////////

String mem_id = "";
String mem_pass = "";
String mem_name = "";
String mem_nickname = "";
String mem_email = "";
String mem_level = "";

if(rs.next()){		// 값을 불러와!	 : 로그인 페이지라 값이 하나만 있으니까 if 사용, 값이 여러개면 while 사용
	mem_id = rs.getString("memberid");
	mem_pass = rs.getString("password");
	mem_name = rs.getString("name");
	mem_nickname = rs.getString("nickname");
	mem_email = rs.getString("email");
	mem_level = rs.getString("level");
}

if(id.equals(mem_id) && pass.equals(mem_pass)){		//rs.next()로 값을 불러와서 변수에 담은다음에 비교해! session부분은 헤더에 있으니까 불러와지는거임.
	session.setAttribute("id",id);
	session.setAttribute("name",mem_name);
	session.setAttribute("nickname",mem_nickname);
	session.setAttribute("level",mem_level);
%>
	<script>
		alert("<%=mem_nickname%>님 어서오세요!");
		location.href = "/";
	</script>
<%
}else{
%>
	<script>
		alert("아이디나 비밀번호가 틀렸습니다.");
		location.href = "login.jsp";
	</script>
<%
}
%>