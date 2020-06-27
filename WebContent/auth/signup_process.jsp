<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="myStory.member.Member">
	<jsp:setProperty name="member" property="nickname" />
	<jsp:setProperty name="member" property="email" />
	<jsp:setProperty name="member" property="password" />
</jsp:useBean>
<% 
	String passwordCheck = request.getParameter("passwordCheck"); //비밀번호 확인
	MemberDBBean memberProcess = MemberDBBean.getInstance();
	int result = 0;	
	
	if(passwordCheck.equals(member.getPassword())){
		result = memberProcess.insertMember(member);	
	}else{
%>	
		<script>
			alert("입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			window.location.href = 'http://localhost:8080/myStory/';
		</script>
<%
	}	
%>
<%
	if(result == -1){
%>
	<script>
		alert("중복된 아이디가 존재합니다.");
		window.location.href = 'http://localhost:8080/myStory/';
	</script>
<%
	}else{
%>
	<script>
		alert("myStory에 오신걸 환영합니다.");
		window.location.href = 'http://localhost:8080/myStory/auth/login.jsp';
	</script>
<% 
	}
%>	