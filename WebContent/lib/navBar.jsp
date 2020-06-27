<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>
<% 
	MemberDBBean memberProcess = MemberDBBean.getInstance();
	int member_id = (int)session.getAttribute("id");
	Member member = memberProcess.getMember(member_id);  
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	  <h1>
	  	<a class="navbar-brand" href="http://localhost:8080/myStory/diary">
			MyStory
		</a>
	  </h1>
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <p class="font-weight-bolder"><a class="nav-link" href="../imageShare/index.jsp">Image Share</a></p>
	      </li>
	      <li class="nav-item">
	      	<p class="nav-link">오늘 경험했던 일, 느꼇던 감정  MyStory와 함께하세요</p>
	      </li>
	    </ul>
	    <div class="btn-group dropleft">
		  <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: white;">
		  	<%=member.getNickname() %> | <%=member.getEmail() %> 
		  </a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="../auth/index.jsp">계정 관리</a>
	        <a class="dropdown-item" href="../auth/logout_process.jsp">로그아웃</a>
		  </div>
		</div>
	  </div>
</nav>