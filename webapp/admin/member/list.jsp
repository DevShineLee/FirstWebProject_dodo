<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");

/////// 검색 관련 변수
String field = "";
String search = "";

if(request.getParameter("field") != null){
	field = request.getParameter("field");
	search = request.getParameter("search");
}

//// 총 게시물 수
String sql_count;

if(request.getParameter("field") != null && request.getParameter("field") != ""){ //검색이 있을 경우 (공지는 카운트 안함.)
	sql_count = "select count(*) as total_count from notice "+code+" where "+field+" like '%"+search+"%'";
}else{
	sql_count = "select count(*) as total_count from "+code+"";
}
Connection conn_count=DriverManager.getConnection(url, user, password);
Statement stmt_count=conn_count.createStatement();
ResultSet rs_count = stmt_count.executeQuery(sql_count);

int total_record = 0;
if(rs_count.next()){
	total_record = rs_count.getInt("total_count");
}

////// 페이징
int page_now = 1;	//현재 페이지 값
if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}

int num_per_page = 30; //한 페이지당 출력할 게시물 수
int page_per_block = 5; //한 블럭당 출력할 링크 수
int total_page = 0; //총 페이지 수
int first = 0; //limit 첫 값

total_page = (int)Math.ceil(total_record / (double)num_per_page); //총 페이지 수 5
first = num_per_page * (page_now - 1); //limit 첫 값
%>

<br>
<div class="board_title">
	<div class="join_title">
    	전체 회원 목록
    	<form action="/admin/member/list.jsp" method="post">
		<input type="hidden" name="code" value="<%=code%>">
    	<div class="slt_area">
    		<select name="field" class="slt_style">
    			<option value="memberid" <%if(field.equals("memberid")){%>selected<%} %>>아이디</option>
    			<option value="name" <%if(field.equals("name")){%>selected<%} %>>이름</option>
    			<option value="nickname" <%if(field.equals("nickname")){%>selected<%} %>>닉네임</option>
    			<option value="email" <%if(field.equals("email")){%>selected<%} %>>이메일</option>
    		</select>
    	</div>
	    <div class="input_area">
			<input name="search" value="<%=search %>" class="input_style" placeholder="검색어를 입력하세요">
		</div>
    	<div class="search_area" >
			<input type="image" name="submit" src="/images/search.png" height=22>
<!-- 			<input type="submit" value="검색"> -->
		</div>
    	</form>
	</div>
</div>
<div class="join_input">
	아이디를 클릭하면 상세정보 페이지로 넘어갑니다.
</div>
<br>
<div class="join_input" style="text-align: right;">
	Total : <font color=#b6a6d4><b><%=total_record %></b></font> 개의 게시글
</div> 
<br>
<div class="board_list_wrap">
    <div class="board_list">
        <div class="top">
            <div class="num">번호</div>
            <div class="nick">아이디</div>
            <div class="date">이름</div>
            <div class="nick">닉네임</div>
            <div class="nick">패스워드</div>
            <div class="email">이메일</div>
            <div class="count">레벨</div>
        </div>
   		<%
			//////////////////////일반.비밀
			String sql;
			if(request.getParameter("field") != null && request.getParameter("field") != ""){ //검색 했을 경우
				sql = "select * from "+code+" where (1) and "+field+" like '%"+search+"%' order by memberid desc limit "+first+","+num_per_page+"";
			}else{ //검색이 없을 경우
				sql = "select * from "+code+" where (1) order by memberid desc limit "+first+","+num_per_page+"";
			}
			Connection conn=DriverManager.getConnection(url, user, password);
			Statement stmt=conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			///////////////////// 넘버링
			/////////// 넘버링 변수 k 추가
			if(total_record != 0){
				int k = total_record - ((page_now - 1) * num_per_page);
				while(rs.next()){
					String id = rs.getString("memberid");
					String pass = rs.getString("password");
					String nickname = rs.getString("nickname");
					String name = rs.getString("name");
					String email = rs.getString("email");
					String level = rs.getString("level");
			%>
			        <div>
			            <div class="num"><%=k %></div>
			            <div class="nick"><a href ="/admin/member/join_up.jsp?code=<%=code%>&id=<%=id %>"><%=id %></a></div>
			            <div class="date"><%=name %></div>
			            <div class="nick"><%=nickname %></div>
			            <div class="nick"><%=pass %></div>
			            <div class="email"><%=email %></div>
			            <div class="count"><%=level %></div>
			        </div>
				<%
				k--;
				}
				%>
			<%}else{%>
				<br>
				<br>
				<h3 class="list_null">
					가입한 회원이 없습니다.
					<br>
					<br>
					<br>
				</h3>
			<%}%>
    </div>
    <div class="board_page">
	<%
	///////////////////////////////////////////////////// 페이징 처리
	int total_block = 0;
	int block = 0;
	int first_page = 0;
	int last_page = 0;
	int direct_page = 0;
	int my_page = 0;
	
	total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
	block = (int)Math.ceil(page_now / (double)page_per_block);
	first_page = (block - 1) * page_per_block;
	last_page = block * page_per_block;
	
	if(total_block <= block) {
		last_page = total_page;
	}
	
//out.print(last_page);
	//////////// 이전 블럭 처리
	if(block == 1){
%>
		<a href="#" class="bt first"><img src="img/btn_left.png" height=20 style="margin-top: -5px;"></a>
<%			
	}else{
		my_page = first_page;
%>
		<a href="list.jsp?code=<%=code%>&page_now=<%=my_page%>&field=<%=field%>&search=<%=search%>" class="bt prev"><img src="img/btn_left.png" height=20 style="margin-top: -5px;"></a>
<%
	}
	
	for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
		if(page_now == direct_page){
%>
			<a href="#" class="num off"><%=direct_page%></a>
<%
		}else{
%>
			<a href="list.jsp?code=<%=code%>&page_now=<%=direct_page%>&field=<%=field%>&search=<%=search%>" class="num on"><%=direct_page%></a>
<%
		}
	}

////////////// 다음 블럭 처리
	if(block < total_block) {
		my_page = last_page + 1;
%>
		<a href="list.jsp?code=<%=code%>&page_now=<%=my_page%>&field=<%=field%>&search=<%=search%>" class="num"><img src="img/btn_right.png" height=20 style="margin-top: -4px;"></a>
<%
	}else{
%>
		<a href="#" class="bt next"><img src="img/btn_right.png" height=20 style="margin-top: -5px;"></a>
<%
	}
%>			
	</div>
    <div class="bt_wrap">
<%-- 		<%if(session_level != null && session_level.equals("10")){ --%>
<%--     	%> --%>
        	<a href="/admin/member/list.jsp?code=<%=code %>" class="on">회원목록</a>
        	<a href="/admin/member/join.jsp?code=<%=code %>" class="off">회원가입</a>
<%--         <% --%>
//         }else{
<%--        	%> --%>
<!--         	<a href="/" class="on">홈으로</a> -->
<%--         	<a href="list.jsp?code=<%=code %>" class="on">처음으로</a> --%>
<%--         <% --%>
//         }
<%--     	%> --%>
    </div>
</div>
<br>

<%@ include file="/admin/include/footer.jsp" %>