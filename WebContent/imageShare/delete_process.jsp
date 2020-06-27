<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.imageShare.*" %>
<%@ page import="myStory.sharedImages.*" %>
<%@ page import="myStory.member.*" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("id") == null){ //로그인 되지 않은 사용자가 url로 접근하면 로그인 페이지로 redirect 해준다
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}
	
	if(request.getParameter("id") == null){ //넘어온 id값이 없으면 그냥 url로 접근한거기 때문에 404페이지로 리다이렉트 해준다.
		response.sendRedirect("http://localhost:8080/myStory/error.jsp");	
	}
	
	int post_id = Integer.parseInt(request.getParameter("id"));
	ImageShareDBBean imageShareProcess = ImageShareDBBean.getInstance();
	ImageShare post = imageShareProcess.getPost(post_id);
	
	int member_id = (int)session.getAttribute("id");
	
	if(member_id != post.getMember_id()){ //삭제하기 버튼을 누른 사용자가 게시글의 주인이 아니라면
%>
		<script>
			alert("게시글의 작성자가 아니라면 삭제를 할 수 없습니다.");
			history.go(-1);
		</script>
<%
	}else{
		MemberDBBean memberDBProcess = MemberDBBean.getInstance();
		Member member = memberDBProcess.getMember(member_id);
		if(!(member.getPassword().equals(request.getParameter("password")))){//비밀번호 입력이 틀렸을 경우에
%>	
			<script>
				alert("비밀번호가 일치하지 않습니다.");
				history.go(-1);
			</script>
<%
		}else{ //맞으면 일기를 삭제해준다.
			//서버에 저장 된 이미지를 삭제해주는 코드
			SharedImagesDBBean sharedImagesProcess = SharedImagesDBBean.getInstance();
			SharedImages sharedImage = sharedImagesProcess.getSharedImage(post_id);
			
			String filePath = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/sharedImages/"+sharedImage.getServerFileName();
			File deletedFile = new File(filePath);
			
			if(deletedFile.exists()){
				if(deletedFile.delete()){
					System.out.println("이미지 삭제 성공");
					sharedImagesProcess.deleteSharedImage(sharedImage.getId());//db에 있는 이미지 정보도 삭제
				}else{
					System.out.println("이미지 삭제 실페");
				}
			}else{
				System.out.println("이미지가 존재하지 않습니다.");
			}
			
			
			//이미지 공유 게시판 삭제
			imageShareProcess.deleteImageSharePost(post_id);
%>
			<script>
				alert("삭제 완료");
			</script>
<% 
			response.sendRedirect("http://localhost:8080/myStory/imageShare/index.jsp");
		}
	}
%>
	
	