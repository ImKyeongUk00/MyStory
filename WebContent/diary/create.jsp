<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null){
		response.sendRedirect("http://localhost:8080/myStory/auth/login.jsp");
	}else{
		request.setCharacterEncoding("utf-8");
		String title = "일기 작성하기"; 
%>
<!doctype html>
<html>
	<head>
		<!-- Required meta tags -->
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
	    <!-- Bootstrap CSS -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
		
		<!-- JQuery UI datepicker -->
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		
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
	    	
	    	img{
	    		width: 200px; 
	    		height: 200px
	    	}
	    	/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
			.ui-datepicker-trigger{cursor: pointer;}
			/*datepicer input 롤오버 시 손가락 모양 표시*/
			.hasDatepicker{cursor: pointer;}
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
				<p class="font-weight-light">지나온 날을 추억하는 방법! 지금 일기를 작성하세요</p>
				<hr>
			</header>
			<article>
				<form action="create_process.jsp" method="post" enctype="multipart/form-data">
					<div class="input-group">
					  <label>
					  	<span class="font-weight-bolder">날짜</span>
					  	<input type="text" id="datepicker" name="date" class="form-control" style="margin-right: 40px;" placeholder="날짜를 선택하세요" required>
					  </label>
					  <label>
					  	<span class="font-weight-bolder">일기 제목</span>
					  	<input type="text" class="form-control" name="title" aria-label="Text input with dropdown button" style="width: 700px" placeholder="일기의 제목을 입력하세요" max="20" required>
					  </label>
					  <label style="margin-left: 24px">
						<span class="font-weight-bolder">날씨</span>
						<select class="custom-select" name="weather">
						  <option value="맑음" selected>맑음</option>
						  <option value="비">비</option>
						  <option value="구름 조금">구름 조금</option>
						  <option value="흐림">흐림</option>
						  <option value="눈">눈</option>
						</select>
					  </label>
					  
					  <div class="form-group">
					    <label for="exampleFormControlFile1" style="margin-top: 10px">
					    	<span class="font-weight-bolder">나의 일기에 사진을 넣어보세요</span>
					    </label>
					    <input type="file" name="image" class="form-control-file" id="exampleFormControlFile1" onchange="previewImages(event)">
					  </div>
					  <div class="form-group">
					    <label for="exampleFormControlTextarea1" class="font-weight-bolder">일기 내용</label>
					    <textarea class="form-control" id="exampleFormControlTextarea1"  name="description" placeholder="오늘 경험했던 일들, 느꼇던 감정 등을 기록하세요 " rows="10" style="width: 942px" required></textarea>
					  </div>
					  <div id='image_preview'>
					      <!-- 미리보기 공간 -->
					  </div>
					  <hr style="width:940px;">
					  <div style="margin-left: 787px;">
					  	<button class="btn btn-primary" type="submit">작성완료</button>
					  	<button type="button" onclick="location.href='index.jsp'" class="btn btn-secondary">취소</button>
					  </div>
					</div>
				</form>
			</article>
		</section>
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
	<script>
        $("#datepicker").datepicker({
        	dateFormat: 'yy-mm-dd' //Input Display Format 변경
       		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        	,maxDate: 0
        });
        
      	//초기값을 오늘 날짜로 설정
        $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    </script>
</html>
<%	
	}
%>