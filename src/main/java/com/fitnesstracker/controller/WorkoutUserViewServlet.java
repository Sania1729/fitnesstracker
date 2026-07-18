package com.fitnesstracker.controller;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.dao.WorkoutDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/workout-user-view")
public class WorkoutUserViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO;
    
    public void init() {
        workoutDAO = new WorkoutDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== WorkoutUserViewServlet START ===");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("WorkoutUserViewServlet - userName: " + userName);
        System.out.println("WorkoutUserViewServlet - userRole: " + userRole);
        
        if (userName == null) {
            System.out.println("WorkoutUserViewServlet - No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get all workouts for user view
        List<WorkoutDTO> workouts = workoutDAO.getAllWorkouts();
        
        System.out.println("WorkoutUserViewServlet - workouts retrieved: " + (workouts != null ? workouts.size() : "null"));
        
        request.setAttribute("workouts", workouts);
        request.getRequestDispatcher("workout-user-view.jsp").forward(request, response);
        
        System.out.println("=== WorkoutUserViewServlet END ===");
    }
}
