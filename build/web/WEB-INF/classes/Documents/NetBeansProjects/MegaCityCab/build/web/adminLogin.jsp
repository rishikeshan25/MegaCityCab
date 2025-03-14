<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<h2 style="color:#5bc0be; text-align:center; font-size:24px;">Admin Login</h2>

<!-- Centering the form -->
<div style="display: flex; justify-content: center; align-items: center; height: 60vh;">
    <form action="AdminLoginServlet" method="post" 
          style="background-color:#0b132b; padding:20px; border-radius:10px; 
                 box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5); width:300px; text-align:left;">

        <label style="color:white; font-size:16px; display:block; margin-bottom:5px;">Username:</label>
        <input type="text" name="username" required 
               style="width:100%; padding:10px; margin-bottom:15px; border:1px solid #5bc0be; 
                      border-radius:5px; font-size:14px; background-color:#333; color:white;">

        <label style="color:white; font-size:16px; display:block; margin-bottom:5px;">Password:</label>
        <input type="password" name="password" required 
               style="width:100%; padding:10px; margin-bottom:15px; border:1px solid #5bc0be; 
                      border-radius:5px; font-size:14px; background-color:#333; color:white;">

        <button type="submit" 
                style="background-color:#5bc0be; color:white; border:none; padding:10px 15px; 
                       font-size:16px; border-radius:5px; cursor:pointer; width:100%;">
            Login
        </button>

    </form>
</div>

<!-- Error Message -->
<% String error = request.getParameter("error"); 
   if(error != null) { %>
   <p style="color:red; text-align:center; font-size:14px; margin-top:10px;"><%= error %></p>
<% } %>

<%@ include file="footer.jsp" %>
