<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>


<%
    // Ensure user is logged in
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }

    int userId = (int) sess.getAttribute("userId");
    String name = "", address = "", nic = "", phone = "", username = (String) sess.getAttribute("username");

    // Fetch user details from database
    try (Connection conn = com.example.util.DatabaseUtility.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT name, address, nic, phone FROM users WHERE id=?")) {

        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            address = rs.getString("address");
            nic = rs.getString("nic");
            phone = rs.getString("phone");
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
    <title>User Dashboard - Mega City Cab</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
       
body {
    background-color: #0b132b; /* Dark Blue */
    color: #E0E0E0; /* Light Grey for better contrast */
    font-family: 'Poppins', sans-serif;
}

        /* Sidebar Navigation */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #1c2541;
            padding: 20px;
            position: fixed;
        }

        .sidebar .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .sidebar .logo i {
            font-size: 40px;
            color: #5bc0be;
        }

        .sidebar .logo h2 {
            margin: 10px 0 20px;
            font-size: 20px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 15px;
            margin-bottom: 10px;
            background: #3a506b;
            border-radius: 8px;
            transition: 0.3s;
            cursor: pointer;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: white;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar ul li:hover, .sidebar ul li.active {
            background: #5bc0be;
        }

        /* Main Content */
        .main-content {
            margin-left: 270px;
            width: calc(100% - 270px);
            padding: 20px;
        }

        .header h2 {
            color: #5bc0be;
        }

        /* Hide All Sections Initially */
        .section {
            display: none;
        }

        /* Show Active Section */
        .active-section {
            display: block;
        }

        /* Cards */
        .card {
            background: #3a506b;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        .card h3 {
            color: #5bc0be;
            margin-bottom: 10px;
        }

        .card form input {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: none;
            border-radius: 5px;
            background: #1c2541;
            color: white;
        }

        .card button {
            background: #5bc0be;
            border: none;
            padding: 10px;
            width: 100%;
            cursor: pointer;
        }

        .card button:hover {
            background: #1c2541;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background: #5bc0be;
        }

        td {
            background: #1c2541;
        }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <div class="logo">
        <i class="fas fa-taxi"></i>
        <h2>Mega City Cab</h2>
    </div>
    <ul>
        <li><a href="index.html"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="ride.jsp"><i class="fas fa-car"></i> Book a Ride</a></li>
        <li onclick="showSection('profile')" id="profile-link" class="active"><i class="fas fa-user"></i> Profile</li>
        <li onclick="showSection('rides')" id="rides-link"><i class="fas fa-history"></i> My Rides</li>
        <li><a href="UserLogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Dashboard -->
<div class="main-content">
    <div class="header">
        <h2>Welcome, <%= name %>!</h2>
    </div>

    <!-- User Profile Section -->
    <div id="profile" class="section active-section">
        <div class="card">
            <h3>Profile Information</h3>
            <form action="UpdateProfileServlet" method="post">
                <label>Name:</label>
                <input type="text" name="name" value="<%= name %>" required>

                <label>Address:</label>
                <input type="text" name="address" value="<%= address %>" required>

                <label>NIC:</label>
                <input type="text" name="nic" value="<%= nic %>" required>

                <label>Phone:</label>
                <input type="text" name="phone" value="<%= phone %>" required>

                <button type="submit">Update Profile</button>
            </form>
        </div>
    </div>

    <!-- Ride History Section -->
    <div id="rides" class="section">
        <h3>My Ride History</h3>
        <table>
            <tr>
                <th>Vehicle</th>
                <th>Pickup</th>
                <th>Drop</th>
                <th>Date/Time</th>
                <th>Status</th>
                <th>Driver</th>
                <th>Fare</th>
            </tr>
            <%
                String sqlHistory = "SELECT vehicle_type, pickup_location, drop_location, ride_datetime, status, driver_name, fare FROM bookings WHERE user_id=? ORDER BY ride_datetime DESC";
                try (Connection conn = com.example.util.DatabaseUtility.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(sqlHistory)) {

                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("vehicle_type") + "</td>");
                        out.println("<td>" + rs.getString("pickup_location") + "</td>");
                        out.println("<td>" + rs.getString("drop_location") + "</td>");
                        out.println("<td>" + rs.getString("ride_datetime") + "</td>");
                        out.println("<td>" + rs.getString("status") + "</td>");
                        out.println("<td>" + rs.getString("driver_name") + "</td>");
                        out.println("<td>LKR " + rs.getString("fare") + "</td>");
                        out.println("</tr>");
                    }
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</div>

<script>
    function showSection(sectionId) {
        document.querySelectorAll(".section").forEach(section => section.classList.remove("active-section"));
        document.getElementById(sectionId).classList.add("active-section");
    }
</script>

</body>
</html>
