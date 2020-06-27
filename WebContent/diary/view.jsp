<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.diary.*" %>
<%@ page import="myStory.diaryImages.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	DiaryDBBean diaryProcess = DiaryDBBean.getInstance();
	int diary_id = Integer.parseInt(request.getParameter("id"));
	Diary diary = diaryProcess.getDiary(diary_id);
	
	if(session.getAttribute("id") == null){ //로그인 되지 않은 상태라면 
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else if(diary.getMember_id() != (int)session.getAttribute("id")){ //본인의 일기가 아닌 일기에 url로 접근하면
		response.sendRedirect("http://localhost:8080/myStory/error.jsp");
	}else{
		String title = diary.getTitle();
		String weather = diary.getWeather();
		String date = diary.getDate();
		String description = diary.getDescription();
		
		DiaryImagesDBBean diaryImagesProcess = DiaryImagesDBBean.getInstance();
		DiaryImages diaryImage = diaryImagesProcess.getDiaryImage(diary_id);
		String saveFolder = null;
		String imagePath = null;
		if(diaryImage != null){
			saveFolder = "../images/diaryImages/";
			imagePath = saveFolder + diaryImage.getServerFileName(); 
		}
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
	    		padding-bottom: 36px
	    	}
	    	
	    	#body_header{
	    		margin-bottom: 50px;
	    	}
	    	
	    	hr{
	    		border: 1px solid black;
	    	}
	    	
	    	img{
	    		width: 500px;
	    		height: 500px;
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
				<h3 class="font-weight-bolder" style="display: inline;"><%=title %></h3>
				<p style="display: inline; margin-left: 10px;"><%=date %> | </p>
				<p style="display: inline; "><%=weather %></p>
				<div style="float: right;">
					<a href="index.jsp">목록으로</a>	
				</div>	
						
				<hr>
			</header>
			<article>
				<div style="margin-bottom: 30px;">
					<p><%=description %></p>
				</div>
				<div id='image_preview'>
<%
				if(diaryImage != null){
%>
					<img src="<%=imagePath%>">
<%
				}
%>
				</div>
				<hr>
				<button class="btn btn-primary" onclick="location.href='update.jsp?id=<%=diary_id %>'" style="margin-left: 750px;">수정하기</button>
				<form action="delete_process.jsp" method="post" style="display: inline;">
					<input type="hidden" name="id" value="<%=diary_id %>">
					<button class="btn btn-primary" type="submit">삭제하기</button>
				</form>
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
