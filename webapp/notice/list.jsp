<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

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
	sql_count = "select count(*) as total_count from notice where gongji != '1' and "+field+" like '%"+search+"%'";
}else{
	sql_count = "select count(*) as total_count from notice where gongji != '1'";
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

int num_per_page = 20; //한 페이지당 출력할 게시물 수
int page_per_block = 5; //한 블럭당 출력할 링크 수
int total_page = 0; //총 페이지 수
int first = 0; //limit 첫 값

total_page = (int)Math.ceil(total_record / (double)num_per_page); //총 페이지 수 5
first = num_per_page * (page_now - 1); //limit 첫 값
%>

<br>
<div class="board_title">
	<div class="join_title">
    	전체 공지사항
    	<form action="list.jsp" method="post">
		<input type="hidden" name="code" value="<%=code%>">
    	<div class="slt_area">
    		<select name="field" class="slt_style">
    			<option value="subject" <%if(field.equals("subject")){%>selected<%} %>>제목</option>
    			<option value="comment" <%if(field.equals("comment")){%>selected<%} %>>내용</option>
    			<option value="nickname" <%if(field.equals("nickname")){%>selected<%} %>>닉네임</option>
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
	공지사항을 꼼꼼히 읽고 잘 숙지 해 주세요.
</div>
<br>
<div class="join_input" style="text-align: right;">
	Total : <font color=#b6a6d4><b><%=total_record %></b></font> 개의 게시글
</div> 
<br>
<div class="board_list_wrap">
    <div class="board_list">
        <div class="top">
            <div class="num">글번호</div>
            <div class="title">제목</div>
            <div class="writer">닉네임</div>
            <div class="date">작성일</div>
            <div class="count">조회수</div>
        </div>
   		<%
   		/////////공지
		if(page_now == 1){ //1페이지 에서만 출력하자.
   		String sql_gongji;
      		
		if(request.getParameter("field") != null && request.getParameter("field") != ""){ //검색 했을 경우
			sql_gongji = "select * from "+code+" where gongji = '1' and "+field+" like '%"+search+"%' order by uid desc limit "+first+","+num_per_page+"";
		}else{ //검색이 없을 경우
			sql_gongji = "select * from "+code+" where gongji = '1' order by uid desc limit "+first+","+num_per_page+"";
		}
     	Connection conn_gongji=DriverManager.getConnection(url, user, password);
		Statement stmt_gongji=conn_gongji.createStatement();
		ResultSet rs_gongji = stmt_gongji.executeQuery(sql_gongji);
		
		while(rs_gongji.next()){
			int uid = rs_gongji.getInt("uid");
			String subject = rs_gongji.getString("subject");
			String signdate = rs_gongji.getString("signdate").substring(0,10);		
			String file1 = rs_gongji.getString("file1");
		%>
	        <div style="background: #b6a6d4">
	            <div class="num"><img src="img/star.png"></div>
	            <div class="title">
	            	<%
	            	if(session_id != null && session_id != ""){%>
		            	<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>">&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()">&nbsp;<%=subject%></a>
	            	<%} %>
	            	<%if(!file1.equals("")){%>
						<img src="img/file.png" style="margin-bottom: -3px;">
					<%}%>
					<%
					String sql_c_count;
					
					sql_c_count = "select count(*) as comment_count from comment where tb_uid="+uid+"";
					Connection conn_c_count=DriverManager.getConnection(url, user, password);
					Statement stmt_c_count=conn_count.createStatement();
					ResultSet rs_c_count = stmt_count.executeQuery(sql_c_count);
					if(rs_c_count.next()){
						int total_comment = rs_c_count.getInt("comment_count");
						if(total_comment > 0){%>
						[<%=total_comment %>]
					<%
						}
					}
					%>
	            </div>
	            <div class="writer"><%=rs_gongji.getString("nickname") %></div>
	            <div class="date"><%=rs_gongji.getString("signdate").substring(0,10) %></div>
	            <div class="count"><%=rs_gongji.getString("ref") %></div>
	        </div>
		<%
			}	//while 닫음
   		}	//if 닫음
		
		/////////// 게시글이 없을때 메시지 출력.
	 	if(total_record != 0){
			//////////////////////일반.비밀
			String sql;
			if(request.getParameter("field") != null && request.getParameter("field") != ""){ //검색 했을 경우
				sql = "select * from "+code+" where gongji != '1' and "+field+" like '%"+search+"%' order by fid desc,thread asc limit "+first+","+num_per_page+"";
			}else{ //검색이 없을 경우
				sql = "select * from "+code+" where gongji != '1' order by fid desc,thread asc limit "+first+","+num_per_page+"";
			}
			Connection conn=DriverManager.getConnection(url, user, password);
			Statement stmt=conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			///////////////////// 넘버링
			/////////// 넘버링 변수 k 추가
			int k = total_record - ((page_now - 1) * num_per_page);
			while(rs.next()){
				int uid = rs.getInt("uid");
				String id = rs.getString("id");
				// 제목 글자수 제한
				String subject = rs.getString("subject");
				int len_subject = subject.length(); //제목 길이
				if(len_subject > 70){
					subject = subject.substring(0,70) + "...";
				}else{
					subject = subject;
				}
				//// 제목 글자수처리 끝
				String signdate = rs.getString("signdate").substring(0,10);
				String gongji = rs.getString("gongji"); //1.공지 2.일반 3.비밀
				String file1 = rs.getString("file1");
				String thread = rs.getString("thread");
				int len_thread = thread.length(); //답변의 길이 값
			%>
		        <div>
		            <div class="num"><%=k %></div>
		            <div class="title">
		            	<%
						//답변 들여쓰기 및 아이콘 출력
						if(len_thread > 1){
							for(int i=1; i<len_thread; i++){
								out.print("&nbsp;&nbsp;");
							}
							out.print("&nbsp;&nbsp;<img src='img/reply.png' style='margin-bottom: -3px;'>");
						}
						%>
						<%
						//////////비밀,일반 첨부, 자물쇠 아이콘 추가, 비밀글일시 작성자 관리자만 볼수있도록 구현
						if(session_id != null && session_id != ""){
							if(gongji.equals("3")){//비밀글이라면
								if((session_level != null && session_level.equals("10")) || (session_id != null && session_id.equals(id))){ //관리자, 작성자라면 읽어 보자%>
									<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>"><%=subject%></a>&nbsp;
									<img src="img/sheee.png" style="margin-bottom: -2px;">
								<%}else{ //관리자, 작성자 아닌경우%>
									<%=subject%> <img src="img/sheee.png" style="margin-bottom: -1px;">
								<%}%>
							<%}else{ //일반글이라면%>
								<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>&field=<%=field%>&search=<%=search%>"><%=subject%></a>
							<%}%>
							<%if(!file1.equals("")){%>
								<img src="img/file.png" style="margin-bottom: -3px;">
							<%}%>
						<%}else{ %>
		            		<a href="" onclick="javascript:alarm()">&nbsp;<%=subject%></a>
		            		<%if(gongji.equals("3")){%>
		            			<img src="img/sheee.png" style="margin-bottom: -1px;">
		            		<%} %>
		            		<%if(!file1.equals("")){%>
								<img src="img/file.png" style="margin-bottom: -3px;">
							<%}
	            		}%>
						<%	String sql_c_count;
							
							sql_c_count = "select count(*) as comment_count from comment where tb_uid="+uid+"";
							Connection conn_c_count=DriverManager.getConnection(url, user, password);
							Statement stmt_c_count=conn_count.createStatement();
							ResultSet rs_c_count = stmt_count.executeQuery(sql_c_count);
							if(rs_c_count.next()){
								int total_comment = rs_c_count.getInt("comment_count");
								if(total_comment > 0){%>
								[<%=total_comment %>]
							<%	}
							}
							%>
	            	</div>
		            <div class="writer"><%=rs.getString("nickname") %></div>
		            <div class="date"><%=rs.getString("signdate").substring(0,10) %></div>
		            <div class="count"><%=rs.getString("ref") %></div>
		        </div>
					<%
					k--;
					}
					%>
		<%}else{%>
			<br>
			<br>
			<h3 class="list_null">
				작성된 게시글이 없습니다.
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
        	<a href="write.jsp?code=<%=code %>" class="on">글쓰기</a>
        	<a href="/" class="off">홈으로</a>
        	<a href="list.jsp?code=<%=code %>" class="on">처음으로</a>
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

<%@ include file="/include/footer.jsp" %>