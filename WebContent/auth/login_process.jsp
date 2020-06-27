<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="myStory.member.Member">
	<jsp:setProperty name="member" property="*" />	
</jsp:useBean>
<% 
	MemberDBBean memberProcess = MemberDBBean.getInstance();
	int loginUserID = memberProcess.getLoginUserID(member);	

	if(loginUserID != -1){//로그인 성공하면 
		session.setAttribute("id", loginUserID);
%>
		<script>
			window.location.href = 'http://localhost:8080/myStory/diary/index.jsp';
		</script>
<% 
	}else{
%>
		<script>
			alert("아이디 또는 비밀번호를 잘 못 입력하셨습니다.");
			history.go(-1);  
		</script>
<%
	}
%>