<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<% 
	String oldPassword = request.getParameter("oldPassword");
	MemberDBBean memberProcess = MemberDBBean.getInstance();
	int member_id = (int)session.getAttribute("id");
	
	if(memberProcess.passwordAuthentication(member_id, oldPassword)){ //비밀번호가 맞다면
		String newPassword = request.getParameter("newPassword");
		String newPasswordCheck = request.getParameter("newPasswordCheck");
		
		if(newPassword.equals(newPasswordCheck)){
			memberProcess.passwordChange(member_id, newPassword);
%>
			<script>
				alert("비밀번호 변경 완료");
				window.location.href = 'http://localhost:8080/myStory/auth/index.jsp';
			</script>
<% 
		}else{
%>
			<script>
				alert("새 비밀번호가 동일하지 않습니다.");
				history.go(-1);
			</script>
<% 			
		}
	}else{
%>
		<script>
			alert("현재 비밀번호를 잘 못 입력하셨습니다.");
			history.go(-1);
		</script>
<%	
	}
%>