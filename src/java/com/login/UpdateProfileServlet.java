package com.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");

        if (name == null || address == null || nic == null || phone == null) {
            response.sendRedirect("dashboard.jsp?error=invalidInput");
            return;
        }

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "UPDATE users SET name=?, address=?, nic=?, phone=?, updated_at=CURRENT_TIMESTAMP WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, nic);
            stmt.setString(4, phone);
            stmt.setInt(5, userId);

            int rowsUpdated = stmt.executeUpdate();
            stmt.close();

            if (rowsUpdated > 0) {
                session.setAttribute("name", name);
                response.sendRedirect("dashboard.jsp?msg=profileUpdated");
            } else {
                response.sendRedirect("dashboard.jsp?error=updateFailed");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Debugging: Print the full error
            response.sendRedirect("dashboard.jsp?error=dbError");
        }
    }
}
