
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
  <meta charset="UTF-8">
  <title>Mega City Cab - Book a Ride</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background: #0b132b; /* Dark Blue */
      color: white;
    }
    .container {
      max-width: 1000px;
      margin: 40px auto;
      background: #1c2541; /* Darker Blue */
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      padding: 20px;
    }
    h1 {
      text-align: center;
      margin-bottom: 20px;
      color: #5bc0be; /* Light Blue */
    }

    /* Vehicle Selection */
    .vehicle-options {
      display: flex;
      gap: 15px;
      overflow-x: auto;
      margin-bottom: 30px;
    }
    .vehicle-option {
      padding: 10px 15px;
      background: #3a506b; /* Medium Blue */
      border-radius: 5px;
      cursor: pointer;
      min-width: 110px;
      text-align: center;
      font-weight: bold;
      color: white;
      flex-shrink: 0;
      transition: all 0.3s ease;
    }
    .vehicle-option:hover {
      background: #5bc0be; /* Light Blue */
      color: #0b132b;
      transform: scale(1.05);
    }
    .vehicle-option.selected {
      background: #5bc0be; 
      color: #0b132b;
      transform: scale(1.05);
    }

    /* Car Details */
    .car-details {
      display: flex;
      gap: 20px;
      align-items: center;
    }
    .car-info-left {
      flex: 1;
      background: #3a506b;
      padding: 20px;
      border-radius: 10px;
      color: white;
    }
    .car-info-left h2 {
      font-size: 2rem;
      margin-bottom: 10px;
      color: #5bc0be;
    }
    .car-info-left h3 {
      font-size: 1.3rem;
      margin-bottom: 10px;
      color: #ddd;
    }
    .car-info-left p {
      font-size: 1rem;
      margin-bottom: 15px;
      color: #ccc;
      line-height: 1.4;
    }
    .features-list {
      list-style: none;
      padding: 0;
      margin: 0;
      color: #ddd;
    }
    .features-list li {
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 0.95rem;
    }
    .features-list li i {
      color: #5bc0be;
    }

    .car-image {
      flex: 1.2;
      text-align: center;
    }
    .car-image img {
      width: 100%;
      max-width: 400px;
      border-radius: 10px;
      object-fit: cover;
      box-shadow: 0 0 15px rgba(255,255,255,0.2);
    }

    /* Booking Form */
    .booking-form {
      background: #3a506b;
      border-radius: 10px;
      padding: 20px;
      margin-top: 30px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.2);
      color: white;
    }
    .booking-form h2 {
      margin-bottom: 15px;
      font-size: 1.5rem;
      text-align: center;
      color: #5bc0be;
    }
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      font-weight: bold;
      margin-bottom: 5px;
      display: block;
      color: #fff;
    }
    .form-group input {
      width: 100%;
      padding: 10px;
      font-size: 1rem;
      border: 1px solid #ccc;
      border-radius: 5px;
      outline: none;
      background: #1c2541;
      color: white;
    }
    .btn-book {
      background: #5bc0be;
      color: #0b132b;
      padding: 12px 30px;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
      margin-top: 10px;
      width: 100%;
    }
    .btn-book:hover {
      background-color: #1c2541;
      color: white;
      transform: scale(1.03);
    }

    @media screen and (max-width: 900px) {
      .car-details {
        flex-direction: column;
      }
      .car-image img {
        max-width: 300px;
      }
    }
  </style>
</head>
<body>
    
  <div class="container">
    <h1>Book Your Ride</h1>

    <!-- Vehicle Selection -->
    <div class="vehicle-options">
      <div class="vehicle-option selected" data-type="budget">Budget</div>
      <div class="vehicle-option" data-type="city">City</div>
      <div class="vehicle-option" data-type="semi">Semi</div>
      <div class="vehicle-option" data-type="car">Car</div>
      <div class="vehicle-option" data-type="9seater">9 Seater</div>
      <div class="vehicle-option" data-type="14seater">14 Seater</div>
    </div>

    <!-- Car Details Section -->
    <div class="car-details">
      <!-- Left panel: text info -->
      <div class="car-info-left">
        <h2 id="categoryHeading">Budget</h2>
        <h3 id="carName">Suzuki Alto</h3>
        <p id="carDesc">A small hatchback, air conditioned with capacity of 3 passengers ideal for short distance trips.</p>
        <ul class="features-list" id="featuresList">
          <li><i class="fas fa-user-friends"></i> 3 passengers</li>
          <li><i class="fas fa-snowflake"></i> Air Conditioned</li>
          <li><i class="fas fa-suitcase"></i> Limited baggage</li>
        </ul>
      </div>

      <!-- Right panel: main car image -->
      <div class="car-image">
        <img id="mainCarImg" src="IMG/alto.png" alt="Main Car Image">
      </div>
    </div>

    <!-- Booking Form -->
    <form class="booking-form" action="BookingServlet" method="post">
      <h2>Enter Your Booking Details</h2>
      <input type="hidden" name="selectedVehicle" id="selectedVehicle" value="budget">

      <div class="form-group">
        <label for="pickup">Pick-up Location</label>
        <input type="text" id="pickup" name="pickup" placeholder="Enter pickup location" required>
      </div>
      <div class="form-group">
        <label for="drop">Drop Location</label>
        <input type="text" id="drop" name="drop" placeholder="Enter drop location" required>
      </div>
      <div class="form-group">
        <label for="datetime">Date &amp; Time</label>
        <input type="datetime-local" id="datetime" name="datetime" required>
      </div>

      <button type="submit" class="btn-book">Book Now</button>
    </form>
  </div>

  <script>
    const carData = {
      budget: { category: "Budget", name: "Suzuki Alto", description: "A small hatchback...", img: "IMG/alto.png" },
      city: { category: "City", name: "Suzuki WagonR", description: "A hatchback...", img: "IMG/wagon.png" },
      semi: { category: "Semi", name: "Toyota Aqua", description: "Compact, air-conditioned...", img: "IMG/aqua.png" },
      car: { category: "Car", name: "Toyota Prius", description: "A full size sedan...", img: "IMG/prius.png" },
      "9seater": { category: "9 Seater", name: "Toyota KDH", description: "A full sized van...", img: "IMG/kdh.png" },
      "14seater": { category: "14 Seater", name: "Highroof KDH", description: "A full sized commuter van...", img: "IMG/high.png" }
    };

    document.querySelectorAll(".vehicle-option").forEach(option => {
      option.addEventListener("click", () => {
        document.querySelectorAll(".vehicle-option").forEach(o => o.classList.remove("selected"));
        option.classList.add("selected");
        const type = option.getAttribute("data-type");
        document.getElementById("categoryHeading").textContent = carData[type].category;
        document.getElementById("carName").textContent = carData[type].name;
        document.getElementById("carDesc").textContent = carData[type].description;
        document.getElementById("mainCarImg").src = carData[type].img;
        document.getElementById("selectedVehicle").value = type;
      });
    });
  </script>
  <%@ include file="footer.jsp" %>
</body>
</html>
