<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "회원탈퇴"; 
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
   
   <div class="card w-70 mx-auto border border-secondary mt-5" style="width: 27rem;">
	  <div class="card-body w-60">
	    <h3 class="card-title">회원 탈퇴</h5>
	   <ul class="list-unstyled">
	        <li>비밀번호를 입력하고 회원탈퇴를 완료하세요</li>
	   </ul>
	   <form action="membershipWithdrawal_process.jsp" method="post">
		   <div class="form-group">
		      <input type="password" class="form-control mb-1" id="formGroupExampleInput2" placeholder="비밀번호" name="password" required>
		   	  <input type="submit" class="btn btn-primary col-md-12 mt-3" value="탈퇴하기">			
		   </div>
	   </form>
	   <div>
	      <a href="index.jsp" class="btn btn-light border border-dark col-md-12 mt-2">취소</a>
	   </div>
	  </div>
	</div>
   
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