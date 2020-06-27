<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String changedNickname = request.getParameter("nickname");

	if(changedNickname.equals("") || changedNickname == null){
%>
		<script>
			alert("잘못된 요청입니다.");
			history.go(-1);
		</script>
<% 		
	}else{
		MemberDBBean memberProcess = MemberDBBean.getInstance();
		int member_id = (int)session.getAttribute("id");	
		
		memberProcess.changeMemberNickname(member_id, changedNickname);
%>
		<script>
			alert("닉네임이 변경되었습니다.");
			window.location.href = 'http://localhost:8080/myStory/auth/index.jsp';
		</script>
<%	
	}
%>
	

