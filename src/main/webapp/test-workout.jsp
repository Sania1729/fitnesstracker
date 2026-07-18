<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.WorkoutDAO, com.fitnesstracker.dao.TrainerDAO, java.util.List, com.fitnesstracker.dto.WorkoutDTO, com.fitnesstracker.dto.TrainerDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Workout Debug Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Workout Debug Test</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>Database Test Results</h5>
            </div>
            <div class="card-body">
                <h6>1. Testing Database Connection</h6>
                <%
                    try {
                        WorkoutDAO workoutDAO = new WorkoutDAO();
                        TrainerDAO trainerDAO = new TrainerDAO();
                        out.println("<div class='alert alert-success'>✅ Database connection successful</div>");
                        
                        out.println("<h6>2. Testing Trainers Table</h6>");
                        List<TrainerDTO> trainers = trainerDAO.getAllTrainers();
                        out.println("<div class='alert alert-info'>Found " + trainers.size() + " trainers in database</div>");
                        
                        for (TrainerDTO trainer : trainers) {
                            out.println("<div class='ms-3'>Trainer: " + trainer.getName() + " (ID: " + trainer.getTrainerId() + ")</div>");
                        }
                        
                        out.println("<h6>3. Testing Workout Table</h6>");
                        List<WorkoutDTO> allWorkouts = workoutDAO.getAllWorkouts();
                        out.println("<div class='alert alert-info'>Found " + allWorkouts.size() + " workouts in database</div>");
                        
                        for (WorkoutDTO workout : allWorkouts) {
                            out.println("<div class='ms-3'>Workout: " + workout.getExerciseName() + " (Trainer ID: " + workout.getTrainerId() + ")</div>");
                        }
                        
                        out.println("<h6>4. Testing Workout by Trainer</h6>");
                        if (!trainers.isEmpty()) {
                            out.println("<div class='alert alert-warning'>No trainers to test with</div>");
                        } else {
                            int firstTrainerId = trainers.get(0).getTrainerId();
                            List<WorkoutDTO> trainerWorkouts = workoutDAO.getWorkoutsByTrainer(firstTrainerId);
                            out.println("<div class='alert alert-info'>Trainer ID " + firstTrainerId + " has " + trainerWorkouts.size() + " workouts</div>");
                            
                            for (WorkoutDTO workout : trainerWorkouts) {
                                out.println("<div class='ms-3'>- " + workout.getExerciseName() + "</div>");
                            }
                        }
                        
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>❌ Error: " + e.getMessage() + "</div>");
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="trainer-dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
