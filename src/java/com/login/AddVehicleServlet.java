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

@WebServlet("/AddVehicleServlet")
public class AddVehicleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleType = request.getParameter("vehicle_type");
        String vehicleName = request.getParameter("vehicle_name");

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO vehicles (vehicle_type, vehicle_name) VALUES (?, ?)")) {
            stmt.setString(1, vehicleType);
            stmt.setString(2, vehicleName);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
