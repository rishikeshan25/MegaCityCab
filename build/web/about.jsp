<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Include the shared header -->
<%@ include file="header.jsp" %>


    <style>
       
body {
    background-color: #0b132b; /* Dark Blue */
    color: #E0E0E0; /* Light Grey for better contrast */
    font-family: 'Poppins', sans-serif;
}

/* About Section */
.about-section {
    max-width: 1200px;
    margin: 40px auto;
    padding: 20px;
    text-align: center;
}

.about-section h2 {
    font-size: 2rem;
    color: #5bc0be; /* Teal Accent */
    margin-bottom: 10px;
}

.about-section p {
    font-size: 1rem;
    color: #E0E0E0; /* Light Grey */
    line-height: 1.6;
    max-width: 800px;
    margin: 0 auto;
}

/* Features Section */
.features-section {
    max-width: 1200px;
    margin: 40px auto;
    padding: 20px;
    text-align: center;
}

.features-section h2 {
    font-size: 2rem;
    color: #5bc0be; /* Teal Accent */
    margin-bottom: 20px;
}

.feature-cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
}

.feature-card {
    background: #1c2541; /* Slightly Lighter Blue */
    flex: 0 0 calc(25% - 20px); /* 4 cards per row on large screens */
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(255, 255, 255, 0.1);
    padding: 20px;
    text-align: center;
    transition: transform 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(91, 192, 190, 0.5);
}

.feature-card img {
    width: 80px;
    height: 80px;
    margin-bottom: 15px;
    filter: brightness(1.2); /* Slightly brighten images */
}

.feature-card h3 {
    font-size: 1.2rem;
    color: #5bc0be;
    margin-bottom: 10px;
}

.feature-card p {
    font-size: 0.95rem;
    color: #E0E0E0;
    line-height: 1.4;
}

/* Footer */
footer {
    background: #1c2541;
    color: #5bc0be;
    text-align: center;
    padding: 20px;
    font-weight: bold;
    margin-top: 40px;
}

/* Social Media Icons */
footer a {
    color: #5bc0be;
    margin: 0 10px;
    font-size: 20px;
    transition: color 0.3s ease;
}

footer a:hover {
    color: #ffffff;
}

/* Responsive Adjustments */
@media (max-width: 992px) {
    .feature-card {
        flex: 0 0 calc(50% - 20px); /* 2 per row on medium screens */
    }
}

@media (max-width: 600px) {
    .feature-card {
        flex: 0 0 calc(100% - 20px); /* 1 per row on small screens */
    }
}
    </style>
</head>
<body>
    

    <!-- About Section -->
    <section class="about-section">
        <h2>About Mega City Cab</h2>
        <p>
            Mega City Cab is a premier cab service in Colombo, offering reliable transportation
            and exceptional comfort for our customers. We pride ourselves on experienced drivers,
            a well-maintained fleet, and dedicated customer support. Book with us for a truly
            hassle-free ride experience.
        </p>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <h2>Our Features</h2>
        <div class="feature-cards">
            <!-- Feature 1 -->
            <div class="feature-card">
                <img src="IMG/feature2.jpg" alt="Diverse Fleet Icon">
                <h3>Trained Drivers</h3>
                <p>Our friendly, professional drivers are not just experts behind the wheel,they've gone through a thorough vetting and selection process to ensure the safety of our riders </p>
            </div>
            <!-- Feature 2 -->
            <div class="feature-card">
                <img src="IMG/feature1.avif" alt="Free Cancellation Icon">
                <h3>Free Cancellation</h3>
                <p>Cancel at no cost, anytime you need. Enjoy a worry-free booking experience.</p>
            </div>
            <!-- Feature 3 -->
            <div class="feature-card">
                <img src="IMG/feature3.avif" alt="35 Years Icon">
                <h3>35+ Years in the Industry</h3>
                <p>With over three decades of trusted service, we pride ourselves on delivering reliability and expertise in every ride.</p>
            </div>
            <!-- Feature 4 -->
            <div class="feature-card">
                <img src="IMG/feature4.png" alt="Google Reviews Icon">
                <h3>Baby Seat</h3>
                <p>Traveling with little ones? We’ve got safe, comfy baby seats to keep your family happy on the go</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
   <footer style="background-color: #1c2541; text-align: center; padding: 20px; color: #5bc0be; font-weight: bold;">

    

    <!-- Social Media Icons -->
    <div style="margin-bottom: 10px;">
        <a href="#" style="color: #5bc0be; margin: 0 10px;"><i class="fab fa-facebook-f"></i></a>
        <a href="#" style="color: #5bc0be; margin: 0 10px;"><i class="fab fa-twitter"></i></a>
        <a href="#" style="color: #5bc0be; margin: 0 10px;"><i class="fab fa-instagram"></i></a>
        <a href="#" style="color: #5bc0be; margin: 0 10px;"><i class="fab fa-linkedin"></i></a>
    </div>

    <!-- Contact Info -->
    <p>📍 123, Main Street, Colombo, Sri Lanka</p>
    <p>📞 +94 71 234 5678 | ✉️ support@megacitycab.com</p>

    <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
</footer>
</body>
</html>
