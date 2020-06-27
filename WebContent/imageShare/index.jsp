<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="myStory.imageShare.*" %>
<%@ page import="myStory.member.*" %>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "공유 이미지";
		
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
	        }#container{
	      overflow: hidden;
	          position: relative;
	          height: 98px;
	          margin-bottom: 10px;
	          border: 1px solid rgb(234,234,234);
	          border-radius: 2px;
	        }#container_plus{
	         display: block;
	          overflow: hidden;
	       position: relative;
	          padding: 18px 79px 20px 30px;
	          text-align: left;
	        margin-left: 200px;
	        }#btn btn-primary{
	        width: 125px;
	    height: 36px;
	    font-size: 13px;
	    line-height: 37px;
	    border-radius: 2px;
	    border: 1px solid rgba(0,0,0,0.05);
	        }header_title{
	            width: 942px;
	            height: 40px;
	        }#body_header{
	            margin-bottom: 0px;
	        }link_plus{
	        display: block;
	    overflow: hidden;
	    position: relative;
	    padding: 18px 79px 20px 30px;
	    text-align: left;
	        }tit_invite{
	            font-size: 18px;
	        }table table-hover{
	        style="float: right;
	        }
	        hr{
		    		border: 1px solid black;
		    }
	    </style>
	</head>
	<body>
		<section id="page_header">
			<header>
				<%@ include file="../lib/navBar.jsp" %>
			</header>
		</section>
		<%
				String searchedString = request.getParameter("search");
				ImageShareDBBean imageShareProcess = ImageShareDBBean.getInstance();
				ImageShare[] posts = null;
				int postsCount = 0;
				String message = null;
				
				if(searchedString != null){ //검색을 했다면
					posts = imageShareProcess.getSearchImageSharePost(searchedString); //검색 결과만 받아온다 
					postsCount = imageShareProcess.getImageSharePostsCount(posts);
					
					if(postsCount == 0){
						message = "<p>0개의 검색결과가 있습니다.</p>";
					}
				}else{ //검색을 하지 않았다면
					posts = imageShareProcess.getPosts();//모든 게시글을 받아온다.
					searchedString = "";
					postsCount = imageShareProcess.getImageSharePostsCount(posts);
					
					if(postsCount == 0){ //검색을 하지 않았고 일기가 없다면  
						message = "<p>아직 공유된 이미지가 없습니다. 이미지를 공유해보세요</p>";
					}
				}
			%>
		<section id="page_body">
		    <header id="body_header">
		         <h3><p id="header_title" class="font-weight-bolder">공유이미지 <%=postsCount %></p></h3>
		        <p id="header_description" class="font-weight-light">MyStory 사용자들에게 이미지를 공유하고 싶다면 
		       	<button type="button" onclick="location.href='create.jsp'" style="margin-left: 400px;" class="btn btn-primary" >+ 이미지 공유하기</button></p>
		        <hr style="color: black">
	    	</header>
		    <form class="form-inline" action="http://localhost:8080/myStory/imageShare/search_process.jsp"  method="post" style="margin-left: 650px;">
			  <div class="form-group">
			    <label class="sr-olny" for="exampleInputAmount"></label>
			    <div class="input-group" >
			      <input type="text" name="searchedString" class="form-control"  id="exampleInputAmount" placeholder="이미지 검색" style="margin-bottom: 50px;">
			    </div>
			  </div>
			  <button type="submit" class="btn btn-primary" style="margin-bottom: 50px;">검색</button>
			</form>
	<%
			if(postsCount != 0){
				for(int i=0; i<postsCount; i++){
					MemberDBBean memberDBProcess = MemberDBBean.getInstance();
					Member postOwner = memberDBProcess.getMember(posts[i].getMember_id());
	%>				
				   	<div>
				        <table class="table table-hover" style="margin-bottom: 0px;" >
				            <div>         
				               <tr>
				                  <td style="padding-top: 35px; padding-bottom: 8px; height: 100px; padding-left: 50px; padding-right: 50px; letter-spacing:2px">
			                         <span style="display:inline-block; width: 640px; height: 21px;"><%=posts[i].getTitle() %></span>
			                         <span><%=postOwner.getNickname() %></span>
			                     	 <span style="float: right;"><a class="btn btn-primary btn-lg active " href="http://localhost:8080/myStory/imageShare/view.jsp?id=<%=posts[i].getId() %>" role="button">></a></span>
				                  </td> 
				               </tr>
				            </div>   
				      	</table>
				  	</div>
	<%		
				}
			}else{
	%>
				<%=message %>
	<%
			}
	%>
		</section>
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
<%
	}
%>