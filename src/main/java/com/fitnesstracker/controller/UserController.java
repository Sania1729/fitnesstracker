package com.fitnesstracker.controller;

import com.fitnesstracker.dto.UserDTO;
import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.dao.UserDAO;
import com.fitnesstracker.dao.TrainerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private TrainerDAO trainerDAO;
    
    public void init() {
        userDAO = new UserDAO();
        trainerDAO = new TrainerDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        
        UserDTO user = new UserDTO();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setPhone(phone);
        
        boolean success = userDAO.registerUser(user);
        
        // If user is trainer, also create trainer record
        if (success && "trainer".equals(role)) {
            System.out.println("Creating trainer record for: " + name);
            
            TrainerDTO trainer = new TrainerDTO();
            trainer.setName(name);
            trainer.setSpecialization("General Fitness"); // Default specialization
            trainer.setExperience(0); // Default experience
            trainer.setPhone(phone);
            
            boolean trainerCreated = trainerDAO.addTrainer(trainer);
            System.out.println("Trainer record created: " + trainerCreated);
            
            if (!trainerCreated) {
                System.out.println("Failed to create trainer record for: " + name);
                // Still return success for user registration, but log the error
            }
        }
        
        if (success) {
            response.sendRedirect("login.jsp?message=registered");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
