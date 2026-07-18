package com.fitnesstracker.controller;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.dao.WorkoutDAO;
import com.fitnesstracker.dao.UserDAO;
import com.fitnesstracker.dto.UserDTO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/start-workout")
public class StartWorkoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO;
    private UserDAO userDAO;
    
    public void init() {
        workoutDAO = new WorkoutDAO();
        userDAO = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== StartWorkoutServlet START ===");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        Integer userId = (Integer) session.getAttribute("userId");
        
        System.out.println("StartWorkoutServlet - userName: " + userName);
        System.out.println("StartWorkoutServlet - userId: " + userId);
        
        if (userName == null) {
            System.out.println("StartWorkoutServlet - No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        String workoutIdStr = request.getParameter("workoutId");
        if (workoutIdStr == null) {
            System.out.println("StartWorkoutServlet - No workoutId provided");
            response.sendRedirect("workout-user-view");
            return;
        }
        
        try {
            int workoutId = Integer.parseInt(workoutIdStr);
            WorkoutDTO workout = workoutDAO.getWorkoutById(workoutId);
            
            if (workout == null) {
                System.out.println("StartWorkoutServlet - Workout not found: " + workoutId);
                response.sendRedirect("workout-user-view");
                return;
            }
            
            // Create a workout session/record
            String sessionId = userName + "_" + workoutId + "_" + System.currentTimeMillis();
            
            // Store workout session info
            session.setAttribute("currentWorkout", workout);
            session.setAttribute("workoutSessionId", sessionId);
            session.setAttribute("workoutStartTime", LocalDateTime.now());
            
            System.out.println("StartWorkoutServlet - Workout started: " + workout.getExerciseName());
            System.out.println("StartWorkoutServlet - Session ID: " + sessionId);
            
            // Redirect to workout tracking page
            response.sendRedirect("workout-tracking.jsp");
            
        } catch (NumberFormatException e) {
            System.out.println("StartWorkoutServlet - Invalid workout ID: " + workoutIdStr);
            response.sendRedirect("workout-user-view");
        } catch (Exception e) {
            System.out.println("StartWorkoutServlet - Error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("workout-user-view");
        }
        
        System.out.println("=== StartWorkoutServlet END ===");
    }
}
