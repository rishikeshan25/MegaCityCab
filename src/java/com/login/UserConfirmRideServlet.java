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

@WebServlet("/UserConfirmRideServlet")
public class UserConfirmRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String action = request.getParameter("action");

        String newStatus = "WAITING FOR USER CONFIRMATION"; // Default status
        if ("CONFIRMED".equals(action)) {
            newStatus = "CONFIRMED";
        } else if ("CANCELLED".equals(action)) {
            newStatus = "CANCELLED";
        }

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE bookings SET status=? WHERE booking_id=?")) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("wait.jsp"); // Refresh the wait page
    }
}
