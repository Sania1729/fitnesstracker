package com.fitnesstracker.controller;

import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.dao.TrainerDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/trainer-actions/*")
public class TrainerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainerDAO trainerDAO;
    
    public void init() {
        trainerDAO = new TrainerDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");
            int experience = Integer.parseInt(request.getParameter("experience"));
            String phone = request.getParameter("phone");
            
            TrainerDTO trainer = new TrainerDTO();
            trainer.setName(name);
            trainer.setSpecialization(specialization);
            trainer.setExperience(experience);
            trainer.setPhone(phone);
            
            boolean success = trainerDAO.addTrainer(trainer);
            
            if (success) {
                response.sendRedirect("../admin-dashboard.jsp?message=trainer_added");
            } else {
                response.sendRedirect("../admin-dashboard.jsp?error=trainer_failed");
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if ("/list".equals(pathInfo)) {
            List<TrainerDTO> trainers = trainerDAO.getAllTrainers();
            request.setAttribute("trainers", trainers);
            request.getRequestDispatcher("../admin/view-trainers.jsp").forward(request, response);
        } else if ("/delete".equals(pathInfo)) {
            int trainerId = Integer.parseInt(request.getParameter("id"));
            boolean success = trainerDAO.deleteTrainer(trainerId);
            
            if (success) {
                response.sendRedirect("../admin-dashboard.jsp?message=trainer_deleted");
            } else {
                response.sendRedirect("../admin-dashboard.jsp?error=delete_failed");
            }
        }
    }
}
