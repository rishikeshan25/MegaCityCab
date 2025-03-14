/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.login;

import com.example.util.DatabaseUtility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverName = request.getParameter("driverName");

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE bookings SET driver_name=NULL WHERE driver_name=?")) {

            stmt.setString(1, driverName);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("adminDashboard.jsp?message=Driver deleted successfully");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=No driver found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Driver deletion failed");
        }
    }
}
