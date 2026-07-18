<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.fitnesstracker.dto.WorkoutDTO"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%

if(session.getAttribute("user")==null){
response.sendRedirect("login.jsp");
return;
}

WorkoutDTO currentWorkout = (WorkoutDTO)session.getAttribute("currentWorkout");
String workoutSessionId = (String)session.getAttribute("workoutSessionId");
LocalDateTime startTime = (LocalDateTime)session.getAttribute("workoutStartTime");

%>

<!DOCTYPE html>

<html>
<head>

<title>Workout Tracking</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

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
linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
url("https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=1920&q=80");

background-size:cover;
background-position:center;
background-repeat:no-repeat;
background-attachment:fixed;

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
padding:30px;
}

/* TIMER */

.timer-display{
font-size:60px;
font-weight:bold;
color:#ffc107;
font-family:monospace;
margin-top:10px;
}

/* METRIC CARDS */

.metric-card{
background:rgba(255,255,255,0.15);
border-radius:12px;
padding:20px;
text-align:center;
height:140px;
display:flex;
flex-direction:column;
justify-content:center;
align-items:center;
}

.metric-icon{
font-size:24px;
margin-bottom:5px;
}

.metric-value{
font-size:28px;
font-weight:bold;
}

.metric-label{
font-size:14px;
}

/* BUTTONS */

.btn-stop{
background:#dc3545;
border:none;
padding:12px 40px;
font-size:18px;
border-radius:30px;
color:white;
}

.btn-pause{
background:#ffc107;
border:none;
padding:12px 40px;
font-size:18px;
border-radius:30px;
}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container-fluid">

<a class="navbar-brand" href="user-dashboard.jsp">

<i class="fas fa-dumbbell"></i>
Fitness Tracker

</a>

<div class="ms-auto">

<span class="text-white me-3">

Welcome <%=session.getAttribute("userName")%>

</span>

<a href="logout.jsp" class="btn btn-outline-light btn-sm">

Logout

</a>

</div>

</div>

</nav>

<div class="container mt-5">

<div class="row g-4">

<!-- WORKOUT SECTION -->

<div class="col-lg-8">

<div class="glass-card text-center">

<h3>

<i class="fas fa-dumbbell me-2"></i>

<%

if(currentWorkout!=null){

out.print(currentWorkout.getExerciseName());

}else{

out.print("No Active Workout");

}

%>

</h3>

<% if(currentWorkout!=null){ %>

<div class="timer-display" id="timer">00:00:00</div>

<p class="text-light">Workout Timer</p>

<div class="row mt-4 g-3">

<div class="col-md-3">

<div class="metric-card">

<i class="fas fa-repeat metric-icon text-primary"></i>

<div class="metric-value">

<%=currentWorkout.getSets()%>

</div>

<div class="metric-label">

Sets

</div>

</div>

</div>

<div class="col-md-3">

<div class="metric-card">

<i class="fas fa-sync metric-icon text-success"></i>

<div class="metric-value">

<%=currentWorkout.getReps()%>

</div>

<div class="metric-label">

Reps

</div>

</div>

</div>

<div class="col-md-3">

<div class="metric-card">

<i class="fas fa-clock metric-icon text-info"></i>

<div class="metric-value">

<%=currentWorkout.getDuration()%>

</div>

<div class="metric-label">

Minutes

</div>

</div>

</div>

<div class="col-md-3">

<div class="metric-card">

<i class="fas fa-fire metric-icon text-danger"></i>

<div class="metric-value">

<%=currentWorkout.getDuration()*8%>

</div>

<div class="metric-label">

Calories

</div>

</div>

</div>

</div>

<div class="mt-4">

<button class="btn btn-pause me-3"
id="pauseBtn"
onclick="togglePause()">

<i class="fas fa-pause"></i>
Pause

</button>

<button class="btn btn-stop"
onclick="stopWorkout()">

<i class="fas fa-stop"></i>
Stop

</button>

</div>

<% }else{ %>

<div class="alert alert-warning mt-4">

No workout started.

</div>

<a href="workout-user-view"
class="btn btn-primary">

Start Workout

</a>

<% } %>

</div>

</div>

<!-- STATS PANEL -->

<div class="col-lg-4">

<div class="glass-card">

<h5 class="mb-4">

<i class="fas fa-chart-line"></i>
Workout Stats

</h5>

<p><b>Session ID :</b>
<%=workoutSessionId!=null?workoutSessionId:"N/A"%>
</p>

<% if(startTime!=null){ %>

<p>

<b>Start Time :</b>

<%=startTime.format(DateTimeFormatter.ofPattern("MMM dd yyyy HH:mm:ss"))%>

</p>

<p>

<b>Elapsed Time :</b>

<span id="elapsed-time">00:00:00</span>

</p>

<% } %>

<p>

<b>Calories Burned :</b>

<span class="text-success">

<%=currentWorkout!=null?currentWorkout.getDuration()*8:0%>

</span> kcal

</p>

<a href="workout-user-view"
class="btn btn-secondary w-100 mt-3">

Back to Workouts

</a>

</div>

</div>

</div>

</div>

<script>

let timerInterval;
let isPaused=false;

let startTime=
<%=startTime!=null?"'"+startTime.toString()+"'":"null"%>;

function startTimer(){

if(!startTime) return;

timerInterval=setInterval(function(){

if(!isPaused){

const now=new Date();
const start=new Date(startTime);

const elapsed=Math.floor((now-start)/1000);

const hours=Math.floor(elapsed/3600);
const minutes=Math.floor((elapsed%3600)/60);
const seconds=elapsed%60;

document.getElementById("timer").textContent=
String(hours).padStart(2,'0')+":"
+String(minutes).padStart(2,'0')+":"
+String(seconds).padStart(2,'0');

document.getElementById("elapsed-time").textContent=
String(hours).padStart(2,'0')+":"
+String(minutes).padStart(2,'0')+":"
+String(seconds).padStart(2,'0');

}

},1000);

}

function togglePause(){

if(isPaused){

isPaused=false;

document.getElementById("pauseBtn").innerHTML=
"<i class='fas fa-pause'></i> Pause";

startTimer();

}else{

isPaused=true;

clearInterval(timerInterval);

document.getElementById("pauseBtn").innerHTML=
"<i class='fas fa-play'></i> Resume";

}

}

function stopWorkout(){

if(confirm("Stop Workout?")){

clearInterval(timerInterval);

const now=new Date();
const start=new Date(startTime);

const seconds=Math.floor((now-start)/1000);
const minutes=Math.floor(seconds/60);

alert("Workout Completed! Duration: "+minutes+" minutes");

window.location.href=
"workout-complete.jsp?duration="+minutes+
"&calories="+(minutes*8);

}

}

<% if(currentWorkout!=null && startTime!=null){ %>

startTimer();

<% } %>

</script>

</body>
</html>
