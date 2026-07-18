<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fitnesstracker.dto.WorkoutDTO" %>

<%
if (session.getAttribute("user") == null) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>

<head>

<title>All Workouts - Fitness Tracker</title>

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
linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),
url("https://images.unsplash.com/photo-1599058917212-d750089bc07e");

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

/* GLASS CARD */

.glass-card{

background:rgba(255,255,255,0.12);

backdrop-filter:blur(15px);

border-radius:15px;

box-shadow:0 10px 30px rgba(0,0,0,0.4);

}

/* WORKOUT CARD */

.workout-card{

background:rgba(255,255,255,0.1);

border-radius:15px;

backdrop-filter:blur(15px);

box-shadow:0 8px 20px rgba(0,0,0,0.3);

transition:0.3s;

}

.workout-card:hover{

transform:translateY(-5px);

}

.btn-theme{

background:linear-gradient(45deg,#0d6efd,#4facfe);

border:none;

font-weight:bold;

color:white;

}

.btn-theme:hover{

transform:translateY(-2px);

box-shadow:0 8px 20px rgba(0,0,0,0.4);

background:linear-gradient(45deg,#0b5ed7,#3ea0ff);

}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container-fluid">

<a class="navbar-brand" href="user-dashboard.jsp">

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

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2><i class="fas fa-dumbbell me-2"></i>All Workout Programs</h2>

<a href="user-dashboard.jsp" class="btn btn-secondary">

<i class="fas fa-arrow-left me-2"></i>
Back to Dashboard

</a>

</div>

<div class="glass-card p-4">

<h5 class="mb-4">Available Workout Programs</h5>

<%

List<WorkoutDTO> workouts = (List<WorkoutDTO>) request.getAttribute("workouts");

if (workouts == null || workouts.isEmpty()) {

%>

<div class="alert alert-info">

<i class="fas fa-info-circle me-2"></i>

No workout programs available at the moment. Please check back later!

</div>

<%

} else {

%>

<div class="row">

<%

for (WorkoutDTO workout : workouts) {

%>

<div class="col-md-6 col-lg-4 mb-4">

<div class="workout-card p-4 h-100">

<h5>

<i class="fas fa-dumbbell text-warning me-2"></i>

<%= workout.getExerciseName() %>

</h5>

<hr>

<p><strong>Sets:</strong> <%= workout.getSets() %></p>

<p><strong>Reps:</strong> <%= workout.getReps() %></p>

<p><strong>Duration:</strong> <%= workout.getDuration() %> minutes</p>

<p><strong>Trainer ID:</strong> <%= workout.getTrainerId() %></p>

<div class="d-grid mt-3">

<button class="btn btn-theme"

onclick="startWorkout(<%= workout.getWorkoutId() %>)">

<i class="fas fa-play me-2"></i>

Start Workout

</button>

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

<div class="mt-4">

<div class="alert alert-info">

<h6>

<i class="fas fa-info-circle me-2"></i>

Workout Information

</h6>

<p class="mb-0">

These workout programs are designed by our certified trainers.
Click "Start Workout" to begin your training session.

</p>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

function startWorkout(workoutId){

const form = document.createElement('form');

form.method='POST';

form.action='start-workout';

form.style.display='none';

const workoutIdInput=document.createElement('input');

workoutIdInput.type='hidden';

workoutIdInput.name='workoutId';

workoutIdInput.value=workoutId;

form.appendChild(workoutIdInput);

document.body.appendChild(form);

form.submit();

}

</script>

</body>

</html>
