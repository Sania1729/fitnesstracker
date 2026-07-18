<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("user") == null || !"user".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Dashboard - Fitness Tracker</title>

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
linear-gradient(rgba(0,0,0,0.80),rgba(0,0,0,0.80)),
url("https://images.unsplash.com/photo-1571902943202-507ec2618e8f");

background-size:cover;
background-position:center;

min-height:100vh;
color:white;

}

/* NAVBAR */

.navbar{

background:rgba(0,0,0,0.85);
backdrop-filter:blur(10px);

}

/* SIDEBAR */

.sidebar{

background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);

min-height:100vh;

border-right:1px solid rgba(255,255,255,0.2);

}

.sidebar .nav-link{

color:white;
margin:10px;
border-radius:10px;
transition:0.3s;

}

.sidebar .nav-link:hover{

background:rgba(255,255,255,0.2);

}

.sidebar .active{

background:linear-gradient(45deg,#f1c40f,#d4af37);
color:black;

}

/* GLASS CARD */

.glass-card{

background:rgba(255,255,255,0.12);
backdrop-filter:blur(18px);

border-radius:18px;

box-shadow:0 10px 25px rgba(0,0,0,0.5);

transition:0.3s;

}

.glass-card:hover{

transform:translateY(-5px);

}

/* BUTTON */

.btn-theme{

background:linear-gradient(45deg,#f1c40f,#d4af37);
border:none;
font-weight:bold;
color:black;

}

.btn-theme:hover{

transform:translateY(-2px);
box-shadow:0 10px 20px rgba(0,0,0,0.5);

}

/* SCHEDULE */

.list-group-item{

background:rgba(255,255,255,0.08);

color:white;

border:none;

margin-bottom:12px;

border-radius:10px;

}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container-fluid">

<a class="navbar-brand fw-bold">

<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker

</a>

<div class="ms-auto">

<span class="navbar-text me-3">

Welcome, <%= session.getAttribute("userName") %>

</span>

<a class="btn btn-outline-light btn-sm" href="logout.jsp">

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

<a class="nav-link active" href="user-dashboard.jsp">

<i class="fas fa-tachometer-alt me-2"></i>
Dashboard

</a>

</li>

<li class="nav-item">

<a class="nav-link" href="workout-user-view">

<i class="fas fa-dumbbell me-2"></i>
Workout Plans

</a>

</li>

<li class="nav-item">

<a class="nav-link" href="diet-user-view">

<i class="fas fa-apple-alt me-2"></i>
Diet Plans

</a>

</li>

</ul>

</nav>

<!-- MAIN CONTENT -->

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

<div class="pt-3 pb-2 mb-4">

<h2 class="fw-bold">My Fitness Dashboard</h2>

</div>

<!-- QUICK ACTIONS -->

<div class="row mb-4">

<div class="col-md-6 mb-3">

<a href="workout-user-view" class="btn btn-theme w-100">

<i class="fas fa-dumbbell me-2"></i>
View Workout Plans

</a>

</div>

<div class="col-md-6 mb-3">

<a href="diet-user-view" class="btn btn-success w-100">

<i class="fas fa-apple-alt me-2"></i>
View Diet Plans

</a>

</div>

</div>

<!-- WELCOME CARD -->

<div class="glass-card p-4 mb-4">

<h4 class="mb-4">Welcome to Your Fitness Journey</h4>

<div class="row text-center">

<div class="col-md-4">

<i class="fas fa-dumbbell fa-3x text-warning mb-3"></i>

<h5>Workout Programs</h5>

<p>Access personalized workout plans designed by expert trainers</p>

</div>

<div class="col-md-4">

<i class="fas fa-apple-alt fa-3x text-success mb-3"></i>

<h5>Nutrition Plans</h5>

<p>Follow diet plans tailored to your fitness goals</p>

</div>

<div class="col-md-4">

<i class="fas fa-chart-line fa-3x text-info mb-3"></i>

<h5>Track Progress</h5>

<p>Monitor your fitness progress and achievements</p>

</div>

</div>

<div class="alert alert-info mt-4">

<i class="fas fa-info-circle me-2"></i>

<strong>Getting Started:</strong>
Explore workouts and diet plans to begin your transformation.

</div>

</div>

<!-- DAILY SCHEDULE -->

<div class="glass-card p-4">

<h5 class="mb-3">Today's Fitness Schedule</h5>

<div class="list-group">

<div class="list-group-item">

<div class="d-flex justify-content-between">

<h6>Morning Workout</h6>

<small>6:00 AM - 7:00 AM</small>

</div>

<p>Cardio and Strength Training</p>

</div>

<div class="list-group-item">

<div class="d-flex justify-content-between">

<h6>Healthy Breakfast</h6>

<small>7:30 AM</small>

</div>

<p>High protein meal with oats and fruits</p>

</div>

<div class="list-group-item">

<div class="d-flex justify-content-between">

<h6>Evening Yoga</h6>

<small>5:00 PM - 6:00 PM</small>

</div>

<p>Relaxation and flexibility session</p>

</div>

</div>

</div>

</main>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>