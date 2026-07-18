package com.fitnesstracker.controller;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.dao.WorkoutDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/workout-list")
public class WorkoutListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO;
    
    public void init() {
        workoutDAO = new WorkoutDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== WorkoutListServlet START ===");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        
        System.out.println("WorkoutListServlet - userName from session: " + userName);
        
        if (userName == null) {
            System.out.println("WorkoutListServlet - No userName in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get trainer ID by name
        int trainerId = TrainerUtil.getTrainerIdByName(userName);
        
        System.out.println("WorkoutListServlet - trainerId found: " + trainerId);
        
        if (trainerId == -1) {
            System.out.println("WorkoutListServlet - No trainer found, redirecting to dashboard with error");
            response.sendRedirect("trainer-dashboard.jsp?error=trainer_not_found");
            return;
        }
        
        List<WorkoutDTO> workouts = workoutDAO.getWorkoutsByTrainer(trainerId);
        
        System.out.println("WorkoutListServlet - workouts retrieved: " + (workouts != null ? workouts.size() : "null"));
        
        request.setAttribute("workouts", workouts);
        request.getRequestDispatcher("workout-list-simple.jsp").forward(request, response);
        
        System.out.println("=== WorkoutListServlet END ===");
    }
}
