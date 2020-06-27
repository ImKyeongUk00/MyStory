<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.diary.DiaryDBBean" %>
<%@ page import="myStory.diaryImages.*" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(request.getParameter("id") == null){ //넘어온 id값이 없으면 그냥 url로 접근한거기 때문에 404페이지로 리다이렉트 해준다.
		response.sendRedirect("http://localhost:8080/myStory/error.jsp");	
	}

	int diary_id = Integer.parseInt(request.getParameter("id"));
	//서버에 저장 된 이미지를 삭제해주는 코드, 일기를 삭제하기 전에 해줘야 된다 왜냐하면 일기가 삭제되면 db에 diaryimage도 같이 삭제되어 서버에있는 이미지에 접근을 할 수 없기 때문에
	DiaryImagesDBBean diaryImagesProcess = DiaryImagesDBBean.getInstance();
	DiaryImages diaryImage = diaryImagesProcess.getDiaryImage(diary_id);
	
	if(diaryImage != null){ //저장 된 이미지가 있다면 서버에 저장 된 이미지를 삭제해준다.
		String filePath = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/diaryImages/"+diaryImage.getServerFileName();
		File deletedFile = new File(filePath);
		
		if(deletedFile.exists()){
			if(deletedFile.delete()){
				System.out.println("이미지 삭제 성공");
				diaryImagesProcess.deleteDiaryImage(diaryImage.getId());
			}else{
				System.out.println("이미지 삭제 실페");
			}
		}else{
			System.out.println("이미지가 존재하지 않습니다.");
		}		
	}

	//일기 삭제
	DiaryDBBean diaryProcess = DiaryDBBean.getInstance();
	
	diaryProcess.deleteDiary(diary_id);
	
	response.sendRedirect("http://localhost:8080/myStory/diary/index.jsp");
%>