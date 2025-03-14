package com.login;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hardcoded for demonstration
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        if(ADMIN_USERNAME.equals(user) && ADMIN_PASSWORD.equals(pass)) {
            HttpSession sess = request.getSession();
            sess.setAttribute("isAdmin", true);
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("adminLogin.jsp?error=Invalid credentials");
        }
    }
}
