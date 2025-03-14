<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- header.jsp - shared header & navbar -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega City Cab</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Main CSS (Dark Blue/Teal Theme) -->
    <!-- If you have a separate styles.css in /css/, link it below -->
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Top Header / Navbar -->
    <header style="background-color: #1c2541; color: #ffffff; padding: 15px 50px; display: flex; align-items: center; justify-content: space-between;">
        <div class="logo" style="display: flex; align-items: center;">
            <img src="IMG/logo.png" alt="Mega City Cab Logo" style="height: 50px; margin-right: 15px;">
            <span style="font-size: 24px; font-weight: bold; color: #5bc0be;">Mega City Cab</span>
        </div>
        <nav>
            <ul style="list-style: none; display: flex; gap: 20px; margin: 0; padding: 0;">
                <li><a href="index.html" style="text-decoration: none; color: white; font-weight: bold;"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="ride.jsp" style="text-decoration: none; color: white; font-weight: bold;"><i class="fas fa-car"></i> Ride</a></li>
                <li><a href="about.jsp" style="text-decoration: none; color: white; font-weight: bold;"><i class="fas fa-info-circle"></i> About Us</a></li>
                <li><a href="login.jsp" style="text-decoration: none; color: white; font-weight: bold;"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                <li><a href="register.jsp" style="text-decoration: none; color: white; font-weight: bold;"><i class="fas fa-user-plus"></i> Register</a></li>
            </ul>
        </nav>
    </header>
