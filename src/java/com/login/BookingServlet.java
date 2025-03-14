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
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String vehicle = request.getParameter("selectedVehicle");
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String datetime = request.getParameter("datetime");

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO bookings (user_id, vehicle_type, pickup_location, drop_location, ride_datetime, status) VALUES (?, ?, ?, ?, ?, 'Pending')")) {
            stmt.setInt(1, userId);
            stmt.setString(2, vehicle);
            stmt.setString(3, pickup);
            stmt.setString(4, drop);
            stmt.setString(5, datetime);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("wait.jsp");
    }
}
