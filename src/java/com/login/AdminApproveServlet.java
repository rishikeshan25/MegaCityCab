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

@WebServlet("/AdminApproveServlet")
public class AdminApproveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String driverName = request.getParameter("driverName");
        double fare = Double.parseDouble(request.getParameter("fare"));

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE bookings SET status='Accepted', driver_name=?, fare=? WHERE booking_id=?")) {

            stmt.setString(1, driverName);
            stmt.setDouble(2, fare);
            stmt.setInt(3, bookingId);
            
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("✅ Booking ID " + bookingId + " updated with Driver: " + driverName + ", Fare: LKR " + fare);
            } else {
                System.out.println("❌ Failed to update booking ID: " + bookingId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
