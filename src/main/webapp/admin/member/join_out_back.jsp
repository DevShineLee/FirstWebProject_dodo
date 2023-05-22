<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
//이전페이지에서 넘어온 탈퇴 할 회원 정보
String id = request.getParameter("memberid");
String pass = request.getParameter("pass0");

//이전페이지에서 넘어온 관리자 패스워드 정보
String admin_pass = request.getParameter("admin_pass");

String sql1 = "select * from member where memberid='0000'";
Connection conn1 = DriverManager.getConnection(url, user, password);
Statement stmt1 = conn1.createStatement();
ResultSet rs1 = stmt1.executeQuery(sql1);
out.print(sql1+"<br>");
out.print("탈퇴할아이디:"+id+"<br>");
out.print("탈퇴할비번:"+pass+"<br>");
out.print("관리자가 친 비번"+admin_pass+"<br>");

String sql = "";
String pass1 = "";
if(rs1.next()) {
	pass1 = rs1.getString("password");
	out.print("관리자DB비번:"+pass1+"<br>");
}
if(admin_pass.equals("pass1")){
	out.print("같다");
}
if(!admin_pass.equals("") && admin_pass.equals("pass1")){
	sql = "delete from member where memberid='"+id+"'";
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt= conn.createStatement();
//	stmt.executeUpdate(sql);
	out.print(sql);
}
%>

<script>
//	alert("강퇴처리 되었습니다.");
//	location.href="/admin/member/list.jsp";
</script>














