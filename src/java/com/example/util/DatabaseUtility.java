package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtility {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab"; 
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "rishi25"; 

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure the driver is loaded
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found", e);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Database connection failed!", e);
        }
        return conn;  // Ensure it returns the connection
    }
}
