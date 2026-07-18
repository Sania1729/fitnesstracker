<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("user") == null || !"user".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}


session.removeAttribute("currentWorkout");
session.removeAttribute("workoutSessionId");
session.removeAttribute("workoutStartTime");


%>

<!DOCTYPE html>

<html>
<head>

<title>Workout Complete - Fitness Tracker</title>

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
linear-gradient(rgba(0,0,0,0.8),rgba(0,0,0,0.8)),
url("https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b");

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

padding:40px;

}

/* TROPHY */

.trophy{

font-size:80px;

color:#FFD700;

animation:bounce 2s infinite;

}

@keyframes bounce{

0%,100%{transform:translateY(0);}
50%{transform:translateY(-10px);}

}

/* STATS CARDS */

.stat-card{

background:rgba(255,255,255,0.15);

border-radius:12px;

padding:20px;

text-align:center;

}

/* BUTTON */

.btn-continue{

background:linear-gradient(45deg,#28a745,#20c997);

border:none;

color:white;

padding:12px 30px;

font-size:18px;

border-radius:30px;

transition:0.3s;

}

.btn-continue:hover{

transform:scale(1.05);

box-shadow:0 10px 25px rgba(0,0,0,0.4);

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container-fluid">

<a class="navbar-brand" href="user-dashboard.jsp">

<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker

</a>

<div class="ms-auto">

<span class="text-white me-3">

Welcome, <%= session.getAttribute("userName") %>

</span>

<a class="nav-link d-inline text-white" href="logout.jsp">

Logout

</a>

</div>

</div>

</nav>

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-md-8">

<div class="glass-card text-center">

<div class="trophy mb-3">

<i class="fas fa-trophy"></i>

</div>

<h2 class="mb-3">

Workout Complete! 🎉

</h2>

<p class="lead">

Congratulations on completing your workout!

</p>

<div class="row mt-4 g-3">

<div class="col-md-6">

<div class="stat-card">

<h5>

<i class="fas fa-clock me-2 text-warning"></i>
Duration

</h5>

<h3 class="text-warning">

<%

String durationStr = request.getParameter("duration");

if(durationStr!=null){

out.print(durationStr+" minutes");

}else{

out.print("N/A");

}

%>

</h3>

</div>

</div>

<div class="col-md-6">

<div class="stat-card">

<h5>

<i class="fas fa-fire me-2 text-danger"></i>
Calories Burned

</h5>

<h3 class="text-danger">

<%

String caloriesStr = request.getParameter("calories");

if(caloriesStr!=null){

out.print(caloriesStr+" kcal");

}else{

out.print("N/A");

}

%>

</h3>

</div>

</div>

</div>

<div class="alert alert-info mt-4">

<h6>

<i class="fas fa-chart-line me-2"></i>
Workout Tips

</h6>

<ul class="mt-2">

<li><b>Consistency</b> helps achieve fitness goals</li>

<li><b>Track progress</b> to stay motivated</li>

<li><b>Stay hydrated</b> and maintain proper form</li>

</ul>

</div>

<div class="mt-4">

<a href="workout-user-view" class="btn btn-continue btn-lg">

<i class="fas fa-redo me-2"></i>

Start Another Workout

</a>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
