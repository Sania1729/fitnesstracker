<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("user") == null || !"trainer".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Trainer Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

/* BACKGROUND */

body{

background:
linear-gradient(rgba(0,0,0,0.7),rgba(0,0,0,0.7)),
url("https://images.unsplash.com/photo-1534438327276-14e5300c3a48");

background-size:cover;
background-position:center;

min-height:100vh;
color:white;

}

/* NAVBAR */

.navbar{

background:rgba(0,0,0,0.8);
backdrop-filter:blur(10px);

}

/* SIDEBAR */

.sidebar{

background:rgba(255,255,255,0.1);
backdrop-filter:blur(15px);

min-height:100vh;

border-right:1px solid rgba(255,255,255,0.2);

}

.sidebar .nav-link{

color:white;
margin:10px;
border-radius:8px;
transition:0.3s;

}

.sidebar .nav-link:hover{

background:rgba(255,255,255,0.2);

}

.sidebar .nav-link.active{

background:linear-gradient(45deg,#0d6efd,#4facfe);

}

/* GLASS CARD */

.glass-card{

background:rgba(255,255,255,0.15);
backdrop-filter:blur(15px);

border-radius:15px;

box-shadow:0 10px 25px rgba(0,0,0,0.3);

color:white;

}

/* BUTTON THEME */

.btn-theme{

background:linear-gradient(45deg,#0d6efd,#4facfe);

border:none;
color:white;
font-weight:bold;
transition:0.3s;

}

.btn-theme:hover{

transform:translateY(-3px);

box-shadow:0 10px 25px rgba(0,0,0,0.5);

background:linear-gradient(45deg,#0b5ed7,#3ea0ff);

}

/* MODAL */

.modal-content{

background:#1e1e1e;
color:white;

border-radius:12px;

}

.form-control{

background:#2c2c2c;

border:none;

color:white;

}

.form-control:focus{

background:#2c2c2c;

color:white;

box-shadow:0 0 0 2px rgba(13,110,253,0.4);

}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container-fluid">

<a class="navbar-brand">

<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker

</a>

<div class="ms-auto">

<span class="navbar-text me-3">
Welcome, <%= session.getAttribute("userName") %>
</span>

<a class="nav-link d-inline text-white" href="logout.jsp">
Logout
</a>

</div>

</div>

</nav>

<div class="container-fluid mt-4">

<div class="row">

<!-- SIDEBAR -->

<nav class="col-md-3 col-lg-2 sidebar pt-3">

<ul class="nav flex-column">

<li class="nav-item">

<a class="nav-link active" href="trainer-dashboard.jsp">

<i class="fas fa-tachometer-alt me-2"></i>
Dashboard

</a>

</li>

<li class="nav-item">

<a href="workout-list" class="nav-link">

<i class="fas fa-dumbbell me-2"></i>
View Workouts

</a>

</li>

<li class="nav-item">

<a href="diet-list" class="nav-link">

<i class="fas fa-apple-alt me-2"></i>
Diet Plans

</a>

</li>

</ul>

</nav>

<!-- MAIN CONTENT -->

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

<div class="pt-3 pb-2 mb-3">

<h2>Trainer Dashboard</h2>

</div>

<% if (request.getParameter("message") != null) { %>

<div class="alert alert-success">

<i class="fas fa-check-circle me-2"></i>
Operation successful!

</div>

<% } %>

<% if (request.getParameter("error") != null) { %>

<div class="alert alert-danger">

<i class="fas fa-exclamation-circle me-2"></i>
Operation failed. Please try again.

</div>

<% } %>

<div class="row mb-4">

<div class="col-md-6 mb-3">

<button class="btn btn-theme w-100"
data-bs-toggle="modal"
data-bs-target="#addWorkoutModal">

<i class="fas fa-plus me-2"></i>
Add Workout

</button>

</div>

<div class="col-md-6 mb-3">

<button class="btn btn-theme w-100"
data-bs-toggle="modal"
data-bs-target="#addDietModal">

<i class="fas fa-plus me-2"></i>
Add Diet Plan

</button>

</div>

</div>

<!-- STATS -->

<div class="glass-card p-4">

<h5 class="mb-4">Quick Stats</h5>

<div class="row text-center">

<div class="col-md-4">

<i class="fas fa-dumbbell fa-3x text-primary mb-2"></i>

<h4>Workout Plans</h4>

<p>Create and manage workout routines</p>

</div>

<div class="col-md-4">

<i class="fas fa-apple-alt fa-3x text-success mb-2"></i>

<h4>Diet Plans</h4>

<p>Design nutrition programs</p>

</div>

<div class="col-md-4">

<i class="fas fa-users fa-3x text-info mb-2"></i>

<h4>Clients</h4>

<p>Track client progress</p>

</div>

</div>

</div>

</main>

</div>

</div>

<!-- ADD WORKOUT MODAL -->

<div class="modal fade" id="addWorkoutModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5>Add Workout</h5>

<button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>

</div>

<form action="add-workout" method="post">

<div class="modal-body">

<div class="mb-3">
<label>Exercise Name</label>
<input type="text" name="exerciseName" class="form-control" required>
</div>

<div class="mb-3">
<label>Sets</label>
<input type="number" name="sets" class="form-control" required>
</div>

<div class="mb-3">
<label>Reps</label>
<input type="number" name="reps" class="form-control" required>
</div>

<div class="mb-3">
<label>Duration (minutes)</label>
<input type="number" name="duration" class="form-control" required>
</div>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">
Cancel
</button>

<button class="btn btn-theme">
Add Workout
</button>

</div>

</form>

</div>

</div>

</div>

<!-- ADD DIET MODAL -->

<div class="modal fade" id="addDietModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5>Add Diet Plan</h5>

<button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>

</div>

<form action="add-diet" method="post">

<div class="modal-body">

<div class="mb-3">
<label>Meal Name</label>
<input type="text" name="mealName" class="form-control" required>
</div>

<div class="mb-3">
<label>Calories</label>
<input type="number" name="calories" class="form-control" required>
</div>

<div class="mb-3">
<label>Protein</label>
<input type="number" step="0.1" name="protein" class="form-control" required>
</div>

<div class="mb-3">
<label>Carbs</label>
<input type="number" step="0.1" name="carbs" class="form-control" required>
</div>

<div class="mb-3">
<label>Fats</label>
<input type="number" step="0.1" name="fats" class="form-control" required>
</div>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">
Cancel
</button>

<button class="btn btn-theme">
Add Diet
</button>

</div>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>