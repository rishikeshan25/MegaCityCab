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

@WebServlet("/UpdateVehicleServlet")
public class UpdateVehicleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        String status = request.getParameter("status");

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE vehicles SET status=? WHERE vehicle_id=?")) {
            stmt.setString(1, status);
            stmt.setInt(2, vehicleId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
