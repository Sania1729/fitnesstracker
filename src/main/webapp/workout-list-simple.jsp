<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fitnesstracker.dto.WorkoutDTO" %>

<%
if (session.getAttribute("user") == null || !"trainer".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>

<head>

<title>My Workouts - Fitness Tracker</title>

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
url("https://images.unsplash.com/photo-1558611848-73f7eb4001ab");

background-size:cover;
background-position:center;

min-height:100vh;

color:white;

}

/* GLASS CARD */

.glass-card{

background:rgba(255,255,255,0.12);

backdrop-filter:blur(15px);

border-radius:15px;

box-shadow:0 10px 30px rgba(0,0,0,0.4);

}

/* TABLE */

.table{

color:white;

}

.table thead{

background:rgba(255,255,255,0.2);

}

.table-striped>tbody>tr:nth-of-type(odd){

background:rgba(255,255,255,0.05);

}

/* BUTTONS */

.btn-theme{

background:linear-gradient(45deg,#ff7e5f,#feb47b);

border:none;

font-weight:bold;

}

.btn-theme:hover{

transform:translateY(-2px);

box-shadow:0 8px 20px rgba(0,0,0,0.4);

}

/* MODAL */

.modal-content{

background:#1e1e1e;

color:white;

border-radius:10px;

}

.form-control{

background:#2c2c2c;

border:none;

color:white;

}

.form-control:focus{

background:#2c2c2c;

color:white;

box-shadow:none;

}

</style>

</head>

<body>

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2><i class="fas fa-dumbbell me-2"></i>My Workout Programs</h2>

<a href="trainer-dashboard.jsp" class="btn btn-secondary">

<i class="fas fa-arrow-left me-2"></i>
Back to Dashboard

</a>

</div>

<div class="glass-card p-4">

<h5 class="mb-3">Workout List</h5>

<%

List<WorkoutDTO> workouts = (List<WorkoutDTO>) request.getAttribute("workouts");

if (workouts == null || workouts.isEmpty()) {

%>

<div class="alert alert-info">

<i class="fas fa-info-circle me-2"></i>

No workout programs found. Start by adding your first workout!

</div>

<%

} else {

%>

<table class="table table-striped table-hover">

<thead>

<tr>

<th>Exercise Name</th>

<th>Sets</th>

<th>Reps</th>

<th>Duration (min)</th>

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

</tr>

<%

}

%>

</tbody>

</table>

<%

}

%>

</div>

<div class="mt-4">

<button class="btn btn-theme"

onclick="showAddWorkoutModal()">

<i class="fas fa-plus me-2"></i>

Add New Workout

</button>

</div>

</div>

<!-- ADD WORKOUT MODAL -->

<div class="modal fade" id="addWorkoutModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5>Add New Workout</h5>

<button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>

</div>

<form action="add-workout" method="post">

<div class="modal-body">

<div class="mb-3">

<label>Exercise Name</label>

<input type="text" class="form-control" name="exerciseName" required>

</div>

<div class="mb-3">

<label>Sets</label>

<input type="number" class="form-control" name="sets" required>

</div>

<div class="mb-3">

<label>Reps</label>

<input type="number" class="form-control" name="reps" required>

</div>

<div class="mb-3">

<label>Duration (minutes)</label>

<input type="number" class="form-control" name="duration" required>

</div>

</div>

<div class="modal-footer">

<button type="button" class="btn btn-secondary"

data-bs-dismiss="modal">

Cancel

</button>

<button type="submit" class="btn btn-theme">

Add Workout

</button>

</div>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

function showAddWorkoutModal(){

var modal = new bootstrap.Modal(document.getElementById('addWorkoutModal'));

modal.show();

}

</script>

</body>

</html>
