package com.fitnesstracker.controller;

import com.fitnesstracker.dto.UserDTO;
import com.fitnesstracker.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    public void init() {
        System.out.println("=== LoginController INIT ===");
        userDAO = new UserDAO();
        System.out.println("LoginController - UserDAO initialized");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== LoginController doPost START ===");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("LoginController - Email: " + email);
        System.out.println("LoginController - Password: " + (password != null ? "provided" : "null"));
        
        UserDTO user = userDAO.loginUser(email, password);
        
        System.out.println("LoginController - User found: " + (user != null ? "YES" : "NO"));
        
        if (user != null) {
            System.out.println("LoginController - User Role: " + user.getRole());
            System.out.println("LoginController - User Name: " + user.getName());
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userPhone", user.getPhone());
            session.setAttribute("userRole", user.getRole());
            
            // Redirect based on role
            switch (user.getRole()) {
                case "admin":
                    System.out.println("LoginController - Redirecting to admin dashboard");
                    response.sendRedirect("admin-dashboard.jsp");
                    break;
                case "trainer":
                    System.out.println("LoginController - Redirecting to trainer dashboard");
                    response.sendRedirect("trainer-dashboard.jsp");
                    break;
                case "user":
                    System.out.println("LoginController - Redirecting to user dashboard");
                    response.sendRedirect("user-dashboard.jsp");
                    break;
                default:
                    System.out.println("LoginController - Unknown role, redirecting to login");
                    response.sendRedirect("login.jsp?error=invalid_role");
                    break;
            }
        } else {
            System.out.println("LoginController - Login failed, redirecting with error");
            response.sendRedirect("login.jsp?error=invalid");
        }
        
        System.out.println("=== LoginController END ===");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
