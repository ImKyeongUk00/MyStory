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
			//���̵� �ߺ� Ȯ�� ���� 
			String sql = "SELECT email FROM member WHERE email=?";
			
			connection = getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, member.getEmail());
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) { //�ߺ��� ���̵� �ִٸ�
				return -1;
			}
			
			if(!(preparedStatement.isClosed())) {
				preparedStatement.close();
			}
			//�� ���Ŀ� ���� �� �ڵ�� �ߺ��� ���̵� ���� ������  member db�� �����ϴ� �ڵ�
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
	
	public int getLoginUserID(Member member) { //�����ϴ� ȸ���̶�� �� ȸ���� ID�� ��ȯ�ϰ� �������� �ʴ� ȸ���̶�� -1 ��ȯ
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
	
	public Member getMember(int member_id) { //Member��ü�� ��� �޼ҵ�
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

	public void changeMemberNickname(int member_id, String changedNickname) { //�г��� ����
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
	
	public boolean passwordAuthentication(int member_id, String password) { //��й�ȣ ����
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
			
			if(resultSet.next()) { //��ġ�ϴ� ����� ������ true ��ȯ
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
