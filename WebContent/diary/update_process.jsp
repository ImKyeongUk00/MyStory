<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%> 
<%@ page import="myStory.diary.*"%>
<%@ page import="myStory.diaryImages.*" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("utf-8");  %>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		DiaryDBBean diaryUpdate = DiaryDBBean.getInstance();
		DiaryImagesDBBean diaryImagesProcess = DiaryImagesDBBean.getInstance();
		MultipartRequest multipartRequest = null;
		
		final String saveFolder = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/diaryImages/"; 
		final String encoding = "UTF-8"; //파일명 인코딩 방식?
		final int maxSize = 100*1024*1024; //100mb
		
		int diary_id = 0;
		String weather = null;
		String title = null;
		String description = null;
		String date = null;
		
		try{
			multipartRequest = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
			
			diary_id = Integer.parseInt(multipartRequest.getParameter("id"));
			weather = multipartRequest.getParameter("weather");
			title = multipartRequest.getParameter("title");
			description = multipartRequest.getParameter("description");
			date = multipartRequest.getParameter("date");
			
			String userFileName = multipartRequest.getOriginalFileName("image");
			String serverFileName = multipartRequest.getFilesystemName("image");
			
			Diary diary = new Diary();
			diary.setId(diary_id);
			diary.setWeather(weather);
			diary.setTitle(title);
			diary.setDescription(description);
			diary.setDate(date);
			
			DiaryImages diaryImage = diaryImagesProcess.getDiaryImage(diary_id);
			
			if(diaryImage == null){ //기존 일기에 저장 된 이미지가 없다면
				if(userFileName != null){//사용자가 이미지를 저장 하려고 하면 
					if(userFileName.endsWith(".jpg") || userFileName.endsWith(".png")){ //확장자가 jpg png인것만 저장한다.
						System.out.println("진입1");
						
						diaryUpdate.updateDiary(diary);
						diaryImagesProcess.insertImage(diary_id, userFileName, serverFileName);
						response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
					}else{
						System.out.println("진입2");
						File file = new File(saveFolder + serverFileName);
						if(file.exists()){
							if(file.delete()){
								System.out.println("이미지 삭제 성공");
							}else{
								System.out.println("이미지 삭제 실패");
							}
						}else{
							System.out.println("이미지가 존재하지 않습니다");
						}
%>
						<script>
							alert('저장할 수 없는 확장자 입니다.');
							window.location.href='http://localhost:8080/myStory/diary/update.jsp?id=<%=diary_id %>';
						</script>
<% 
					}
				}else{//사용자가 이미지를 저장 안할라고 해 
					System.out.println("진입3");
					
					diaryUpdate.updateDiary(diary);
					response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
				}
			}else{//기존 일기에 저장 된 이미지가 존재 한다면
				if(userFileName != null){ //사용자가 이미지 수정을 요청 했다면 서버에 저장 된 이미지 파일을 먼저 삭제하고 db에 저장 된 이미지 정보 수정 
					if(userFileName.endsWith(".jpg") || userFileName.endsWith(".png")){ //확장자가 jpg png인것만 저장한다.
						System.out.println("진입4");
						String deletedServerFileName = diaryImage.getServerFileName();
						
						String filePath = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/diaryImages/"
												+deletedServerFileName;
						File deletedFile = new File(filePath);
						
						if(deletedFile.exists()){
							if(deletedFile.delete()){//서버에 존재하는 이미지를 삭제
								System.out.println("이미지 삭제 성공");
							}else{
								System.out.println("이미지 삭제 실페");
							}
						}else{
							System.out.println("이미지가 존재하지 않습니다.");
						}
						diaryImagesProcess.updateDiaryImage(diaryImage.getId(), userFileName, serverFileName);
						response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
					}else{
						System.out.println("진입5");
						File file = new File(saveFolder + serverFileName);
						
						if(file.exists()){
							if(file.delete()){
								System.out.println("이미지 삭제 성공");
							}else{
								System.out.println("이미지 삭제 실패");
							}
						}else{
							System.out.println("이미지가 존재하지 않습니다");
						}
						
%>
						<script>
							alert('저장할 수 없는 확장자 입니다.');
							window.location.href='http://localhost:8080/myStory/diary/update.jsp?id=<%=diary_id %>';
						</script>
<% 
					}
				}else{ //사용자가 이미지 수정 요청을 안했으면 
					System.out.println("진입6");
					
					diaryUpdate.updateDiary(diary);
					response.sendRedirect("http://localhost:8080/myStory/diary/view.jsp?id="+diary_id);
				}
			}
		}catch(Exception e){
			System.out.println("Exception[update_process]: " + e.getMessage());
		}
	}
%>