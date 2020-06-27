<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="myStory.diary.*"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "나의 일기";
		DiaryDBBean diaryList = DiaryDBBean.getInstance(); 
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
				<%
					String searchedString = request.getParameter("search");
					Diary[] diarys = null;
					int diaryCount;
					String message = null;
					
					if(searchedString != null){ //검색을 했다면
						diarys = diaryList.getSearchDiary(member_id, searchedString); //검색 결과만 받아온다 
						diaryCount = diaryList.getDiaryCount(diarys);
						
						if(diaryCount == 0){
							message = "<p>0개의 검색결과가 있습니다.</p>";
						}
					}else{ //검색을 하지 않았다면
						diarys = diaryList.getDiarys(member_id);//사용자의 모든 일기를 받아온다 
						searchedString = "";
						diaryCount = diaryList.getDiaryCount(diarys);
						
						if(diaryCount == 0){ //검색을 하지 않았고 일기가 없다면  
							message = "<p>아직 작성한 일기가 없습니다. 지금 일기를 작성해 보세요</p>";
						}
					}
				%>
			</header>
		</section>
		<section id="page_body">
		    <header id="body_header">
		         <h3><p id="header_title" class="font-weight-bolder">나의 일기 <%=diaryCount %></p></h3>
		        <p id="header_description" class="font-weight-light">지나온 날을 추억하는 방법! 지금 일기를 작성하세요
		        <button type="button" onclick="location.href='create.jsp'" style="margin-left: 400px;" class="btn btn-primary">+ 새 일기 만들기</button></p>
		        <hr style="color: black">
		    </header>
			<form class="form-inline" style="margin-left: 650px;" action="http://localhost:8080/myStory/diary/search_process.jsp" method="post">
			  <div class="form-group">
			    <label class="sr-olny" for="exampleInputAmount"></label>
			    <div class="input-group" >
			      <input type="text" name="searchedString" class="form-control"  id="exampleInputAmount" value="<%=searchedString %>" placeholder="제목입력" style="margin-bottom: 50px;">
			    </div>
			  </div>
		  	  <button type="submit" class="btn btn-primary" style="margin-bottom: 50px;">검색</button>
			</form>
		   	<div>
<%
			if(diaryCount != 0){
						for(int i=0; i<diaryCount; i++) {
%>
              <table class="table table-hover" style="margin-bottom: 0px;" >
                  <div>         
                     <tr>

	                        <td style="padding-top: 35px; padding-bottom: 8px; height: 100px; padding-left: 50px; padding-right: 50px; letter-spacing:2px">
	                               <span style="display:inline-block; width: 640px; height: 21px;"><%=diarys[i].getTitle()%></span>
	                               <span><%=diarys[i].getDate() %></span>
	                               <span style="float: right;"><a class="btn btn-primary btn-lg active" href="http://localhost:8080/myStory/diary/view.jsp?id=<%=diarys[i].getId() %>" role="button">></a></span>
	                        </td> 

                     </tr>
                  </div>   
            </table>
<%
						}
%>
         </div>
<% 
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
</html>
<%
	}
%>
