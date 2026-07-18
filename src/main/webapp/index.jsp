<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Fitness Tracker - Your Complete Fitness Solution</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>

*{
font-family:'Segoe UI',sans-serif;
}

/* NAVBAR */

.navbar{
background:rgba(0,0,0,0.8);
backdrop-filter:blur(10px);
}

/* HERO SECTION */

.hero-section{

background:
linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
url("https://images.unsplash.com/photo-1517836357463-d25dfeac3438");

background-size:cover;
background-position:center;

color:white;
padding:120px 0;
text-align:center;

}

/* CTA BUTTON */

.btn-cta{

background:linear-gradient(45deg,#0d6efd,#4facfe);
border:none;
padding:15px 40px;
border-radius:50px;
color:white;
font-weight:bold;
text-decoration:none;
display:inline-block;
transition:0.3s;

}

.btn-cta:hover{

transform:translateY(-3px);
box-shadow:0 10px 20px rgba(0,0,0,0.4);
color:white;

}

/* FEATURE CARDS */

.feature-card{

border:none;
border-radius:15px;

box-shadow:0 10px 25px rgba(0,0,0,0.08);

transition:0.3s;

}

.feature-card:hover{

transform:translateY(-10px);
box-shadow:0 15px 35px rgba(0,0,0,0.15);

}

/* ICON CIRCLE */

.icon-circle{

width:80px;
height:80px;

border-radius:50%;

display:flex;
align-items:center;
justify-content:center;

margin:auto;
margin-bottom:15px;

background:#f1f4ff;

}

/* FOOTER */

footer{
background:#111;
}

</style>

</head>

<body>

<!-- NAVIGATION -->

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container">

<a class="navbar-brand fw-bold" href="#">
<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker
</a>

<div class="navbar-nav ms-auto">

<a class="nav-link" href="#features">Features</a>
<a class="nav-link" href="#about">About</a>

<a href="login.jsp" class="btn btn-outline-light ms-3">
Login
</a>

</div>

</div>

</nav>

<!-- HERO SECTION -->

<section class="hero-section">

<div class="container">

<h1 class="display-4 fw-bold mb-4">

Transform Your Fitness Journey

</h1>

<p class="lead mb-5">

Complete fitness management with personalized workouts, diet plans,
and expert trainer guidance.

</p>

<div class="d-flex justify-content-center gap-3">

<a href="register.jsp" class="btn-cta">
<i class="fas fa-rocket me-2"></i>
Get Started
</a>

<a href="login.jsp" class="btn btn-outline-light btn-lg">
<i class="fas fa-sign-in-alt me-2"></i>
Login
</a>

</div>

</div>

</section>

<!-- FEATURES -->

<section id="features" class="py-5">

<div class="container">

<div class="text-center mb-5">

<h2 class="display-5 fw-bold">
Powerful Features
</h2>

<p class="lead text-muted">
Everything you need to achieve your fitness goals
</p>

</div>

<div class="row g-4">

<!-- FEATURE 1 -->

<div class="col-md-4">

<div class="card feature-card h-100">

<div class="card-body text-center p-4">

<div class="icon-circle">
<i class="fas fa-dumbbell fa-2x text-primary"></i>
</div>

<h4>Personalized Workouts</h4>

<p class="text-muted">
Custom workout plans designed by expert trainers.
</p>

</div>

</div>

</div>

<!-- FEATURE 2 -->

<div class="col-md-4">

<div class="card feature-card h-100">

<div class="card-body text-center p-4">

<div class="icon-circle">
<i class="fas fa-apple-alt fa-2x text-success"></i>
</div>

<h4>Nutrition Tracking</h4>

<p class="text-muted">
Comprehensive diet plans with calorie tracking.
</p>

</div>

</div>

</div>

<!-- FEATURE 3 -->

<div class="col-md-4">

<div class="card feature-card h-100">

<div class="card-body text-center p-4">

<div class="icon-circle">
<i class="fas fa-user-tie fa-2x text-info"></i>
</div>

<h4>Expert Trainers</h4>

<p class="text-muted">
Connect with certified fitness professionals.
</p>

</div>

</div>

</div>

</div>

</div>

</section>

<!-- FOOTER -->

<footer class="text-white py-4">

<div class="container">

<div class="row">

<div class="col-md-6">

<h5>
<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker
</h5>

<p class="text-muted">
Your complete fitness solution.
</p>

</div>

<div class="col-md-6 text-md-end">

<h6>Quick Links</h6>

<a href="login.jsp" class="text-white me-3">
Login
</a>

<a href="register.jsp" class="text-white">
Register
</a>

</div>

</div>

<hr class="bg-secondary">

<div class="text-center">

<p class="mb-0">
© 2024 Fitness Tracker. All rights reserved.
</p>

</div>

</div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>