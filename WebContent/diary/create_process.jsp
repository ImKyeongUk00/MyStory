<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%> 
<%@ page import="myStory.diary.*"%>
<%@ page import="myStory.diaryImages.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		DiaryDBBean diaryCreate = DiaryDBBean.getInstance();
		Diary diary = new Diary();
		int member_id = (int)session.getAttribute("id");
		int diary_id = 0;
		
		MultipartRequest multipartRequest = null;
		final String saveFolder = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/diaryImages/"; 
		final String encoding = "UTF-8"; //파일명 인코딩 방식?
		final int maxSize = 100*1024*1024; //100mb
		
		try {
			DiaryImagesDBBean diaryImagesProcess = DiaryImagesDBBean.getInstance();
	
			multipartRequest = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy()); //이미지 저장
	
			diary.setDate(multipartRequest.getParameter("date"));
			diary.setTitle(multipartRequest.getParameter("title"));
			diary.setWeather(multipartRequest.getParameter("weather"));
			diary.setDescription(multipartRequest.getParameter("description"));
			diary.setMember_id(member_id);
	
			String userFileName = multipartRequest.getOriginalFileName("image");
			String serverFileName = multipartRequest.getFilesystemName("image");
			
			if(userFileName != null){ //사용자가 이미지를 저장 했다면 
				if(userFileName.endsWith(".jpg") || userFileName.endsWith(".png")){ //확장자가 jpg png인것만 저장한다.
					diary_id = diaryCreate.createDiary(diary); //일기 정보 db에 저장
					diaryImagesProcess.insertImage(diary_id, userFileName, serverFileName);
					response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
				}else{
					File file = new File(saveFolder + serverFileName);
					file.delete();
%>
					<script>
						alert('저장할 수 없는 확장자 입니다.');
						window.location.href='http://localhost:8080/myStory/diary/create.jsp';
					</script>
<% 
				}
			}else{
				diary_id = diaryCreate.createDiary(diary); //일기 정보 db에 저장
				response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
			}
			
		}catch (Exception e) {
			System.out.println("Exception[create_process]: " + e.getMessage());
			e.printStackTrace();
		}
	}
%>