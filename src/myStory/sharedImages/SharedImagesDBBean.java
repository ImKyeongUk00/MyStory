package myStory.sharedImages;

import java.sql.*;

public class SharedImagesDBBean {
	private static SharedImagesDBBean instance = new SharedImagesDBBean();
	
	private SharedImagesDBBean() {
		
	}
	
	public static SharedImagesDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		String jdbcUrl="jdbc:mysql://localhost:3306/mystory";
		String dbId="root";
		String dbPassword="wjdqhqhdks";
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(jdbcUrl, dbId, dbPassword);
	}
	
	public void insertImage(int post_id, String userFileName, String serverFileName) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = getConnection();
			String sql = "INSERT INTO sharedImages (imageShare_id, serverFileName, userFileName) VALUES (?, ?, ?)";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, post_id);
			preparedStatement.setString(2, serverFileName);
			preparedStatement.setString(3, userFileName);
			preparedStatement.executeUpdate();
			
		}catch(Exception e){
			System.out.println("Exception[imageShare]: " + e.getMessage());
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
	
	public SharedImages getSharedImage(int post_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		SharedImages sharedImage = null;
		
		try {
			String sql = "SELECT * FROM sharedImages where imageshare_id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, post_id);
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				sharedImage = new SharedImages();
				sharedImage.setId(resultSet.getInt("id"));
				sharedImage.setImageShare_id(resultSet.getInt("imageShare_id"));
				sharedImage.setServerFileName(resultSet.getString("serverFileName"));
				sharedImage.setUserFileName(resultSet.getString("userFileName"));
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
		
		return sharedImage;
	}
	
	public void deleteSharedImage(int sharedImage_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "DELETE FROM sharedImages WHERE id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, sharedImage_id);
			preparedStatement.executeUpdate();
		}catch(Exception e) {
			System.out.println("Exception[deleteSharedImage]" + e.getMessage());
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
