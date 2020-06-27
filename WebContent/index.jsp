<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") != null){
		response.sendRedirect("http://localhost:8080/myStory/diary/index.jsp");
	}else{
%>
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <title>MyStory</title>
	<style>
	.top6 { margin-top: 6%;}
	.card-top { margin-top: 4%;}
	.left70 { margin-left: 6%;}
	.pull-right { float: right; }
	.pull-left { float: left; }
	.right50 {margin-right: 6%;}
	.font-size1 {font-size: 45px; }
	.font-size2 {font-size: 18px; }
	.top3 { margin-top: 30px; }
	
	</style>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-primary bg-primary">
		<a class="navbar-brand ml-3 text-danger" href="http://localhost:8080/myStory"><span style="color: white;"><h1>MyStory</h1></span></a>
			<ul class="nav mr-auto">
				<p style="color: white; margin-top: 17px">당신의 소중한 일상을 담은 일기장, MyStory와 함께 하세요</p>
			</ul>
		<form method="post" action="./auth/login_process.jsp">
			<div class="form-row" style="width: 26rem;">
				<div class="col">
					<input type="text" class="form-control form-control-sm" placeholder="아이디" name="email">
				</div>
				<div class="col">
					<input type="password" class="form-control form-control-sm" placeholder="비밀번호" name="password">
				</div>
				<div class="col">
					<button type="submit" class="btn btn-outline-secondary btn-sm"><span style="color: white;">로그인</span></button>
				</div>
			</div>
		</form>
	</nav>
	
	<div id="demo" class="carousel slide top6 left70 pull-left" data-ride="carousel" style="width: 630px; height: 400px;">

		<!-- Indicators -->
		<ul class="carousel-indicators">
			<li data-target="#demo" data-slide-to="0" class="active"></li>
			<li data-target="#demo" data-slide-to="1"></li>
			<li data-target="#demo" data-slide-to="2"></li>
		</ul>
  
		<!-- The slideshow -->
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="./images/indexSlide/slide1.jpg" alt="Los Angeles" width="630" height="390">
			</div>
			<div class="carousel-item">
				<img src="./images/indexSlide/slide2.jpg" alt="Chicago" width="630" height="390">
			</div>
			<div class="carousel-item">
				<img src="./images/indexSlide/slide3.jpg" alt="New York" width="630" height="390">
			</div>
		</div>

		
	</div>
	<div class="card pull-right card-top right50 border-0" style="width: 27rem;">
			<form action="./auth/signup_process.jsp" method="post">
				<div class="card-body">
					<h1 class="card-title font-size1">가입하기</h1>
					<h6 class="card-subtitle text-muted font-size2 mb-4">당신의 소중한 추억을 간직하세요.</h6>
					<div class="form-group top3">
						<input type="text" class="form-control col-md-11" id="formGroupExampleInput" placeholder="별명" name="nickname" required>
					</div>
					<div class="form-group mt-2">
						<input type="text" class="form-control col-md-11" id="formGroupExampleInput" placeholder="아이디" name="email" required>
					</div>
					<div class="form-group mt-2">
						<input type="password" class="form-control col-md-11" id="formGroupExampleInput" placeholder="비밀번호" name="password" required>
					</div>
					<div class="form-group mt-2">
						<input type="password" class="form-control col-md-11" id="formGroupExampleInput" placeholder="비밀번호 확인" name="passwordCheck" required>
					</div>
					<div>
						<input type="submit" value="회원가입" class="btn btn-secondary btn-outline-dark col-md-11 mt-3 btn-lg">
					</div>
				</div>
			</form>
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