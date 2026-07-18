<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dao.TrainerDAO, com.fitnesstracker.dto.UserDTO, com.fitnesstracker.dto.TrainerDTO" %>
<%
    UserDAO userDAO = new UserDAO();
    TrainerDAO trainerDAO = new TrainerDAO();
    
    String message = "";
    String error = "";
    
    if ("POST".equals(request.getMethod())) {
        String userId = request.getParameter("userId");
        
        try {
            // Get user details
            UserDTO user = userDAO.getUserById(Integer.parseInt(userId));
            
            if (user != null && "trainer".equals(user.getRole())) {
                // Check if trainer already exists
                boolean trainerExists = false;
                for (TrainerDTO trainer : trainerDAO.getAllTrainers()) {
                    if (trainer.getName().equals(user.getName())) {
                        trainerExists = true;
                        break;
                    }
                }
                
                if (!trainerExists) {
                    // Create trainer record
                    TrainerDTO trainer = new TrainerDTO();
                    trainer.setName(user.getName());
                    trainer.setSpecialization("General Fitness");
                    trainer.setExperience(0);
                    trainer.setPhone(user.getPhone());
                    
                    boolean created = trainerDAO.addTrainer(trainer);
                    if (created) {
                        message = "Trainer record created successfully for " + user.getName();
                    } else {
                        error = "Failed to create trainer record";
                    }
                } else {
                    error = "Trainer record already exists for " + user.getName();
                }
            } else {
                error = "User not found or not a trainer";
            }
        } catch (Exception e) {
            error = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Trainer Records - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Create Trainer Records</h2>
        <p>This page helps create trainer records for existing trainer users.</p>
        
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>
        
        <% if (!error.isEmpty()) { %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
        <% } %>
        
        <div class="card">
            <div class="card-header">
                <h5>Trainer Users Without Trainer Records</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (UserDTO user : userDAO.getAllUsers()) {
                                if ("trainer".equals(user.getRole())) {
                                    // Check if trainer record exists
                                    boolean trainerExists = false;
                                    for (TrainerDTO trainer : trainerDAO.getAllTrainers()) {
                                        if (trainer.getName().equals(user.getName())) {
                                            trainerExists = true;
                                            break;
                                        }
                                    }
                                    
                                    if (!trainerExists) {
                        %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPhone() %></td>
                            <td>
                                <form method="post" style="display: inline;">
                                    <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                    <button type="submit" class="btn btn-primary btn-sm">Create Trainer Record</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-header">
                <h5>All Trainer Records</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Trainer ID</th>
                            <th>Name</th>
                            <th>Specialization</th>
                            <th>Experience</th>
                            <th>Phone</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (TrainerDTO trainer : trainerDAO.getAllTrainers()) {
                        %>
                        <tr>
                            <td><%= trainer.getTrainerId() %></td>
                            <td><%= trainer.getName() %></td>
                            <td><%= trainer.getSpecialization() %></td>
                            <td><%= trainer.getExperience() %></td>
                            <td><%= trainer.getPhone() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="login.jsp" class="btn btn-secondary">Back to Login</a>
        </div>
    </div>
</body>
</html>
