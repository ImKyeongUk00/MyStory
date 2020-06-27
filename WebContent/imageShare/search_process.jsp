<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%
	String searchedString = request.getParameter("searchedString");
	
	if(searchedString == null){ //검색을 하지 않았는데 접근한다면
		response.sendRedirect("http://localhost:8080/myStory/imageShare/index.jsp");
	}else if(searchedString.equals("")){ //검색을 했지만 아무런 내용도 입력을 하지 않았다면
		response.sendRedirect("http://localhost:8080/myStory/imageShare/index.jsp");
	}else{ //검색을 했다면
%>
		<script>
			window.location.href = 'http://localhost:8080/myStory/imageShare/index.jsp?search=<%=searchedString %>';
		</script>
<%
	}
%>