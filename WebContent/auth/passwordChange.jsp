<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "비밀번호 변경"; 
%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <title><%=title %></title>
   
  </head>
  <body>
   <%@ include file="../lib/navBar.jsp" %>
   <form action="passwordChange_process.jsp" method="post">
   	<div class="card w-70 mx-auto border border-secondary mt-5" style="width: 27rem;">
	  <div class="card-body w-60">
	    <h3 class="card-title">비밀번호 변경</h3>
	      <ul class="list-unstyled">
	        <li>안전한 비밀번호로 내정보를 보호하세요.</li>
	            <h6>
		            <ul>
		                <li><small>다른 사이트에서 사용한 적 없는 비밀번호</small></li>
		                <li><small>이전에 사용한 적 없는 비밀번호가 안전합니다.</small></li>
		            </ul>
	            </h6>
	       </ul>
	   	   <div class="form-group mt-4">
		      <input type="password" name="oldPassword" class="form-control" id="formGroupExampleInput" placeholder="현재 비밀번호" required>
		   </div>
		   <div class="form-group">
		      <input type="password" name="newPassword" class="form-control mb-1" id="formGroupExampleInput2" placeholder="새 비밀번호" required>
		      <input type="password" name="newPasswordCheck" class="form-control" id="formGroupExampleInput2" placeholder="새 비밀번호 확인" required>
		   </div>
		   <div>
		      <button type="submit" class="btn btn-primary col-md-12 mt-3">변경</button>
		   </div>
		   <div>
		      <a href="http://localhost:8080/myStory/auth/index.jsp" class="btn btn-light border border-dark col-md-12 mt-2">취소</a>
		   </div>
	   </div>
	</div>
   </form>
   
   
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
<%
	}
%>