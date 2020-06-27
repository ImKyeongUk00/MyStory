<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") != null){
		response.sendRedirect("http://localhost:8080/myStory/diary");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "로그인"; 
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
	<nav class="navbar navbar-primary bg-primary">
		<a class="navbar-brand" href="../index.jsp" style="color: white">MyStory</a>
		<button type="button" class="btn btn-info mr-auto mt-2 mt-lg-0" href="../index.jsp">새 계정 만들기</button>
	</nav>
	<div class="card text-center mt-5">
	  <div class="card-header">
	    오늘 하루도 행복한 일로만 가득하셨나요?
	  </div>
		<div class="card-body">
			<h5 class="card-title">MyStory에 로그인</h5>
			<div class="card-text">
				<div class="container h-100">
					<div class="row h-100 justify-content-center align-items-center">
						<form class="col-md-4 p-2" action="./login_process.jsp" method="post">
							<div class="form-group">
								<input type="text" class="form-control" id="formGroupExampleInput" placeholder="이메일 또는 아이디" name="email">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" id="formGroupExampleInput2" placeholder="비밀번호" name="password">
							</div>
							<div class="form-group">
								<input type="submit" class="btn btn-primary form-control" id="formGroupExampleInput2" value="로그인" style="width: 274px;">
							</div>
						</form>   
					</div>
				</div>
			</div>
			<div>
				<a href="#" class="btn btn-link text-muted">비밀번호를 잊으셨나요?</a>
			</div>
		</div>
		<div class="card-footer text-muted">
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