import java.sql.*;
public class ModifyRecords {
	public static void main(String args[]) throws SQLException 
	{
		Connection conn = getConnection();
		String[] modifyRecords = getModifiedRecords();
		
		try (var statement = conn.createStatement())
		{
			conn.setAutoCommit(false);
			for (String stmt: modifyRecords) 
			{
				statement.addBatch(stmt);
			}
			statement.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			System.out.println("Modified Records");
		}
	}

	public static Connection getConnection() throws SQLException
	{
		Connection conn = null;
		String userName = "coms363";
		String password = "password";
		String dbServer = "jdbc:mysql://localhost:3306/sys";
		conn = DriverManager.getConnection(dbServer,userName,password);
		System.out.println("Connected to the database");
		return conn;
	}
	
	public static String[] getModifiedRecords()
	{
		 String modify1 = "UPDATE students SET name = 'Scott' WHERE ssn = 746897816";
		 String modify2 = "UPDATE major SET name = 'Computer Science', level = 'Master' WHERE snum = 746897816";
		 String modify3 = "DELETE FROM register WHERE regtime = 'Spring2021'";
		 return new String[]{modify1, modify2, modify3};
	}
}