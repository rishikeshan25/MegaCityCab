<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Include the shared header -->
<%@ include file="header.jsp" %>

<!--Main Content: 2-column layout (left image, right form) -->
<!-- Add any custom styling for the two-column layout here or in your main CSS -->

<%
    HttpSession sessionObj = request.getSession(false);
    String registerSuccess = (sessionObj != null) ? (String) sessionObj.getAttribute("registerSuccess") : null;
    if (registerSuccess != null) {
        out.println("<div class='success-message'>" + registerSuccess + "</div>");
        sessionObj.removeAttribute("registerSuccess"); // Remove message after displaying
    }
%>
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
    background: url('IMG/login.jpg') no-repeat center center/cover;
    position: relative;
  }
  .left-panel::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.3);
  }
  .right-panel {
    flex: 1;
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
  .register-link {
    margin-top: 15px;
    text-align: center;
  }
  .register-link a {
    color: #5bc0be;
    font-weight: bold;
    text-decoration: none;
  }
  .register-link a:hover {
    text-decoration: underline;
  }
</style>

<div class="container">
  <div class="left-panel">
    <!-- Illustration on left -->
  </div>
  <div class="right-panel">
    <div class="form-card">
      <h2>Welcome Back</h2>
      <!-- Form action goes to your LoginServlet or any login processing page -->
      <form action="LoginServlet" method="post">
        <!-- Username -->
        <div class="form-group">
          <label for="username">Username</label>
          <div class="input-icon">
            <i class="fas fa-user-circle"></i>
            <input 
              type="text" 
              id="username" 
              name="username" 
              placeholder="Enter your username" 
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
              placeholder="Enter your password" 
              class="input-field"
              required
            >
          </div>
        </div>
        <!-- Submit Button -->
        <button type="submit" class="btn-submit">Login</button>
      </form>
      <!-- Register Link -->
      <div class="register-link">
        <p>Don't have an account?
           <a href="register.jsp">Create one here</a>
        </p>
      </div>
    </div>
  </div>
</div>

<!-- Include the shared footer -->
<%@ include file="footer.jsp" %>
