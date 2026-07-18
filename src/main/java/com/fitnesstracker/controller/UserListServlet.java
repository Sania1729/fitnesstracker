package com.fitnesstracker.controller;

import com.fitnesstracker.dao.UserDAO;
import com.fitnesstracker.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/list")
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
        System.out.println("UserListServlet initialized");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== UserListServlet START ===");
        System.out.println("UserListServlet - Fetching all users");
        
        try {
            List<UserDTO> users = userDAO.getAllUsers();
            
            System.out.println("UserListServlet - Found " + users.size() + " users");
            
            // Set users as request attribute
            request.setAttribute("users", users);
            
            // Forward to user list JSP
            request.getRequestDispatcher("/user-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("UserListServlet - Error: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and redirect to admin dashboard
            response.sendRedirect("admin-dashboard.jsp?error=Failed to load users");
        }
        
        System.out.println("=== UserListServlet END ===");
    }
}
