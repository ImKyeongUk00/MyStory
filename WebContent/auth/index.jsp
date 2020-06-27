<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "계정관리"; 
%>
<!doctype html>
<html>
	<head>
		<!-- Required meta tags -->
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
	    <!-- Bootstrap CSS -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
		
	    <title><%=title %></title>
	    
	    <style>
	    	#page_body{
	    		padding-top: 74px;
	    		width: 942px;
	    		margin: 0 auto;
	    		padding-bottom: 36px;
	    	}
	    	
	    	#body_header{
	    		margin-bottom: 50px;
	    	}
	    	
	    	hr{
	    		border: 1px solid black;
	    	}
	    	
	    	.container{
	    		padding: 0px;
	    	}
	    	
	    </style>
	</head>
	<body>
		<section id="page_header">
			<header>
				<%@ include file="../lib/navBar.jsp" %>
			</header>
		</section>
		
		<section id="page_body">
			<header id="body_header">
				<h3><p class="font-weight-bolder"><%=title %></p></h3>
				<p class="font-weight-light">계정을 관리 하세요</p>
				<hr>
			</header>
			<article>
				<div id="accountManagement_box">
					<div class="container">
						<div class="jumbotron">
						  <div class="contents">
						  	  <h4>닉네임 변경</h4>
							  <form action="nicknameChange_process.jsp" method="post">
								  <div class="form-group">
								    <label for="exampleInputEmail1">별명</label>
								    <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="nickname" placeholder="변경하고싶은 닉네임을 입력하세요" value="<%=member.getNickname()%>">
								    <small id="emailHelp" class="form-text text-muted">닉네임을 변경 할 수 있어요</small>
								  </div>
								  <button type="submit" class="btn btn-primary">변경하기</button>
							  </form>
						  </div>
						</div>
					</div>
					<div class="container">
						<div class="jumbotron">
						    <div class="contents">
							    <h4>비밀번호 변경</h4>
							    <p>비밀번호를 변경하여  소중한 일기를 보호하세요</p>
							    <a class="btn btn-primary btn-sm" href="passwordChange.jsp" role="button">변경하기</a>
						    </div>
						</div>
					</div>
					<div class="container">
						<div class="jumbotron">
						  <div class="contents">
						  	  <h4>회원탈퇴</h4>
							  <p>MyStory와 작별하게 됩니다</p>
							  <a class="btn btn-primary btn-sm" href="membershipWithdrawal.jsp" role="button">탈퇴하기</a>
						  </div>
						</div>
					</div>
				</div>
			</article>
		</section>
		
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