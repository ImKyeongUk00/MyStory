<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%> 
<%@ page import="myStory.imageShare.*"%>
<%@ page import="myStory.sharedImages.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		ImageShareDBBean imageShareProcess = ImageShareDBBean.getInstance();
		ImageShare post = new ImageShare();
		int member_id = (int)session.getAttribute("id");
		int post_id = 0;
		
		MultipartRequest multipartRequest = null;
		final String saveFolder = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/sharedImages/"; 
		final String encoding = "UTF-8"; //파일명 인코딩 방식?
		final int maxSize = 100*1024*1024; //100mb
		
		try {
			SharedImagesDBBean sharedImagesProcess = SharedImagesDBBean.getInstance();
	
			multipartRequest = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy()); //이미지 저장
	
			post.setMember_id(member_id);
			post.setTitle(multipartRequest.getParameter("title"));
			post.setDescription(multipartRequest.getParameter("description"));
			
			String userFileName = multipartRequest.getOriginalFileName("image");
			String serverFileName = multipartRequest.getFilesystemName("image");
			
			if(userFileName != null){ //사용자가 이미지를 저장 했다면 
				if(userFileName.endsWith(".jpg") || userFileName.endsWith(".png")){ //확장자가 jpg png인것만 저장한다.
					post_id = imageShareProcess.createImageSharePost(post); //일기 정보 db에 저장
					sharedImagesProcess.insertImage(post_id, userFileName, serverFileName);
					response.sendRedirect("http://localhost:8080/myStory/imageShare/view.jsp?id="+post_id);
				}else{
					File file = new File(saveFolder + serverFileName);
					file.delete();
%>
					<script>
						alert('공유할 수 없는 확장자 입니다.');
						window.location.href='http://localhost:8080/myStory/imageShare/create.jsp';
					</script>
<% 
				}
			}else{
				post_id = imageShareProcess.createImageSharePost(post); //일기 정보 db에 저장
				response.sendRedirect("http://localhost:8080/myStory/imageShare/view.jsp?id="+post_id);
			}
			
		} catch (Exception e) {
			System.out.println("Exception[create_process]: " + e.getMessage());
			e.printStackTrace();
		}
	}
%>