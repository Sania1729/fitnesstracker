package com.fitnesstracker.controller;

import com.fitnesstracker.dao.TrainerDAO;
import com.fitnesstracker.dto.TrainerDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/trainer/list")
public class TrainerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainerDAO trainerDAO;

    public void init() {
        trainerDAO = new TrainerDAO();
        System.out.println("TrainerListServlet initialized");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== TrainerListServlet START ===");
        System.out.println("TrainerListServlet - Fetching all trainers");
        
        try {
            List<TrainerDTO> trainers = trainerDAO.getAllTrainers();
            
            System.out.println("TrainerListServlet - Found " + trainers.size() + " trainers");
            
            // Set trainers as request attribute
            request.setAttribute("trainers", trainers);
            
            // Forward to trainer list JSP
            request.getRequestDispatcher("/admin/trainer-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("TrainerListServlet - Error: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and redirect to admin dashboard
            response.sendRedirect("admin-dashboard.jsp?error=Failed to load trainers");
        }
        
        System.out.println("=== TrainerListServlet END ===");
    }
}
