<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fitnesstracker.dto.WorkoutDTO" %>
<%
    if (session.getAttribute("user") == null || !"trainer".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Workouts - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="../trainer-dashboard.jsp">
                <i class="fas fa-dumbbell me-2"></i>Fitness Tracker
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Welcome, <%= session.getAttribute("userName") %>
                </span>
                <a class="nav-link" href="../logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>My Workout Programs</h2>
            <a href="../trainer-dashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h5>Workout List</h5>
            </div>
            <div class="card-body">
                <%
                    List<WorkoutDTO> workouts = (List<WorkoutDTO>) request.getAttribute("workouts");
                    System.out.println("JSP - Workouts attribute received: " + workouts);
                    System.out.println("JSP - Workouts size: " + (workouts != null ? workouts.size() : 0));
                    
                    if (workouts == null || workouts.isEmpty()) {
                %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        No workout programs found. Start by adding your first workout!
                    </div>
                <%
                    } else {
                %>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Exercise Name</th>
                                    <th>Sets</th>
                                    <th>Reps</th>
                                    <th>Duration (min)</th>
                                    <th>Created Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (WorkoutDTO workout : workouts) {
                                %>
                                <tr>
                                    <td><%= workout.getExerciseName() %></td>
                                    <td><%= workout.getSets() %></td>
                                    <td><%= workout.getReps() %></td>
                                    <td><%= workout.getDuration() %></td>
                                    <td><%= workout.getCreatedAt() %></td>
                                    <td>
                                        <button class="btn btn-sm btn-primary" onclick="editWorkout(<%= workout.getWorkoutId() %>)">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteWorkout(<%= workout.getWorkoutId() %>)">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="mt-3">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addWorkoutModal">
                <i class="fas fa-plus me-2"></i>Add New Workout
            </button>
        </div>
    </div>

    <!-- Add Workout Modal -->
    <div class="modal fade" id="addWorkoutModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Workout</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="add-workout" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Exercise Name</label>
                            <input type="text" class="form-control" name="exerciseName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Sets</label>
                            <input type="number" class="form-control" name="sets" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Reps</label>
                            <input type="number" class="form-control" name="reps" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Duration (minutes)</label>
                            <input type="number" class="form-control" name="duration" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Workout</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editWorkout(id) {
            alert('Edit functionality coming soon! Workout ID: ' + id);
        }

        function deleteWorkout(id) {
            if (confirm('Are you sure you want to delete this workout?')) {
                window.location.href = '../workout/delete?id=' + id;
            }
        }
    </script>
</body>
</html>
