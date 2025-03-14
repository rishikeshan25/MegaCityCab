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

@WebServlet("/UpdateDriverServlet")
public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldDriverName = request.getParameter("oldDriverName");
        String newDriverName = request.getParameter("newDriverName");

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE bookings SET driver_name=? WHERE driver_name=?")) {
            
            stmt.setString(1, newDriverName);
            stmt.setString(2, oldDriverName);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("adminDashboard.jsp?message=Driver updated successfully");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=No changes made");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Driver update failed");
        }
    }
}
