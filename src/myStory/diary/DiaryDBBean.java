package myStory.diary;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;


public class DiaryDBBean {
	private static DiaryDBBean instance = new DiaryDBBean();
	
	private DiaryDBBean() {
		
	}
	
	public static DiaryDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		String jdbcUrl="jdbc:mysql://localhost:3306/mystory";
		String dbId="root";
		String dbPassword="wjdqhqhdks";
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(jdbcUrl, dbId, dbPassword);
	}
	
	public int createDiary(Diary diary) { //일기를 데이터를 db에 저장하고 일기의 id값을 반환
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int diary_id = 0;
		
		try {
			
			String sql = "insert into diary (member_id, title, description, weather, date) value (?, ?, ?, ?, ?)";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, diary.getMember_id());
			preparedStatement.setString(2, diary.getTitle());
			preparedStatement.setString(3, diary.getDescription());
			preparedStatement.setString(4, diary.getWeather());
			preparedStatement.setString(5, diary.getDate());
			preparedStatement.executeUpdate();
			resultSet = preparedStatement.getGeneratedKeys();
			if(resultSet.next()) {
				diary_id = resultSet.getInt(1);
			}
		} catch (Exception e){
			System.out.println("exception[createDiary]: " + e.getMessage());
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
		
		return diary_id;
	}
	
	public void updateDiary(Diary diary) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "UPDATE diary SET title=?, description=?, weather=?, date=? WHERE id = ?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, diary.getTitle());
			preparedStatement.setString(2, diary.getDescription());
			preparedStatement.setString(3, diary.getWeather());
			preparedStatement.setString(4, diary.getDate());
			preparedStatement.setInt(5, diary.getId());
			preparedStatement.executeUpdate();
			
		} catch (Exception e){
			System.out.println("exception[updateDiary]: " + e.getMessage());
		} finally {
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
	}
	
	public Diary[] getDiarys(int member_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		Diary[] diarys = new Diary[100];
		Arrays.fill(diarys, null);
		try {
			String sql = "select * from diary where member_id=? ORDER BY date DESC"; 
			int i=0;
			
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, member_id);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				Diary diary = new Diary();
				diary.setId(resultSet.getInt("id"));
				diary.setTitle(resultSet.getString("title"));
				diary.setDescription(resultSet.getString("description"));
				diary.setWeather(resultSet.getString("weather"));
				diary.setDate(resultSet.getString("date"));
				diary.setMember_id(resultSet.getInt("member_id"));
				diarys[i] = diary;
				i++;
			}
			
		} catch (Exception e){
			System.out.println("exception[getDiarys]: " + e.getMessage());
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
		return diarys;
	}
	
	public Diary getDiary(int diary_id) { 
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Diary diary = null;
		try {
			String sql = "select * from diary where id=?"; 
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, diary_id);
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				diary = new Diary();
				diary.setId(resultSet.getInt("id"));
				diary.setMember_id(resultSet.getInt("member_id"));
				diary.setTitle(resultSet.getString("title"));
				diary.setDescription(resultSet.getString("description"));
				diary.setWeather(resultSet.getString("weather"));
				diary.setDate(resultSet.getString("date"));
			}
			
			
		} catch (Exception e){
			System.out.println("exception[getDiary]: " + e.getMessage());
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
		return diary;
	}
	
	public int getDiaryCount(Diary[] diarys) {
		int i = 0;
		int diaryCount = 0;
		
		while(true) {
			if(diarys[i++] == null) {
				break;
			}
			diaryCount++;
		}
		
		return diaryCount;
	}
	
	public Diary[] getSearchDiary(int member_id, String searchedString) {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    Diary[] diarys = new Diary[100];
	    Arrays.fill(diarys, null);
	    
	    String sqlSearchedString = "%" + searchedString + "%";
	    
	    try {
	       String sql = "select * from diary where member_id=? AND title LIKE ?";
	        
	       connection = getConnection();
	       preparedStatement = connection.prepareStatement(sql);
	       preparedStatement.setInt(1, member_id);
	       preparedStatement.setString(2, sqlSearchedString);
	       resultSet = preparedStatement.executeQuery();
	       int i=0;
	       while(resultSet.next()) {
	    	   Diary diary = new Diary();
	           diary.setId(resultSet.getInt("id"));
	           diary.setTitle(resultSet.getString("title"));
	           diary.setDescription(resultSet.getString("description"));
	           diary.setWeather(resultSet.getString("weather"));
	           diary.setDate(resultSet.getString("date"));
	           diary.setMember_id(resultSet.getInt("member_id"));
	           diarys[i] = diary;
	           i++;
	        }
	     } catch (Exception e){
	        System.out.println("exception[getSearchDiary] : "+e.getMessage());
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
	     return diarys;
	}
	
	public void deleteDiary(int diary_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			
			String sql = "DELETE FROM diary WHERE id=?";
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, diary_id);
			preparedStatement.executeUpdate();
		} catch (Exception e){
			System.out.println("exception[deleteDiary]: " + e.getMessage());
		} finally {
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
	}
}


