<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>


<%
    // Ensure admin is logged in
    HttpSession sess = request.getSession(false);
    Boolean isAdmin = (sess != null) ? (Boolean) sess.getAttribute("isAdmin") : null;
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("adminLogin.jsp?error=notAdmin");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        
        body {
    background-color: #0b132b; /* Dark Blue */
    color: #E0E0E0; /* Light Grey for better contrast */
    font-family: 'Poppins', sans-serif;
}

        /* Global Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

      
        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #1c2541;
            padding: 20px;
            position: fixed;
            top: 0; left: 0;
            bottom: 0;
        }
        .sidebar h2 {
            text-align: center;
            color: #5bc0be;
            margin-bottom: 30px;
            font-size: 22px;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 15px;
            margin-bottom: 10px;
            border-radius: 5px;
            background: #3a506b;
            text-decoration: none;
            color: white;
            font-weight: 500;
        }
        .sidebar a:hover {
            background: #5bc0be;
            color: black;
        }
        .logout {
            background: red !important;
            color: white !important;
            justify-content: center;
        }

        /* Container */
        .container {
            margin-left: 270px; /* Sidebar width + margin */
            padding: 20px;
            flex: 1;
        }

        /* Section Divs */
        .section {
            display: none;
            background: #1c2541;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            padding: 20px;
            margin-bottom: 30px;
        }
        .section.active {
            display: block;
        }

        h2 {
            color: #5bc0be;
            margin-bottom: 10px;
        }
        h3 {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: #3a506b;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid white;
            text-align: center;
            color: white;
        }
        th {
            background: #5bc0be;
            color: black;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            margin-top: 5px;
        }
        .btn-accept {
            background: #5bc0be;
            color: black;
        }
        .btn-cancel,
        .btn-delete {
            background: red;
            color: white;
        }
        .btn-update {
            background: #f5a623;
            color: black;
        }

        /* Additional Styles */
        label {
            display: inline-block;
            margin-right: 8px;
            margin-top: 10px;
        }
        input[type="text"], input[type="number"] {
            padding: 5px;
            border-radius: 5px;
            border: none;
            margin-right: 5px;
        }
        select {
            margin-right: 5px;
        }
    </style>

    <script>
        function showSection(sectionId) {
            // Hide all .section elements
            document.querySelectorAll('.section').forEach(sec => sec.classList.remove('active'));
            // Show the chosen section
            document.getElementById(sectionId).classList.add('active');
        }

        // Initialize
        window.onload = function() {
            // By default, show Manage Bookings
            document.getElementById('sectionBookings').classList.add('active');
        }
    </script>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2><i class="fas fa-user-shield"></i> Admin Panel</h2>
        <a href="#" onclick="showSection('sectionBookings')"><i class="fas fa-list"></i> Manage Bookings</a>
        <a href="#" onclick="showSection('sectionDrivers')"><i class="fas fa-user-friends"></i> Manage Drivers</a>
        <a href="#" onclick="showSection('sectionVehicles')"><i class="fas fa-car"></i> Manage Vehicles</a>
        <a href="#" onclick="showSection('sectionUsers')"><i class="fas fa-users"></i> Manage Users</a>
        <a href="AdminLogoutServlet" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="container">

        <!-- Manage Bookings -->
        <div id="sectionBookings" class="section">
            <h2><i class="fas fa-tasks"></i> Manage Bookings</h2>

            <!-- Pending Ride Requests -->
            <h3>🚕 Pending Ride Requests</h3>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE status='PENDING' ORDER BY booking_id DESC");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Booking ID</th><th>User ID</th><th>Vehicle</th><th>Pickup</th><th>Drop</th><th>Date/Time</th><th>Action</th></tr>");

                    while (rs.next()) {
                        int bid = rs.getInt("booking_id");
                        int uid = rs.getInt("user_id");
                        String vt = rs.getString("vehicle_type");
                        String pl = rs.getString("pickup_location");
                        String dl = rs.getString("drop_location");
                        String dt = rs.getString("ride_datetime");

                        out.println("<tr>");
                        out.println("<td>" + bid + "</td>");
                        out.println("<td>" + uid + "</td>");
                        out.println("<td>" + vt + "</td>");
                        out.println("<td>" + pl + "</td>");
                        out.println("<td>" + dl + "</td>");
                        out.println("<td>" + dt + "</td>");

                        // Accept & Cancel
                        out.println("<td>");
                        out.println("<form action='AdminBookingServlet' method='post' style='margin-bottom:5px;'>");
                        out.println("<input type='hidden' name='bookingId' value='" + bid + "' />");
                        out.println("<input type='hidden' name='action' value='Accept' />");
                        out.println("Driver: <input type='text' name='driverName' required /> ");
                        out.println("Fare: <input type='number' step='0.01' name='fare' required /> ");
                        out.println("<button type='submit' class='btn btn-accept'>Accept</button>");
                        out.println("</form>");

                        out.println("<form action='AdminBookingServlet' method='post'>");
                        out.println("<input type='hidden' name='bookingId' value='" + bid + "' />");
                        out.println("<input type='hidden' name='action' value='Cancel' />");
                        out.println("<button type='submit' class='btn btn-cancel'>Cancel</button>");
                        out.println("</form>");
                        out.println("</td>");

                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving pending bookings.</p>");
                }
            %>

            <!-- Waiting for User Confirmation -->
            <h3>🕐 Waiting for User Confirmation</h3>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE status='WAITING FOR USER CONFIRMATION' ORDER BY booking_id DESC");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Booking ID</th><th>User ID</th><th>Vehicle</th><th>Pickup</th><th>Drop</th><th>Driver</th><th>Fare</th><th>Status</th></tr>");

                    while (rs.next()) {
                        int bid = rs.getInt("booking_id");
                        int uid = rs.getInt("user_id");
                        String vt = rs.getString("vehicle_type");
                        String pl = rs.getString("pickup_location");
                        String dl = rs.getString("drop_location");
                        String driver = rs.getString("driver_name");
                        String fare = rs.getString("fare");

                        out.println("<tr>");
                        out.println("<td>" + bid + "</td>");
                        out.println("<td>" + uid + "</td>");
                        out.println("<td>" + vt + "</td>");
                        out.println("<td>" + pl + "</td>");
                        out.println("<td>" + dl + "</td>");
                        out.println("<td>" + driver + "</td>");
                        out.println("<td>LKR " + fare + "</td>");
                        out.println("<td style='color:orange;'>Waiting for User Confirmation</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving bookings waiting for user confirmation.</p>");
                }
            %>

            <!-- Active Rides -->
            <h3>🚖 Active Rides</h3>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE status IN ('CONFIRMED', 'ON THE WAY', 'AT DOORSTEP') ORDER BY booking_id DESC");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Booking ID</th><th>User ID</th><th>Driver</th><th>Fare</th><th>Status</th><th>Update Status</th></tr>");

                    while (rs.next()) {
                        int bid = rs.getInt("booking_id");
                        int uid = rs.getInt("user_id");
                        String driver = rs.getString("driver_name");
                        String fare = rs.getString("fare");
                        String status = rs.getString("status");

                        out.println("<tr>");
                        out.println("<td>" + bid + "</td>");
                        out.println("<td>" + uid + "</td>");
                        out.println("<td>" + driver + "</td>");
                        out.println("<td>LKR " + fare + "</td>");
                        out.println("<td>" + status + "</td>");

                        out.println("<td>");
                        out.println("<form action='UpdateRideStatusServlet' method='post'>");
                        out.println("<input type='hidden' name='bookingId' value='" + bid + "'>");
                        out.println("<select name='status'>");
                        out.println("<option value='On the Way'>🚗 On the Way</option>");
                        out.println("<option value='At Doorstep'>🏡 At Doorstep</option>");
                        out.println("<option value='Finished'>✅ Finished</option>");
                        out.println("</select>");
                        out.println("<button type='submit' class='btn btn-update'>Update</button>");
                        out.println("</form>");
                        out.println("</td>");

                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving active rides.</p>");
                }
            %>

            <!-- Finished Rides -->
            <h3>✅ Finished Rides</h3>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE status='FINISHED' ORDER BY booking_id DESC");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Booking ID</th><th>User ID</th><th>Vehicle</th><th>Pickup</th><th>Drop</th><th>Driver</th><th>Fare</th><th>Ride Date</th></tr>");

                    while (rs.next()) {
                        int bid = rs.getInt("booking_id");
                        int uid = rs.getInt("user_id");
                        String vt = rs.getString("vehicle_type");
                        String pl = rs.getString("pickup_location");
                        String dl = rs.getString("drop_location");
                        String driver = rs.getString("driver_name");
                        String fare = rs.getString("fare");
                        String datetime = rs.getString("ride_datetime");

                        out.println("<tr>");
                        out.println("<td>" + bid + "</td>");
                        out.println("<td>" + uid + "</td>");
                        out.println("<td>" + vt + "</td>");
                        out.println("<td>" + pl + "</td>");
                        out.println("<td>" + dl + "</td>");
                        out.println("<td>" + driver + "</td>");
                        out.println("<td>LKR " + fare + "</td>");
                        out.println("<td>" + datetime + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving finished rides.</p>");
                }
            %>
        </div><!-- /sectionBookings -->


        <!-- Manage Drivers -->
        <div id="sectionDrivers" class="section">
            <h2>👨‍✈️ Manage Drivers</h2>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT DISTINCT driver_name FROM bookings WHERE driver_name IS NOT NULL");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Driver Name</th><th>Total Rides</th><th>Actions</th></tr>");

                    while (rs.next()) {
                        String driverName = rs.getString("driver_name");

                        // Count total rides assigned to this driver
                        int rideCount = 0;
                        try (PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM bookings WHERE driver_name=?")) {
                            countStmt.setString(1, driverName);
                            ResultSet countRs = countStmt.executeQuery();
                            if (countRs.next()) {
                                rideCount = countRs.getInt(1);
                            }
                        }

                        out.println("<tr>");
                        out.println("<td>" + driverName + "</td>");
                        out.println("<td>" + rideCount + "</td>");

                        // Update
                        out.println("<td>");
                        out.println("<form action='UpdateDriverServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='oldDriverName' value='" + driverName + "' />");
                        out.println("<input type='text' name='newDriverName' placeholder='Enter new name' required />");
                        out.println("<button type='submit' class='btn btn-update'>Update</button>");
                        out.println("</form>");

                        // Delete
                        out.println(" &nbsp; ");
                        out.println("<form action='DeleteDriverServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='driverName' value='" + driverName + "' />");
                        out.println("<button type='submit' class='btn btn-delete'>Delete</button>");
                        out.println("</form>");
                        out.println("</td>");

                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving drivers.</p>");
                }
            %>
        </div><!-- /sectionDrivers -->


        <!-- Manage Vehicles -->
        <div id="sectionVehicles" class="section">
            <h2>🚗 Manage Vehicles</h2>
            <%
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vehicles ORDER BY vehicle_type, vehicle_name");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>Vehicle Type</th><th>Vehicle Name</th><th>Status</th><th>Actions</th></tr>");

                    while (rs.next()) {
                        int vehicleId = rs.getInt("vehicle_id");
                        String type = rs.getString("vehicle_type");
                        String name = rs.getString("vehicle_name");
                        String vstatus = rs.getString("status");

                        out.println("<tr>");
                        out.println("<td>" + type + "</td>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + vstatus + "</td>");

                        // Update status form
                        out.println("<td>");
                        out.println("<form action='UpdateVehicleServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='vehicleId' value='" + vehicleId + "' />");
                        out.println("<select name='status'>");
                        out.println("<option value='Running' " + (vstatus.equals("Running") ? "selected" : "") + ">✅ Running</option>");
                        out.println("<option value='Maintenance' " + (vstatus.equals("Maintenance") ? "selected" : "") + ">🔧 Maintenance</option>");
                        out.println("<option value='Needs Check' " + (vstatus.equals("Needs Check") ? "selected" : "") + ">⚠️ Needs Check</option>");
                        out.println("</select>");
                        out.println("<button type='submit' class='btn btn-update'>Update</button>");
                        out.println("</form>");

                        // Delete
                        out.println("<form action='DeleteVehicleServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='vehicleId' value='" + vehicleId + "' />");
                        out.println("<button type='submit' class='btn btn-cancel'>Remove</button>");
                        out.println("</form>");

                        out.println("</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving vehicles.</p>");
                }
            %>

            <h3>➕ Add New Vehicle</h3>
            <form action="AddVehicleServlet" method="post">
                <label>Vehicle Type:</label>
                <select name="vehicle_type" required>
                    <option value="Budget">Budget</option>
                    <option value="city">City</option>
                    <option value="Semi">Semi</option>
                    <option value="9 Seater">9 Seater</option>
                    <option value="14 Seater">14 Seater</option>
                    <option value="Car">Car</option>
                </select>

                <label>Vehicle Name:</label>
                <input type="text" name="vehicle_name" required />

                <button type="submit" class="btn btn-accept">Add Vehicle</button>
            </form>
        </div><!-- /sectionVehicles -->


        <!--  NEW: Manage Users -->
        <div id="sectionUsers" class="section">
            <h2><i class="fas fa-users"></i> Manage Users</h2>
            <%
                // Retrieve all users
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT id, name, username FROM users ORDER BY name");
                     ResultSet rs = stmt.executeQuery()) {

                    out.println("<table>");
                    out.println("<tr><th>User ID</th><th>Name</th><th>Username</th><th>Total Rides</th><th>Actions</th></tr>");

                    while (rs.next()) {
                        int uId = rs.getInt("id");
                        String uName = rs.getString("name");
                        String uUser = rs.getString("username");

                        // Count how many rides the user has
                        int userRideCount = 0;
                        try (PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM bookings WHERE user_id=?")) {
                            countStmt.setInt(1, uId);
                            ResultSet countRs = countStmt.executeQuery();
                            if (countRs.next()) {
                                userRideCount = countRs.getInt(1);
                            }
                        }

                        out.println("<tr>");
                        out.println("<td>" + uId + "</td>");
                        out.println("<td>" + uName + "</td>");
                        out.println("<td>" + uUser + "</td>");
                        out.println("<td>" + userRideCount + "</td>");
                        out.println("<td>");
                        // Optional: Delete user form
                        out.println("<form action='DeleteUserServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='userId' value='" + uId + "' />");
                        out.println("<button type='submit' class='btn btn-delete'>Delete</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error retrieving user list.</p>");
                }
            %>
        </div><!-- /sectionUsers -->

    </div><!-- /container -->
</body>
</html>
