<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Include the shared header -->
<%@ include file="header.jsp" %>

<!-- Main Content: 2-column layout (left image, right form) -->
<style>
  .container {
    display: flex;
    width: 90%;
    max-width: 1100px;
    background-color: #1c2541; /* Lighter navy */
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
    margin: 40px auto;
  }
  .left-panel {
    flex: 1;
    background: url('IMG/car re.jpg') no-repeat center center/cover;
    position: relative;
  }
  .left-panel::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.3);
  }
  .right-panel {
    flex: 1.5;
    background-color: #0b132b;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
  }
  .form-card {
    width: 100%;
    max-width: 450px;
    background-color: #0b132b;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  }
  .form-card h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #5bc0be;
  }
  .form-group {
    margin-bottom: 15px;
  }
  .form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
  }
  .input-icon {
    display: flex;
    align-items: center;
    background-color: #1c2541;
    border-radius: 5px;
    padding: 10px;
  }
  .input-icon i {
    color: #5bc0be;
    margin-right: 10px;
    font-size: 1.2rem;
  }
  .input-field {
    border: none;
    outline: none;
    background: transparent;
    color: #ffffff;
    width: 100%;
    font-size: 1rem;
  }
  .input-field::placeholder {
    color: #999999;
  }
  .btn-submit {
    display: inline-block;
    width: 100%;
    background-color: #5bc0be;
    color: #ffffff;
    padding: 12px;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    font-weight: bold;
    text-align: center;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    margin-top: 10px;
  }
  .btn-submit:hover {
    background-color: #3a506b;
    transform: translateY(-3px);
  }
  .login-link {
    margin-top: 15px;
    text-align: center;
  }
  .login-link a {
    color: #5bc0be;
    font-weight: bold;
    text-decoration: none;
  }
  .login-link a:hover {
    text-decoration: underline;
  }
</style>

<div class="container">
  <div class="left-panel">
    <!-- Illustration on left -->
  </div>
  <div class="right-panel">
    <div class="form-card">
      <h2>Create an Account</h2>
      <!-- Adjust the form action to your RegisterServlet or registration processing page -->
      <form action="RegisterServlet" method="post">
        <!-- Name -->
        <div class="form-group">
          <label for="name">Name</label>
          <div class="input-icon">
            <i class="fas fa-user"></i>
            <input 
              type="text" 
              id="name" 
              name="name"
              placeholder="Enter your full name" 
              class="input-field" 
              required
            >
          </div>
        </div>
        <!-- Address -->
        <div class="form-group">
          <label for="address">Address</label>
          <div class="input-icon">
            <i class="fas fa-map-marker-alt"></i>
            <input 
              type="text" 
              id="address" 
              name="address"
              placeholder="Enter your address"
              class="input-field"
              required
            >
          </div>
        </div>
        <!-- NIC -->
        <div class="form-group">
          <label for="nic">NIC No</label>
          <div class="input-icon">
            <i class="fas fa-id-card"></i>
            <input 
              type="text" 
              id="nic" 
              name="nic"
              placeholder="NIC Number"
              class="input-field"
              required
            >
          </div>
        </div>
        <!-- Phone -->
        <div class="form-group">
          <label for="phone">Phone No</label>
          <div class="input-icon">
            <i class="fas fa-phone"></i>
            <input 
              type="text" 
              id="phone" 
              name="phone"
              placeholder="Phone Number"
              class="input-field"
              required
            >
          </div>
        </div>
        <!-- Username -->
        <div class="form-group">
          <label for="username">Username</label>
          <div class="input-icon">
            <i class="fas fa-user-circle"></i>
            <input 
              type="text" 
              id="username" 
              name="username"
              placeholder="Create a username"
              class="input-field"
              required
            >
          </div>
        </div>
        <!-- Password -->
        <div class="form-group">
          <label for="password">Password</label>
          <div class="input-icon">
            <i class="fas fa-lock"></i>
            <input 
              type="password" 
              id="password" 
              name="password"
              placeholder="Create a password"
              class="input-field"
              required
            >
          </div>
        </div>

        <!-- Register Button -->
        <button type="submit" class="btn-submit">Register</button>
      </form>
      <!-- Already have account? -->
      <div class="login-link">
        <p>Already have an account?
           <a href="login.jsp">Log in here</a>
        </p>
      </div>
    </div>
  </div>
</div>

<!-- Include the shared footer -->
<%@ include file="footer.jsp" %>
