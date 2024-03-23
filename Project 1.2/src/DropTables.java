import java.sql.*;

public class DropTables {
	public static void main(String args[]) throws SQLException 
	{
		Connection conn = getConnection();
		String[] dropTables = dropAllTables();
		
		try (var statement = conn.createStatement())
		{
			conn.setAutoCommit(false);
			for (String stmt: dropTables) 
			{
				statement.addBatch(stmt);
			}
			statement.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			System.out.println("Dropped Tables");
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

    public static String[] dropAllTables()
    {
            String drop1 = "DROP TABLE IF EXISTS major";
            String drop2 = "DROP TABLE IF EXISTS minor";
            String drop3 = "DROP TABLE IF EXISTS register";
            String drop4 = "DROP TABLE IF EXISTS courses";
            String drop5 = "DROP TABLE IF EXISTS degrees";
            String drop6 = "DROP TABLE IF EXISTS departments";
            String drop7 = "DROP TABLE IF EXISTS students";
            return new String[]{drop1, drop2, drop3, drop4, drop5, drop6, drop7};
    }
}
