<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "이미지 공유하기"; 
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
				<h3><p class="font-weight-bolder"><%=title %></p></h3>
				<p class="font-weight-light">예쁜 사진을 MyStory사용자에게 공유하고 싶다면? 지금 사진을 공유하세요</p>
				<hr>
			</header>
			<article>
				<form action="create_process.jsp" method="post" enctype="multipart/form-data">
					<div class="input-group">
					  <label>
					  	<span class="font-weight-bolder">사진 이름</span>
					  	<input type="text" class="form-control" name="title" aria-label="Text input with dropdown button" style="width: 910px" placeholder="사진의 이름을 입력하세요" required>
					  </label>
					  <div class="form-group">
					    <label for="exampleFormControlFile1" style="margin-top: 10px">
					    	<span class="font-weight-bolder">공유하고 싶은 사진을 첨부하세요</span>
					    </label>
					    <input type="file" name="image" class="form-control-file" id="exampleFormControlFile1" onchange="previewImages(event)" required>
					  </div>
					  <div class="form-group">
					    <label for="exampleFormControlTextarea1" class="font-weight-bolder">사진 설명</label>
					    <textarea class="form-control" id="exampleFormControlTextarea1"  name="description" placeholder="이 사진이 어떤 사진인지 설명하세요" rows="10" style="width: 942px" required></textarea>
					  </div>
					  <div id='image_preview'>
					      <!-- 미리보기 공간 -->
					  </div>
					  <hr style="width:940px;">
					  <div style="margin-left: 787px;">
					  	<button class="btn btn-primary" type="submit">공유하기</button>
					  	<button type="button" onclick="location.href='index.jsp'" class="btn btn-secondary">취소</button>
					  </div>
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
	<script>
		function previewImages(event){
			for(var image of event.target.files){
				var reader = new FileReader();
				
				reader.onload = function(event){
					var img = document.createElement("img");
					
					img.setAttribute("src", event.target.result);
					img.setAttribute("class", "rounded-sm");
					img.setAttribute("style", "width: 200px; height: 200px");
					document.querySelector("#image_preview").appendChild(img);
				};
				
				reader.readAsDataURL(image);
			}
		}
	</script>
</html>
<%
	}
%>