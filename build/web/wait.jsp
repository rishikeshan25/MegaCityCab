<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<%@ include file="header.jsp" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }

    int userId = (int) sess.getAttribute("userId");
    int bookingId = -1;
    String vehicle = "", pickup = "", drop = "", datetime = "", status = "PENDING";
    String driver = "Not Assigned";
    String fare = "0.00";

    try (Connection conn = com.example.util.DatabaseUtility.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
             "SELECT booking_id, vehicle_type, pickup_location, drop_location, ride_datetime, status, driver_name, fare " +
             "FROM bookings WHERE user_id=? ORDER BY booking_id DESC LIMIT 1")) {

        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            bookingId = rs.getInt("booking_id");
            vehicle = rs.getString("vehicle_type");
            pickup = rs.getString("pickup_location");
            drop = rs.getString("drop_location");
            datetime = rs.getString("ride_datetime");
            status = rs.getString("status").toUpperCase(); // Convert to uppercase for consistency
            driver = rs.getString("driver_name") != null ? rs.getString("driver_name") : "Not Assigned";
            fare = rs.getString("fare") != null ? rs.getString("fare") : "0.00";
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ride Request Status</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #0b132b; color: white; text-align: center; }
        .container { max-width: 600px; margin: auto; padding: 20px; background: #1c2541; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
        h2 { color: #5bc0be; }
        .info { margin-bottom: 15px; }
        .status { font-size: 18px; font-weight: bold; color: #ffcc00; }
        .btn { padding: 10px 20px; border: none; background: #5bc0be; color: white; font-weight: bold; border-radius: 5px; cursor: pointer; margin: 10px; }
        .btn:hover { background: #3a506b; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🚖 Ride Request Status</h2>
        <p class="info"><b>Vehicle:</b> <%= vehicle %></p>
        <p class="info"><b>Pickup:</b> <%= pickup %></p>
        <p class="info"><b>Drop:</b> <%= drop %></p>
        <p class="info"><b>Date/Time:</b> <%= datetime %></p>
        <p class="info status"><b>Status:</b> <%= status %></p>

        <% if ("WAITING FOR USER CONFIRMATION".equals(status)) { %>
            <p class="info"><b>Driver:</b> <%= driver %></p>
            <p class="info"><b>Fare:</b> LKR <%= fare %></p>
            <form action="UserConfirmRideServlet" method="post">
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <button type="submit" name="action" value="CONFIRMED" class="btn" style="background:green;">✅ Confirm Ride</button>
                <button type="submit" name="action" value="CANCELLED" class="btn" style="background:red;">❌ Cancel Ride</button>
            </form>

        <% } else if ("PENDING".equals(status)) { %>
            <p style="color:orange;">Waiting for admin approval...</p>

        <% } else if ("CONFIRMED".equals(status)) { %>
            <p style="color:blue;">Your ride has been confirmed. Waiting for the driver...</p>

        <% } else if ("ON THE WAY".equals(status)) { %>
            <p style="color:blue;">Your ride is on the way! 🚗</p>

        <% } else if ("AT DOORSTEP".equals(status)) { %>
            <p style="color:green;">Your ride is at your doorstep. Please get in! 🏡</p>

        <% } else if ("FINISHED".equals(status)) { %>
            <p style="color:green;">✅ Your ride has been completed. Thank you!</p>
            
            <!-- Download Bill Button -->
            <form action="DownloadBillServlet" method="post">
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <button type="submit" class="btn">📄 Download Bill</button>
            </form>

        <% } else if ("CANCELLED".equals(status)) { %>
            <p style="color:red;">❌ Ride was cancelled.</p>
        <% } else { %>
            <p>🚖 Ride in progress...</p>
        <% } %>
    </div>
</body>
</html>
