package com.fitnesstracker.controller;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.dao.WorkoutDAO;
import com.fitnesstracker.dao.TrainerDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/workout/*")
public class WorkoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO;
    private TrainerDAO trainerDAO;
    
    public void init() {
        workoutDAO = new WorkoutDAO();
        trainerDAO = new TrainerDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            HttpSession session = request.getSession();
            String userName = (String) session.getAttribute("userName");
            
            // Try to get trainer ID
            int trainerId = TrainerUtil.getTrainerIdByName(userName);
            
            // If trainer not found, create one
            if (trainerId == -1) {
                String userPhone = (String) session.getAttribute("userPhone");
                if (userPhone == null) userPhone = "0000000000"; // Default phone
                
                boolean created = TrainerUtil.createTrainerForUser(userName, userPhone);
                if (created) {
                    // Try again to get the trainer ID
                    trainerId = TrainerUtil.getTrainerIdByName(userName);
                }
            }
            
            if (trainerId == -1) {
                response.sendRedirect("trainer-dashboard.jsp?error=trainer_not_found");
                return;
            }
            
            String exerciseName = request.getParameter("exerciseName");
            int sets = Integer.parseInt(request.getParameter("sets"));
            int reps = Integer.parseInt(request.getParameter("reps"));
            int duration = Integer.parseInt(request.getParameter("duration"));
            
            WorkoutDTO workout = new WorkoutDTO();
            workout.setExerciseName(exerciseName);
            workout.setSets(sets);
            workout.setReps(reps);
            workout.setDuration(duration);
            workout.setTrainerId(trainerId);
            
            boolean success = workoutDAO.addWorkout(workout);
            
            if (success) {
                response.sendRedirect("./trainer-dashboard.jsp?message=workout_added");
            } else {
                response.sendRedirect("./trainer-dashboard.jsp?error=workout_failed");
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        System.out.println("WorkoutController doGet - pathInfo: '" + pathInfo + "'");
        
        // Skip processing if pathInfo contains .jsp (to avoid redirect loops)
        if (pathInfo != null && pathInfo.contains(".jsp")) {
            System.out.println("WorkoutController - Skipping JSP path to avoid loop: " + pathInfo);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP files should be accessed directly");
            return;
        }
        
        System.out.println("WorkoutController - pathInfo length: " + (pathInfo != null ? pathInfo.length() : "null"));
        
        if (pathInfo != null) {
            System.out.println("WorkoutController - pathInfo starts with /list: " + pathInfo.startsWith("/list"));
            System.out.println("WorkoutController - pathInfo equals /list: " + "/list".equals(pathInfo));
        }
        
        // Handle different path variations
        if (pathInfo != null && (pathInfo.equals("/list") || pathInfo.equals("/list/") || pathInfo.endsWith("/list"))) {
            HttpSession session = request.getSession();
            String userName = (String) session.getAttribute("userName");
            
            System.out.println("Workout list - User name from session: " + userName);
            
            if (userName != null) {
                // Get trainer ID by name
                int trainerId = TrainerUtil.getTrainerIdByName(userName);
                
                System.out.println("Workout list - Found trainer ID: " + trainerId);
                
                if (trainerId != -1) {
                    List<WorkoutDTO> workouts = workoutDAO.getWorkoutsByTrainer(trainerId);
                    
                    System.out.println("Workout list - Number of workouts found: " + (workouts != null ? workouts.size() : 0));
                    
                    request.setAttribute("workouts", workouts);
                    request.getRequestDispatcher("./trainer/view-workouts.jsp").forward(request, response);
                } else {
                    System.out.println("Workout list - Trainer not found for user: " + userName);
                    response.sendRedirect("trainer-dashboard.jsp?error=trainer_not_found");
                }
            } else {
                System.out.println("Workout list - No user name in session");
                response.sendRedirect("login.jsp");
            }
        } else if ("/user-view".equals(pathInfo)) {
            List<WorkoutDTO> workouts = workoutDAO.getAllWorkouts();
            request.setAttribute("workouts", workouts);
            request.getRequestDispatcher("./user/view-workouts.jsp").forward(request, response);
        } else {
            System.out.println("WorkoutController - Unmatched path: " + pathInfo);
            // Don't redirect to avoid loops - just show 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Workout path not found: " + pathInfo);
        }
    }
}
