<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>
	
	<br>
	<a href="/">
		<video loop="" muted="" autoplay="" playsinline="" webkit-playsinline="true" style="display:flex;object-fit:cover;width:1000px;height:500px;z-index:10"><source type="video/mp4" src="video/main.mp4"></video>
	</a>
	<br>
	<div class="main_board_wrap">
		<div class="main_list_wrap">

<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////// -->

		<div class="main_board">
		    	<h2 class="main_board_title">최근 화제글 ★</h2>
				<%
				String sql4 = "select * from free where gongji != '1' order by ref desc limit 3"; //7줄 까지만 불러오기
				Connection conn4 = DriverManager.getConnection(url, user, password);
				Statement stmt4 = conn4.createStatement();
				ResultSet rs4 = stmt4.executeQuery(sql4);
				while(rs4.next()){
					String subject = rs4.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 12){
						subject = subject.substring(0,12) + "...";
					}else{
						subject = subject;
					}
					String ref = rs4.getString("ref");
					int uid = rs4.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/free/view.jsp?code=free&uid=<%=uid %>">[자유]&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()"><%=subject%></a>
	            	<%} %>
	            	
				    <%
					String sql_c_count4 = "select count(*) as comment_count from comment_f where tb_uid="+uid+"";
					Connection conn_c_count4 = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count4 = conn_c_count4.createStatement();
					ResultSet rs_c_count4 = stmt_c_count4.executeQuery(sql_c_count4);
					if(rs_c_count4.next()){
						int total_comment = rs_c_count4.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    				<%
				String sql5 = "select * from gallery where gongji != '1' order by ref desc limit 2"; //7줄 까지만 불러오기
				Connection conn5 = DriverManager.getConnection(url, user, password);
				Statement stmt5 = conn5.createStatement();
				ResultSet rs5 = stmt5.executeQuery(sql5);
				while(rs5.next()){
					String subject = rs5.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 10){
						subject = subject.substring(0,10) + "...";
					}else{
						subject = subject;
					}
					String ref = rs5.getString("ref");
					int uid = rs5.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/gallery/view.jsp?code=gallery&uid=<%=uid %>">[갤러리]&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()"><%=subject%></a>
	            	<%} %>
	            	
				    <%
					String sql_c_count5 = "select count(*) as comment_count from comment_g where tb_uid="+uid+"";
					Connection conn_c_count5 = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count5 = conn_c_count5.createStatement();
					ResultSet rs_c_count5 = stmt_c_count5.executeQuery(sql_c_count5);
					if(rs_c_count5.next()){
						int total_comment = rs_c_count5.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    				<%
				String sql6 = "select * from qna where gongji != '1' order by ref desc limit 2"; //7줄 까지만 불러오기
				Connection conn6 = DriverManager.getConnection(url, user, password);
				Statement stmt6 = conn6.createStatement();
				ResultSet rs6 = stmt6.executeQuery(sql6);
				while(rs6.next()){
					String subject = rs6.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 10){
						subject = subject.substring(0,10) + "...";
					}else{
						subject = subject;
					}
					String ref = rs6.getString("ref");
					int uid = rs6.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/qna/view.jsp?code=qna&uid=<%=uid %>">[Q&A]&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()"><%=subject%></a>
	            	<%} %>
	            	
				    <%
					String sql_c_count7 = "select count(*) as comment_count from comment_q where tb_uid="+uid+"";
					Connection conn_c_count7 = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count7 = conn_c_count7.createStatement();
					ResultSet rs_c_count7 = stmt_c_count7.executeQuery(sql_c_count7);
					if(rs_c_count7.next()){
						int total_comment = rs_c_count7.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    </div>
		    
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////	-->
		    
			<div class="main_board">
		    	<h2 class="main_board_title">자유게시판 인기글
		    	<font color=#615454; size=1px;>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	<a href="/free/list.jsp?code=free">[더보기]</a></font></h2>
				<%
				String sql = "select * from free where gongji != '1' order by ref desc limit 7"; //7줄 까지만 불러오기
				Connection conn = DriverManager.getConnection(url, user, password);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next()){
					String subject = rs.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 15){
						subject = subject.substring(0,15) + "...";
					}else{
						subject = subject;
					}
					String ref = rs.getString("ref");
					int uid = rs.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/free/view.jsp?code=free&uid=<%=uid %>">&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()">&nbsp;<%=subject%></a>
	            	<%} %>
				    <%
					String sql_c_count = "select count(*) as comment_count from comment_f where tb_uid="+uid+"";
					Connection conn_c_count = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count = conn_c_count.createStatement();
					ResultSet rs_c_count = stmt_c_count.executeQuery(sql_c_count);
					if(rs_c_count.next()){
						int total_comment = rs_c_count.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    </div>
			<div class="main_board">
		    	<h2 class="main_board_title">갤러리 인기글
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	<font color=#615454; size=1px;><a href="/gallery/list.jsp?code=gallery">[더보기]</a></font></h2>
				<%
				String sql2 = "select * from gallery where gongji != '1' order by ref desc limit 7"; //7줄 까지만 불러오기
				Connection conn2 = DriverManager.getConnection(url, user, password);
				Statement stmt2 = conn2.createStatement();
				ResultSet rs2 = stmt2.executeQuery(sql2);
				while(rs2.next()){
					String subject = rs2.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 15){
						subject = subject.substring(0,15) + "...";
					}else{
						subject = subject;
					}
					String ref = rs2.getString("ref");
					int uid = rs2.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/gallery/view.jsp?code=gallery&uid=<%=uid %>">&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()">&nbsp;<%=subject%></a>
	            	<%} %>
				    <%
					String sql_c_count2 = "select count(*) as comment_count from comment_g where tb_uid="+uid+"";
					Connection conn_c_count2 = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count2 = conn_c_count2.createStatement();
					ResultSet rs_c_count2 = stmt_c_count2.executeQuery(sql_c_count2);
					if(rs_c_count2.next()){
						int total_comment = rs_c_count2.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    </div>
			<div class="main_board">
		    	<h2 class="main_board_title">질문과답변 인기글
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	<font color=#615454; size=1px;><a href="/qna/list.jsp?code=qna">[더보기]</a></font></h2>
				<%
				String sql3 = "select * from qna where gongji != '1' order by ref desc limit 7"; //7줄 까지만 불러오기
				Connection conn3 = DriverManager.getConnection(url, user, password);
				Statement stmt3 = conn3.createStatement();
				ResultSet rs3 = stmt3.executeQuery(sql3);
				while(rs3.next()){
					String subject = rs3.getString("subject");
					int len_subject = subject.length(); //제목 길이
					if(len_subject >= 15){
						subject = subject.substring(0,15) + "...";
					}else{
						subject = subject;
					}
					String ref = rs3.getString("ref");
					int uid = rs3.getInt("uid");
				%>
		    	<div class="main_board_list">
					<%if(session_id != null && !session_id.equals("")){%>
		            	<a href="/qna/view.jsp?code=qna&uid=<%=uid %>">&nbsp;<%=subject%></a>
	            	<%}else{ %>
	            		<script>
	            			function alarm(){
	            				alert("회원만 글을 볼 수 있습니다.");
	            			}
	            		</script>
		            	<a href="" onclick="javascript:alarm()">&nbsp;<%=subject%></a>
	            	<%} %>
				    <%
					String sql_c_count3 = "select count(*) as comment_count from comment_q where tb_uid="+uid+"";
					Connection conn_c_count3 = DriverManager.getConnection(url, user, password);
					Statement stmt_c_count3 = conn_c_count3.createStatement();
					ResultSet rs_c_count3 = stmt_c_count3.executeQuery(sql_c_count3);
					if(rs_c_count3.next()){
						int total_comment = rs_c_count3.getInt("comment_count");
						if(total_comment > 0){
					%>
						[<%=total_comment %>]
		    	</div>
					<%}else{ %>
				</div>
			<%		}
				}
			}
		    %>
		    </div>
		    
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////	-->
		
		</div>
	</div>
	
<%@ include file="/include/footer.jsp" %>