<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String password = request.getParameter("password");
	MemberDBBean memberProcess = MemberDBBean.getInstance();
	int member_id = (int)session.getAttribute("id");
	
	if(memberProcess.passwordAuthentication(member_id, password)){
		session.invalidate();
		memberProcess.deleteMember(member_id);
%>
		<script>
			alert("그동안 MyStory를 이용해 주셔서 감사했습니다.");
			window.location.href = 'http://localhost:8080/myStory/index.jsp';
		</script>
<%		
	}else{
%>
		<script>
			alert("비밀번호가 다릅니다.");
			history.go(-1);
		</script>
<%		
	}
%>