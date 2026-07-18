<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fitnesstracker.dto.DietDTO" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Diet Plans - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="user-dashboard.jsp">
                <i class="fas fa-dumbbell me-2"></i>Fitness Tracker
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    Welcome, <%= session.getAttribute("userName") %>
                </span>
                <a class="nav-link" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>All Diet Plans</h2>
            <a href="user-dashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h5>Available Diet Plans</h5>
            </div>
            <div class="card-body">
                <%
                    List<DietDTO> diets = (List<DietDTO>) request.getAttribute("diets");
                    System.out.println("Diet User View JSP - Diets: " + diets);
                    System.out.println("Diet User View JSP - Size: " + (diets != null ? diets.size() : 0));
                    
                    if (diets == null || diets.isEmpty()) {
                %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        No diet plans available at the moment. Please check back later!
                    </div>
                <%
                    } else {
                %>
                    <div class="row">
                        <%
                            for (DietDTO diet : diets) {
                        %>
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <i class="fas fa-utensils me-2 text-success"></i>
                                        <%= diet.getMealName() %>
                                    </h5>
                                    <div class="card-text">
                                        <div class="row text-center">
                                            <div class="col-3">
                                                <div class="badge bg-primary">
                                                    <%= diet.getCalories() %><br>
                                                    <small>Cal</small>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="badge bg-danger">
                                                    <%= diet.getProtein() %><br>
                                                    <small>Prot</small>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="badge bg-warning">
                                                    <%= diet.getCarbs() %><br>
                                                    <small>Carbs</small>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="badge bg-info">
                                                    <%= diet.getFats() %><br>
                                                    <small>Fats</small>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mt-3"><strong>Trainer ID:</strong> <%= diet.getTrainerId() %></p>
                                    </div>
                                    <div class="d-grid">
                                        <button class="btn btn-success" onclick="viewMealDetails(<%= diet.getDietId() %>)">
                                            <i class="fas fa-eye me-2"></i>View Details
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="mt-3">
            <div class="alert alert-info">
                <h6><i class="fas fa-info-circle me-2"></i>Nutrition Information</h6>
                <p class="mb-0">These diet plans are designed by our certified nutritionists. 
                Each plan provides balanced macronutrients for optimal fitness results.</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewMealDetails(dietId) {
            alert('Viewing detailed meal information for Diet ID: ' + dietId + '\n\nThis feature will show complete nutritional information, meal timing, and preparation instructions.');
        }
    </script>
</body>
</html>
