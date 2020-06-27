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
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { //get method�� �Ѿ�� �����͸� ó��
    	String serverFileName = request.getParameter("file"); 
    	String saveFolderPath = "C:/Users/dlaru/OneDrive/���� ȭ��/IT/project/serverProject/web/diary App/myStory/WebContent/images/sharedImages/"; 
    	String imagePath = saveFolderPath + serverFileName; //�̹����� ��θ� �ϼ�
    	
    	File file = new File(imagePath); //�̹����� File ��ü�� ���
    	
    	String mimeType = getServletContext().getMimeType(file.toString()); //�� ������ mimeType�� �����´�. mimeType�� ��� �����͸� �ְ� �޴����� ���� ����
    	
    	if(mimeType == null) {//mimeType�� null�̸� ������ �����ϱ� ���� 
    		response.setContentType("application/octet-stream");//������ ����, ����� ���忡�� ������ �޴� ������ ���� ������(��Ȯ���� 2��������)��°� response ��ü�� �����
    	}
    	
    	/////////////////////////������� ������ ���� �غ� �ϴ� �ܰ� ��
    	
    	//���� �������� ������ ������ �ڵ尡 �´�
    	
    	//������ �̸� ó��
    	String downloadName = null;
    	
    	if(request.getHeader("user-agent").indexOf("MSIE") == -1) { //������� �������� internet explorer�� �ƴ϶�� ���� �̸��� utf-8�� ���ڵ����ش�.
    		downloadName = new String(serverFileName.getBytes("UTF-8"), "8859_1");
    	}else {
    		downloadName = new String(serverFileName.getBytes("EUC-KR"), "8859_1");
    	}
    	
    	response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";"); //���� �����  �䷱ ������ �־��ְ�
    	
    	FileInputStream fileInputStream = new FileInputStream(file);
    	ServletOutputStream servletOutputStream = response.getOutputStream();
    	
    	byte[] b = new byte[1024]; //�����͸� 1024����Ʈ �� ��� ����
    	int data = 0;
    	
    	while((data = fileInputStream.read(b, 0, b.length)) != -1) {
    		servletOutputStream.write(b, 0, data);
    	}
    	
    	servletOutputStream.flush(); //���� ���۸� ����ش�.
    	servletOutputStream.close();
    	fileInputStream.close();
    }

}
