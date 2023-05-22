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
String thum_img="";	//썸네일 이름

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");
String field = multi.getParameter("field");
String search = multi.getParameter("search");
String fid = multi.getParameter("fid");
String thread = multi.getParameter("thread");

Enumeration files=multi.getFileNames();

file1=(String)files.nextElement();
file1_name=multi.getOriginalFileName(file1);
file1_rename=multi.getFilesystemName(file1);

if(file1_name != null){
	String filePath = uploadPath;	//경로 위에 불러온거 그대로
    String orgImg = filePath+"\\" + file1_rename; // 경로 + 리네임 처리된 첨부파일
       
    //확장자 찾기
    int pos = orgImg.lastIndexOf( "." );
	String fileExt = orgImg.substring( pos + 1 );
	out.println("파일확장자는: "+fileExt);
    
	if(fileExt.equals("gif") || fileExt.equals("jpg") || fileExt.equals("png")){
		thum_img = "thum_"+ file1_rename;//썸네일파일 이름
		String thumbImg = filePath+"\\" + thum_img;//썸네일파일을 저장경로에 올리기
        int thumbWidth = 110 ;//썸네일 가로
        int thumbHeight = 40 ;//썸네일 세로
 
        Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
        Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
	}

}else{	//null이면
	file1_name = "";
	file1_rename = "";
}

//현재시간
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = sf.format(nowTime);

//thread 값 설정
String sql_fid = "select thread,right(thread,1) as thread_right from "+code+" where fid = "+fid+" AND length(thread) = length('"+thread+"')+1 AND locate('"+thread+"',thread) = 1 ORDER BY thread DESC limit 1";

//locate('AB' , 'ABA') = 1
//첫항의 'AB'가 두번째 항의 내용 중에 1번째 자리부터 매칭이 있는지 여부

Connection conn_count=DriverManager.getConnection(url, user, password);
Statement stmt_count=conn_count.createStatement();
ResultSet rs_count=stmt_count.executeQuery(sql_fid);

String o_thread = "";
String r_thread = "";
String thread_head = "";
String new_thread = "";
char thread_foot = 'A';

if(rs_count.next()){
	o_thread = rs_count.getString("thread");
	//끝자리 +1 처리
	r_thread = rs_count.getString("thread_right");
	thread_foot = (char)(r_thread.charAt(0) + 1);
	//out.print(thread_foot);
}

if(o_thread != null && o_thread != ""){
	thread_head = o_thread.substring(0,o_thread.length()-1);
	new_thread = thread_head + thread_foot;
}else{
	new_thread = thread+"A";
}

String sql = "insert into "+code+" (id,name,table_name,nickname,level,gongji,subject,comment,signdate, file1, file1_o, file1_s,fid,thread) values ('"+session_id+"','"+session_name+"','"+code+"','"+session_nickname+"','"+session_level+"','"+gongji+"','"+subject+"','"+comment+"','"+today+"','"+file1_rename+"','"+file1_name+"','"+thum_img+"',"+fid+",'"+new_thread+"')";
//out.print(sql);
Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);

%>

<script>
	location.href="list.jsp?code=<%=code%>";
</script>
