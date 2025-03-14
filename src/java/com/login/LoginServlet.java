/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.login;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user input from login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check for empty fields
        if (username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=emptyFields");
            return;
        }

        try (Connection conn = DatabaseUtility.getConnection()) {
            // SQL query to find user by username
            String sql = "SELECT id, name, password FROM users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                // Verify password
                if (storedHashedPassword.equals(hashPassword(password))) {
                    // Create session
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", username);
                    session.setAttribute("name", rs.getString("name"));

                    // Store success message in session
                    session.setAttribute("loginSuccess", "Welcome, " + rs.getString("name") + "! You have successfully logged in.");
                    
                    // Redirect to dashboard
                    response.sendRedirect("dashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=invalidCredentials");
                }
            } else {
                response.sendRedirect("login.jsp?error=userNotFound");
            }

            rs.close();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=dbError");
        }
    }

    // Hash password using SHA-256 for secure authentication
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
