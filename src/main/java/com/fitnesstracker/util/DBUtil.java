package com.fitnesstracker.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // These blocks check the cloud environment first. If empty, they use your local laptop settings.
    private static final String URL = System.getenv("DB_URL") != null 
            ? System.getenv("DB_URL") 
            : "jdbc:mysql://localhost:3306/fitness_db";
            
    private static final String USERNAME = System.getenv("DB_USER") != null 
            ? System.getenv("DB_USER") 
            : "root";
            
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null 
            ? System.getenv("DB_PASSWORD") 
            : "tiger";
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {

        System.out.println("DB_URL      = " + URL);
        System.out.println("DB_USER     = " + USERNAME);
        System.out.println("DB_PASSWORD = " + (PASSWORD == null ? "null" : "********"));

        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        System.out.println("Database Connected Successfully!");

        return conn;
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}



//package com.fitnesstracker.util;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBUtil {
//    private static final String URL = "jdbc:mysql://localhost:3306/fitness_db";
//    private static final String USERNAME = "root";
//    private static final String PASSWORD = "tiger";
//    
//    static {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//    }
//    
//    public static Connection getConnection() throws SQLException {
//        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
//    }
//    
//    public static void closeConnection(Connection conn) {
//        if (conn != null) {
//            try {
//                conn.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }
//}
