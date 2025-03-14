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

@WebServlet("/AdminBookingServlet")
public class AdminBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String action = request.getParameter("action");

        try (Connection conn = DatabaseUtility.getConnection()) {
            if ("Accept".equals(action)) {
                String driverName = request.getParameter("driverName");
                double fare = Double.parseDouble(request.getParameter("fare"));

                PreparedStatement stmt = conn.prepareStatement(
                    "UPDATE bookings SET status='WAITING FOR USER CONFIRMATION', driver_name=?, fare=? WHERE booking_id=?");
                stmt.setString(1, driverName);
                stmt.setDouble(2, fare);
                stmt.setInt(3, bookingId);
                stmt.executeUpdate();
            } else if ("Cancel".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement(
                    "UPDATE bookings SET status='CANCELLED' WHERE booking_id=?");
                stmt.setInt(1, bookingId);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
