package myStory.imageShare;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

public class ImageShareDBBean {
	private static ImageShareDBBean instance = new ImageShareDBBean();
	 
	private ImageShareDBBean() {
		
	}
	
	public static ImageShareDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		String jdbcUrl="jdbc:mysql://localhost:3306/mystory";
		String dbId="root";
		String dbPassword="wjdqhqhdks";
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(jdbcUrl, dbId, dbPassword);
	}
	
	public int createImageSharePost(ImageShare post) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int post_id = 0;
		
		try {
			connection = getConnection();
			String sql = "INSERT INTO imageShare (member_id, title, description, created) VALUES (?, ?, ?, NOW())";
			preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, post.getMember_id());
			preparedStatement.setString(2, post.getTitle());
			preparedStatement.setString(3, post.getDescription());
			preparedStatement.executeUpdate();
			resultSet = preparedStatement.getGeneratedKeys();
			if(resultSet.next()) {
				post_id = resultSet.getInt(1);
			}
		}catch(Exception e){
			System.out.println("Exception[createImageSharePost]: " + e.getMessage());
		}finally {
			if(resultSet != null) {
				try {
					resultSet.close();
				}catch(SQLException e) {}
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
		return post_id;
	}
	
	public ImageShare getPost(int post_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		ImageShare post = null;
		
		try {
			connection = getConnection();
			String sql = "SELECT * FROM imageShare WHERE id = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, post_id);
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				post = new ImageShare();
				post.setId(resultSet.getInt("id"));
				post.setMember_id(resultSet.getInt("member_id"));
				post.setTitle(resultSet.getString("title"));
				post.setDescription(resultSet.getString("description"));
				post.setCreated(resultSet.getString("created"));
			}
		}catch(Exception e){
			System.out.println("Exception[getPost]: " + e.getMessage());
		}finally {
			if(resultSet != null) {
				try {
					resultSet.close();
				}catch(SQLException e) {}
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
		return post;
	}
	
	public ImageShare[] getPosts() {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		ImageShare[] posts = new ImageShare[100];
		Arrays.fill(posts, null); 
		
		try {
			connection = getConnection();
			String sql = "SELECT * FROM imageShare";
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			int i = 0;
			
			while(resultSet.next()) {
				ImageShare post = new ImageShare();
				post.setId(resultSet.getInt("id"));
				post.setMember_id(resultSet.getInt("member_id"));
				post.setTitle(resultSet.getString("title"));
				post.setDescription(resultSet.getString("description"));
				post.setCreated(resultSet.getString("created"));
				
				posts[i] = post;
				i++;
			}
		}catch(Exception e){
			System.out.println("Exception[getPosts]: " + e.getMessage());
		}finally {
			if(resultSet != null) {
				try {
					resultSet.close();
				}catch(SQLException e) {}
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
		return posts;
	}
	
	public int getImageSharePostsCount(ImageShare[] posts) {
		int count = 0;
		int i=0;
		
		while(true) {
			if(posts[i++] == null) {
				break;
			}
			count++;
		}
		
		return count;
	}
	
	public void deleteImageSharePost(int post_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = getConnection();
			String sql = "DELETE FROM imageShare WHERE id = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, post_id);
			preparedStatement.executeUpdate();			
		}catch(Exception e) {
			System.out.println("Exception[deleteImageSharePost]: " + e.getMessage());
		}finally {
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {
					
				}
			}
			
			if(connection != null) {
				try {
					connection.close();
				}catch(SQLException e) {
					
				}
			}
		}
	}
	
	public ImageShare[] getSearchImageSharePost(String searchedString) {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    ImageShare[] posts = new ImageShare[100];
	    Arrays.fill(posts, null);
	    
	    String sqlSearchedString = "%" + searchedString + "%";
	    
	    try {
	       String sql = "select * from imageShare where title LIKE ?";
	        
	       connection = getConnection();
	       preparedStatement = connection.prepareStatement(sql);
	       preparedStatement.setString(1, sqlSearchedString);
	       resultSet = preparedStatement.executeQuery();
	       int i=0;
	       while(resultSet.next()) {
	    	   ImageShare post = new ImageShare();
	    	   post.setId(resultSet.getInt("id"));
	    	   post.setMember_id(resultSet.getInt("member_id"));
	    	   post.setTitle(resultSet.getString("title"));
	    	   post.setDescription(resultSet.getString("description"));
	    	   post.setCreated(resultSet.getString("created"));
	    	   posts[i] = post;
	           i++;
	        }
	     } catch (Exception e){
	        System.out.println("exception[getSearchImageSharePost] : "+e.getMessage());
	     } finally {
	        if(resultSet != null) {
	           try {
	              resultSet.close();
	           } catch (SQLException e) {
	              System.out.println("SQLException[resultSet]: " + e.getMessage());
	           }
	         }
	         
	        if(preparedStatement != null) {
	           try {
	              preparedStatement.close();
	           } catch (SQLException e) {
	              System.out.println("SQLException[preparedStatement]: " + e.getMessage());
	           }
	        }
	         
         if(connection != null) {
	           try {
	              connection.close();
	           } catch (SQLException e) {
	              System.out.println("SQLException[connection]: " + e.getMessage());
	           }
	        }
	
	     }
	     return posts;
	}
}
