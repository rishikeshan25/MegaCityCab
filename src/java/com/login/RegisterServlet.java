
package com.login;



import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user input from the form
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check for empty fields
        if (name.isEmpty() || address.isEmpty() || nic.isEmpty() || phone.isEmpty() || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=emptyFields");
            return;
        }

        try (Connection conn = DatabaseUtility.getConnection()) {
            // SQL Query to insert user details
            String sql = "INSERT INTO users (name, address, nic, phone, username, password) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set values
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, nic);
            stmt.setString(4, phone);
            stmt.setString(5, username);
            stmt.setString(6, hashPassword(password)); // Hash the password

            // Execute insert query
            int rowsInserted = stmt.executeUpdate();
            stmt.close();

            if (rowsInserted > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("registerSuccess", "Registration successful! You can now log in.");
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=dbError");
        }
    }

    // Hash password using SHA-256 for security
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
