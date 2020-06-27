package myStory.sharedImages;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DownloadImage_process")
public class DownloadImage_process extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { //get method로 넘어온 데이터를 처리
    	String serverFileName = request.getParameter("file"); 
    	String saveFolderPath = "C:/Users/dlaru/OneDrive/바탕 화면/IT/project/serverProject/web/diary App/myStory/WebContent/images/sharedImages/"; 
    	String imagePath = saveFolderPath + serverFileName; //이미지의 경로를 완성
    	
    	File file = new File(imagePath); //이미지를 File 객체에 담고
    	
    	String mimeType = getServletContext().getMimeType(file.toString()); //그 파일의 mimeType을 가져온다. mimeType은 어떠한 데이터를 주고 받는지에 대한 정보
    	
    	if(mimeType == null) {//mimeType이 null이면 오류를 방지하기 위해 
    		response.setContentType("application/octet-stream");//응답할 정보, 사용자 입장에서 본인이 받는 정보가 파일 데이터(정확히는 2진데이터)라는걸 response 객체에 담아줌
    	}
    	
    	/////////////////////////여기까지 파일을 보낼 준비 하는 단계 끝
    	
    	//이제 실질적인 파일을 보내는 코드가 온다
    	
    	//파일의 이름 처리
    	String downloadName = null;
    	
    	if(request.getHeader("user-agent").indexOf("MSIE") == -1) { //사용자의 브라우저가 internet explorer가 아니라면 파일 이름을 utf-8로 인코딩해준다.
    		downloadName = new String(serverFileName.getBytes("UTF-8"), "8859_1");
    	}else {
    		downloadName = new String(serverFileName.getBytes("EUC-KR"), "8859_1");
    	}
    	
    	response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";"); //응답 헤더에  요런 정보를 넣어주고
    	
    	FileInputStream fileInputStream = new FileInputStream(file);
    	ServletOutputStream servletOutputStream = response.getOutputStream();
    	
    	byte[] b = new byte[1024]; //데이터를 1024바이트 씩 끊어서 전송
    	int data = 0;
    	
    	while((data = fileInputStream.read(b, 0, b.length)) != -1) {
    		servletOutputStream.write(b, 0, data);
    	}
    	
    	servletOutputStream.flush(); //남은 버퍼를 비워준다.
    	servletOutputStream.close();
    	fileInputStream.close();
    }

}
