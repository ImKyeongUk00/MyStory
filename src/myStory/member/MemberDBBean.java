package myStory.member;

import java.sql.*;

public class MemberDBBean {
	private static MemberDBBean instance = new MemberDBBean();
	
	private MemberDBBean() {
		
	}
	
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		String jdbcUrl="jdbc:mysql://localhost:3306/mystory";
		String dbId="root";
		String dbPassword="wjdqhqhdks";
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(jdbcUrl, dbId, dbPassword);
	}
	
	public int insertMember(Member member) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			//아이디 중복 확인 절차 
			String sql = "SELECT email FROM member WHERE email=?";
			
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, member.getEmail());
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) { //중복된 아이디가 있다면
				return -1;
			}
			
			if(!(preparedStatement.isClosed())) {
				preparedStatement.close();
			}
			//이 이후에 실행 될 코드는 중복된 아이디가 없기 때문에  member db에 저장하는 코드
			sql = "INSERT INTO member (email, password, nickname) value (?, ?, ?)";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, member.getEmail());
			preparedStatement.setString(2, member.getPassword());
			preparedStatement.setString(3, member.getNickname());
			preparedStatement.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("exception[insertMember]: " + e.getMessage());
		}finally {
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
		
		return 0;
	}
	
	public int getLoginUserID(Member member) { //존재하는 회원이라면 그 회원의 ID를 반환하고 존재하지 않는 회원이라면 -1 반환
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			connection = getConnection();
			String sql = "SELECT id FROM member WHERE email=? AND password=?";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, member.getEmail());
			preparedStatement.setString(2, member.getPassword());
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				return resultSet.getInt("id");
			}
			
		}catch(Exception e){
			System.out.println("exception[login]: " + e.getMessage());
		}finally {
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
		
		return -1;
	}
	
	public Member getMember(int member_id) { //Member객체를 얻는 메소드
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Member member = null;
		
		try {
			connection = getConnection();
			String sql = "SELECT * FROM member WHERE id=?";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, member_id);
			
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				member = new Member();
				member.setId(resultSet.getInt("id"));
				member.setEmail(resultSet.getString("email"));
				member.setNickname(resultSet.getString("nickname"));
				member.setPassword(resultSet.getString("password"));
			}
		}catch(Exception e){
			System.out.println("exception[getMember]: " + e.getMessage());
		}finally {
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
		
		return member;
	}

	public void changeMemberNickname(int member_id, String changedNickname) { //닉네임 변경
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = getConnection();
			String sql = "UPDATE member SET nickname=? WHERE id=?";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, changedNickname);
			preparedStatement.setInt(2, member_id);
			preparedStatement.executeUpdate();
		}catch(Exception e){
			System.out.println("exception[changeMemberNickname]: " + e.getMessage());
		}finally {
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
	
	public boolean passwordAuthentication(int member_id, String password) { //비밀번호 인증
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			connection = getConnection();
			String sql = "SELECT id FROM member WHERE id=? AND password=?";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, member_id);
			preparedStatement.setString(2, password);
			
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) { //일치하는 멤버가 있으면 true 반환
				return true;
			}
		}catch(Exception e){
			System.out.println("exception[passwordAuthentication]: " + e.getMessage());
		}finally {
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
		
		return false;
	}
	
	public void passwordChange(int member_id, String newPassword) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = getConnection();
			String sql = "UPDATE member SET password=? WHERE id=?";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, newPassword);
			preparedStatement.setInt(2, member_id);
			preparedStatement.executeUpdate();
		}catch(Exception e){
			System.out.println("exception[passwordChange]: " + e.getMessage());
		}finally {
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
	
	public void deleteMember(int member_id) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			String sql = "DELETE FROM member WHERE id = ?";
			
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, member_id);
			preparedStatement.executeUpdate();
		}catch(Exception e) {
			System.out.println("exception[deleteMember]: " + e.getMessage());
		}finally {
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
