import java.sql.*;
public class Query {
	public static void main(String args[]) throws SQLException 
	{
		Connection conn = getConnection();
		String[] queryStatements = getQueryStatements();
		try (var statement = conn.createStatement())
		{
			// 1) The student number and ssn of the student whose name is "Becky"
            ResultSet rs1 = statement.executeQuery(queryStatements[0]);
            System.out.println("1) Student number and ssn of the student named 'Becky':");
            while (rs1.next()) 
            {
                int snum = rs1.getInt("snum");
                int ssn = rs1.getInt("ssn");
                System.out.println("Student Number: " + snum + ", SSN: " + ssn);
            }
            
            // 2) The major name and major level of the student whose ssn is 123097834
            ResultSet rs2 = statement.executeQuery(queryStatements[1]);
            System.out.println("\n2) Major name and level of the student with SSN 123097834:");
            while (rs2.next()) 
            {
                String majorName = rs2.getString("name");
                String majorLevel = rs2.getString("level");
                System.out.println("Major Name: " + majorName + ", Major Level: " + majorLevel);
            }

            // 3) The names of all courses offered by the department of Computer Science
            ResultSet rs3 = statement.executeQuery(queryStatements[2]);
            System.out.println("\n3) Names of all courses offered by the Computer Science department:");
            while (rs3.next()) 
            {
                String courseName = rs3.getString("name");
                System.out.println("Course Name: " + courseName);
            }

            // 4) All degree names and levels offered by the department Computer Science
            ResultSet rs4 = statement.executeQuery(queryStatements[3]);
            System.out.println("\n4) Degree names and levels offered by the Computer Science department:");
            while (rs4.next()) 
            {
                String degreeName = rs4.getString("name");
                String degreeLevel = rs4.getString("level");
                System.out.println("Degree Name: " + degreeName + ", Degree Level: " + degreeLevel);
            }

            // 5) The names of all students who have a minor
            ResultSet rs5 = statement.executeQuery(queryStatements[4]);
            System.out.println("\n5) Names of all students who have a minor:");
            while (rs5.next()) 
            {
                String studentName = rs5.getString("name");
                System.out.println("Student Name: " + studentName);
            }
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
	public static String[] getQueryStatements() 
	{
		String q1 = "select snum, ssn from students where name = 'Becky'";
		String q2 = "select major.name, major.level from major, students " + "where major.snum = students.snum and students.ssn = 123097834";
		String q3 = "select distinct courses.name from courses, departments " + "where courses.department_code = departments.code and departments.name = 'Computer Science'";
		String q4 = "select distinct degrees.name, degrees.level from degrees, departments " + "where degrees.department_code = departments.code and departments.name = 'Computer Science'";
		String q5 = "select distinct students.name from students, minor " + "where students.snum = minor.snum";
		String statement[] = new String[] {q1, q2, q3, q4, q5};
		return statement;
	}
}
