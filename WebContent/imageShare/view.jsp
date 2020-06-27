<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myStory.member.*" %>
<%@ page import="myStory.imageShare.*" %>
<%@ page import="myStory.sharedImages.*" %>
<% request.setCharacterEncoding("utf-8"); %>    
<%
	ImageShareDBBean imageShareProcess = ImageShareDBBean.getInstance();
	int post_id = Integer.parseInt(request.getParameter("id"));
	ImageShare post = imageShareProcess.getPost(post_id);
	
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		String title = post.getTitle(); 
		String description = post.getDescription();
		String created = post.getCreated();
		
		//공유글의 소유자 처리
		MemberDBBean memberDBProcess = MemberDBBean.getInstance();
		Member postOwner = memberDBProcess.getMember(post.getMember_id());
		
		//이미지 경로 처리
		SharedImagesDBBean sharedImagesProcess = SharedImagesDBBean.getInstance();
		SharedImages sharedImage = sharedImagesProcess.getSharedImage(post_id);
		String saveFolder = null;
		String imagePath = null;
		if(sharedImage != null){
			saveFolder = "../images/sharedImages/";
			imagePath = saveFolder + sharedImage.getServerFileName(); 
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
	    		width: 200px; 
	    		height: 200px
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
				<p style="display: inline; margin-left: 10px;"><%=created %> | </p>
				<p style="display: inline; "><%=postOwner.getNickname() %></p>	
				<div style="float: right;">
					<a href="<%=request.getContextPath() %>/DownloadImage_process?file=<%=java.net.URLEncoder.encode(sharedImage.getServerFileName(), "UTF-8") %>"><button class="btn btn-primary">이미지 다운로드</button></a>
				</div>
				<hr>
			</header>
			<article>
				<div style="margin-bottom: 30px;">
					<p><%=post.getDescription() %></p>
				</div>
				<div id='image_preview'>
					<img src="<%=imagePath%>">
				</div>
				<hr>
				<form action="delete_process.jsp" method="post" style="display: inline;">
					<div class="input-group">
						<input type="hidden" name="id" value="<%=post_id%>">
						<input type="password" name="password" class="form-control" name="title" aria-label="Text input with dropdown button" placeholder="비밀번호 입력" style="margin-left: 600px; margin-right: 10px;">
						<input type="submit" value="삭제하기" class="btn btn-primary">
					</div>
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