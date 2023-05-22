
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//String uploadPath=request.getRealPath("../upload");
String uploadPath="C:\\WORK\\jsp\\project01\\src\\main\\webapp\\upload";

int size=10*1024*1024;	//10mb 용량제한

String file1="";	//form 으로 넘어온 이름
String file1_name="";	//원본이름
String file1_rename="";	//재설정한 이름
String thum_img = "";	//썸네일 파일 이름

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");

Enumeration files=multi.getFileNames();

file1=(String)files.nextElement();
file1_name=multi.getOriginalFileName(file1);
file1_rename=multi.getFilesystemName(file1);


if(file1_name != null){		//썸네일 생성공간 ( 인터넷에서 복붙함)
	String filePath = uploadPath;	//저장 공간 경로 설정
String orgImg = filePath+"\\"+file1_rename;//경로 + 리네임 처리된 첨부파일

//확장자 찾기
int pos = orgImg.lastIndexOf( "." );
String fileExt = orgImg.substring( pos + 1 );
out.println("파일확장자는: "+fileExt);

if(fileExt.equals("gif") || fileExt.equals("jpg") || fileExt.equals("png")){
	thum_img = "thum_"+file1_rename;//썸네일파일 이름
	String thumbImg  = filePath+"\\"+thum_img; //썸네일파일 저장경로에 올려보자
	int thumbWidth = 400;//썸네일 가로
	int thumbHeight = 400;//썸네일 세로
	
	Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
	Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
}

}else{
file1_name = "";
file1_rename = "";
}

//현재 시간
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = sf.format(nowTime);

//답변 fid 값 설정
String sql_fid = "select max(fid) as fid_max from "+code;		// 제일 큰 fid 값을 읽어와서 fid_max라고 부르자 code명에서(notice || qna || gallery) -> jsp게시판 22번글

Connection conn_count=DriverManager.getConnection(url, user, password);
Statement stmt_count=conn_count.createStatement();
ResultSet rs_count=stmt_count.executeQuery(sql_fid);

int fid = 1; //default = 1 처리
if(rs_count.next()){
if(rs_count.getInt("fid_max") > 0){
	fid = rs_count.getInt("fid_max") + 1;
}else{	//작성된 글이 없다면
	fid = 1;
}
}

String sql = "insert into "+code+" (id,table_name,name,nickname,level,gongji,subject,comment,signdate, file1, file1_o, file1_s, fid, thread) values ('"+session_id+"','"+code+"','"+session_name+"','"+session_nickname+"', '"+session_level+"','"+gongji+"','"+subject+"','"+comment+"','"+today+"','"+file1_rename+"','"+file1_name+"','"+thum_img+"',"+fid+",'A')";
//out.print(sql);
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);
%>    

<script>
location.href="list.jsp?code=<%=code%>";
</script>



