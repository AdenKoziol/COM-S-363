import java.sql.*;
public class CreateTables {
	public static void main(String args[]) throws SQLException 
	{
		Connection conn = getConnection();
		String[] createStatements = getCreateStatements();
		
		try (var statement = conn.createStatement())
		{
			conn.setAutoCommit(false);
			for (String stmt: createStatements) 
			{
				statement.addBatch(stmt);
			}
			statement.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			System.out.println("Created tables");
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
	public static String[] getCreateStatements() 
	{
		String students = "CREATE TABLE STUDENTS " +
		"(snum INTEGER DEFAULT NULL UNIQUE, " +
		" ssn INTEGER NOT NULL, " +
		" name VARCHAR(10) DEFAULT NULL, " +
		" gender VARCHAR(1) DEFAULT NULL, " +
		" dob DATETIME DEFAULT NULL," +
		" c_addr VARCHAR(20) DEFAULT NULL, " +
		" c_phone VARCHAR(10) DEFAULT NULL, " +
		" p_addr VARCHAR(20) DEFAULT NULL, " +
		" p_phone VARCHAR(10) DEFAULT NULL, " +
		" PRIMARY KEY ( ssn ))" ;
		String departments = "CREATE TABLE DEPARTMENTS " +
		"(code INTEGER NOT NULL, " +
		" name VARCHAR(50) DEFAULT NULL UNIQUE, " +
		" phone VARCHAR(10) DEFAULT NULL, " +
		" college VARCHAR(20) DEFAULT NULL, " +
		" PRIMARY KEY ( code ))" ;
		String degrees = "CREATE TABLE degrees (" +
        "name VARCHAR(50), " +
        "level VARCHAR(5), " +
        "department_code INTEGER, " +
        "PRIMARY KEY (name, level), " +
        "FOREIGN KEY (department_code) REFERENCES departments(code)" +
        ")";
		String courses = "CREATE TABLE courses (" +
        "number INTEGER PRIMARY KEY, " +
        "name VARCHAR(50), " +
        "description VARCHAR(50), " +
        "credithours INTEGER, " +
        "level VARCHAR(20), " +
        "department_code INTEGER, " +
        "FOREIGN KEY (department_code) REFERENCES departments(code)" +
        ")";
		String register = "CREATE TABLE register (" +
        "snum INTEGER, " +
        "course_number INTEGER, " +
        "regtime VARCHAR(20), " +
        "grade INTEGER, " +
        "PRIMARY KEY (snum, course_number), " +
        "FOREIGN KEY (snum) REFERENCES students(snum), " +
        "FOREIGN KEY (course_number) REFERENCES courses(number)" +
        ")";
		String major = "CREATE TABLE major (" +
        "snum INTEGER, " +
        "name VARCHAR(50), " +
        "level VARCHAR(10), " +
        "PRIMARY KEY (snum, name, level), " +
        "FOREIGN KEY (snum) REFERENCES students(snum), " +
        "FOREIGN KEY (name, level) REFERENCES degrees(name, level)" +
        ")";
		String minor = "CREATE TABLE minor (" +
        "snum INTEGER, " +
        "name VARCHAR(50), " +
        "level VARCHAR(10), " +
        "PRIMARY KEY (snum, name, level), " +
        "FOREIGN KEY (snum) REFERENCES students(snum), " +
        "FOREIGN KEY (name, level) REFERENCES degrees(name, level)" +
        ")";
		
		String statement[] = new String[] {students, departments, degrees, courses, register, major, minor};
		return statement;
	}
}