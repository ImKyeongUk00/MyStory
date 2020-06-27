package myStory.diaryImages;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DiaryImagesDBBean {
private static DiaryImagesDBBean instance = new DiaryImagesDBBean();
	
	private DiaryImagesDBBean() {
		
	}
	
	public static DiaryImagesDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		String jdbcUrl="jdbc:mysql://localhost:3306/mystory";
		String dbId="root";
		String dbPassword="wjdqhqhdks";
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(jdbcUrl, dbId, dbPassword);
	}
	
	public void insertImage(int diary_id, String userFileName, String serverFileName) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "INSERT INTO diaryimages (diary_id, userfilename, serverfilename) VALUES (?, ?, ?)";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, diary_id);
			preparedStatement.setString(2, userFileName);
			preparedStatement.setString(3, serverFileName);
			preparedStatement.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("Exception[insertImage]: " + e.getMessage());
		}finally {
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {}
			}
			
			if(connection != null) {
				try {
					connection.close();
				}catch(SQLException e) {}
			}
		}
		
	}
	
	public DiaryImages getDiaryImage(int diary_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		DiaryImages diaryImage = null;
		
		try {
			String sql = "SELECT * FROM diaryimages where diary_id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, diary_id);
			resultSet = preparedStatement.executeQuery();
			System.out.println("요오오오ㅗ기 진입");
			if(resultSet.next()) {
				System.out.println("여기 진입");
				diaryImage = new DiaryImages();
				diaryImage.setId(resultSet.getInt("id"));
				diaryImage.setDiary_id(resultSet.getInt("diary_id"));
				diaryImage.setServerFileName(resultSet.getString("serverFileName"));
				diaryImage.setUserFileName(resultSet.getString("userFileName"));
			}
		}catch(Exception e) {
			System.out.println("Exception[getDiaryImage]" + e.getMessage());
		}finally {
			if(resultSet != null) {
				try {
					resultSet.close();
				}catch(SQLException e){}
			}
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {}
			}
			
			if(connection != null) {
				try {
					connection.close();
				}catch(SQLException e) {}
			}
		}
		System.out.println("getDiaryImage: " + diaryImage);
		return diaryImage;
	}
	
	public void updateDiaryImage(int diaryImage_id, String newUserFileName, String newServerFileName) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "UPDATE diaryimages SET userfilename=?, serverfilename=? WHERE id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, newUserFileName);
			preparedStatement.setString(2, newServerFileName);
			preparedStatement.setInt(3, diaryImage_id);
			preparedStatement.executeUpdate();
		}catch(Exception e) {
			System.out.println("Exception[updateDiaryImage]" + e.getMessage());
		}finally {
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {}
			}
			
			if(connection != null) {
				try {
					connection.close();
				}catch(SQLException e) {}
			}
		}
		
	}
	
	public void deleteDiaryImage(int diaryImage_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "DELETE FROM diaryImages WHERE id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, diaryImage_id);
			preparedStatement.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("Exception[deleteDiaryImage]" + e.getMessage());
		}finally {
			
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {}
			}
			
			if(connection != null) {
				try {
					connection.close();
				}catch(SQLException e) {}
			}
		}
	}
}
