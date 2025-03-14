<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<%@ include file="header.jsp" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    String vehicle = "", pickup = "", drop = "", datetime = "", driver = "", fare = "0.00", status = "";

    try (Connection conn = com.example.util.DatabaseUtility.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE booking_id=?")) {

        stmt.setInt(1, bookingId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            vehicle = rs.getString("vehicle_type");
            pickup = rs.getString("pickup_location");
            drop = rs.getString("drop_location");
            datetime = rs.getString("ride_datetime");
            driver = rs.getString("driver_name");
            fare = rs.getString("fare");
            status = rs.getString("status");
        }
        rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ride Bill</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; text-align: center; }
        .bill-container { width: 50%; margin: auto; padding: 20px; background: white; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.3); }
        h2 { color: #333; }
        .bill-details { text-align: left; margin-top: 20px; }
        .bill-details p { font-size: 18px; margin: 5px 0; }
        .btn { padding: 10px 20px; border: none; background: #5bc0be; color: white; font-weight: bold; border-radius: 5px; cursor: pointer; margin: 10px; }
        .btn:hover { background: #3a506b; }
    </style>
</head>
<body>
    <div class="bill-container">
        <h2>🚖 Ride Bill</h2>
        <div class="bill-details">
            <p><b>Booking ID:</b> <%= bookingId %></p>
            <p><b>Vehicle:</b> <%= vehicle %></p>
            <p><b>Pickup:</b> <%= pickup %></p>
            <p><b>Drop:</b> <%= drop %></p>
            <p><b>Date/Time:</b> <%= datetime %></p>
            <p><b>Driver:</b> <%= driver %></p>
            <p><b>Fare:</b> LKR <%= fare %></p>
            <p><b>Status:</b> <span style="color:green;"><%= status %></span></p>
        </div>

        <!-- Print & Download Buttons -->
        <button class="btn" onclick="window.print()">🖨 Print Bill</button>
        <a href="DownloadBillServlet?bookingId=<%= bookingId %>" class="btn">📥 Download PDF</a>
    </div>
</body>
</html>
