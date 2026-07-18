package com.fitnesstracker.controller;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.dao.WorkoutDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-workout")
public class AddWorkoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WorkoutDAO workoutDAO;
    
    public void init() {
        workoutDAO = new WorkoutDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        
        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get trainer ID by name
        int trainerId = TrainerUtil.getTrainerIdByName(userName);
        
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
            response.sendRedirect("trainer-dashboard.jsp?message=workout_added");
        } else {
            response.sendRedirect("trainer-dashboard.jsp?error=workout_failed");
        }
    }
}
