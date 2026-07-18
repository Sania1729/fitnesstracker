<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dao.TrainerDAO" %>

<%
if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard - Fitness Tracker</title>

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
url("https://images.unsplash.com/photo-1583454110551-21f2fa2afe61");

background-size:cover;
background-position:center;
background-attachment:fixed;
min-height:100vh;
color:white;
}

/* NAVBAR */

.navbar{
background:rgba(0,0,0,0.9);
backdrop-filter:blur(10px);
}

/* SIDEBAR */

.sidebar{
background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);
min-height:100vh;
padding-top:20px;
}

.sidebar .nav-link{
color:white;
font-weight:500;
padding:12px 15px;
border-radius:8px;
transition:0.3s;
}

.sidebar .nav-link:hover{
background:rgba(255,255,255,0.15);
padding-left:20px;
}

/* CARDS */

.card{
background:rgba(255,255,255,0.12);
backdrop-filter:blur(15px);
border:none;
border-radius:15px;
box-shadow:0 8px 25px rgba(0,0,0,0.5);
color:white;
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

/* ICON ANIMATION */

.dashboard-icon{
font-size:35px;
margin-top:10px;
color:#4dabf7;
animation:float 2s infinite;
}

@keyframes float{
0%,100%{transform:translateY(0);}
50%{transform:translateY(-6px);}
}

/* BLUE BUTTON */

.btn-gradient{

background:linear-gradient(45deg,#0d6efd,#4dabf7);

border:none;

color:white;

font-weight:bold;

border-radius:25px;

padding:10px;

transition:0.3s;

}

.btn-gradient:hover{

background:linear-gradient(45deg,#084298,#1c6ed5);

transform:scale(1.05);

box-shadow:0 10px 25px rgba(0,0,0,0.5);

}

/* MODAL */

.modal-content{
background:rgba(0,0,0,0.9);
color:white;
border-radius:15px;
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
<i class="fas fa-sign-out-alt"></i> Logout
</a>

</div>

</div>

</nav>

<div class="container-fluid mt-4">

<div class="row">

<!-- SIDEBAR -->

<nav class="col-md-3 col-lg-2 d-md-block sidebar">

<ul class="nav flex-column">

<li class="nav-item">
<a class="nav-link active" href="admin-dashboard.jsp">
<i class="fas fa-chart-line me-2"></i>Dashboard
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="trainer/list">
<i class="fas fa-users me-2"></i>View Trainers
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="user/list">
<i class="fas fa-user me-2"></i>View Users
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addTrainerModal">
<i class="fas fa-user-plus me-2"></i>Add Trainer
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addUserModal">
<i class="fas fa-user-plus me-2"></i>Add User
</a>
</li>

</ul>

</nav>

<!-- MAIN CONTENT -->

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

<h2 class="mt-3 mb-4">Admin Dashboard</h2>

<% if (request.getParameter("message") != null) { %>

<div class="alert alert-success">Operation successful!</div>
<% } %>

<% if (request.getParameter("error") != null) { %>

<div class="alert alert-danger">Operation failed!</div>
<% } %>

<div class="row mb-4">

<div class="col-md-4 mb-3">

<div class="card p-3 text-center">

<h5>Total Users</h5>

<h2><%= new UserDAO().getAllUsers().size() %></h2>

<i class="fas fa-users dashboard-icon"></i>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="card p-3 text-center">

<h5>Total Trainers</h5>

<h2><%= new TrainerDAO().getAllTrainers().size() %></h2>

<i class="fas fa-user-tie dashboard-icon"></i>

</div>

</div>

</div>

<div class="card p-4">

<h5 class="mb-4">Quick Actions</h5>

<div class="row">

<div class="col-md-3 mb-3">
<button class="btn btn-gradient w-100" data-bs-toggle="modal" data-bs-target="#addTrainerModal">
<i class="fas fa-user-plus me-2"></i>Add Trainer
</button>
</div>

<div class="col-md-3 mb-3">
<a href="trainer/list" class="btn btn-gradient w-100">
<i class="fas fa-users me-2"></i>View Trainers
</a>
</div>

<div class="col-md-3 mb-3">
<a href="user/list" class="btn btn-gradient w-100">
<i class="fas fa-user me-2"></i>View Users
</a>
</div>

<div class="col-md-3 mb-3">
<a href="logout.jsp" class="btn btn-gradient w-100">
<i class="fas fa-sign-out-alt me-2"></i>Logout
</a>
</div>

</div>

</div>

</main>

</div>

</div>

<!-- ADD TRAINER MODAL -->

<div class="modal fade" id="addTrainerModal" tabindex="-1">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">Add Trainer</h5>

<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>

</div>

<form action="trainer" method="post">

<input type="hidden" name="action" value="add">

<div class="modal-body">

<input type="text" class="form-control mb-3" name="name" placeholder="Trainer Name" required>

<input type="text" class="form-control mb-3" name="specialization" placeholder="Specialization" required>

<input type="number" class="form-control mb-3" name="experience" placeholder="Experience" required>

<input type="text" class="form-control mb-3" name="phone" placeholder="Phone" required>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

<button type="submit" class="btn btn-gradient">Add Trainer</button>

</div>

</form>

</div>

</div>

</div>

<!-- ADD USER MODAL -->

<div class="modal fade" id="addUserModal" tabindex="-1">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">Add User</h5>

<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>

</div>

<form action="user" method="post">

<input type="hidden" name="action" value="add">

<div class="modal-body">

<input type="text" class="form-control mb-3" name="name" placeholder="Name" required>

<input type="email" class="form-control mb-3" name="email" placeholder="Email" required>

<input type="password" class="form-control mb-3" name="password" placeholder="Password" required>

<select class="form-control mb-3" name="role">
<option value="user">User</option>
<option value="trainer">Trainer</option>
<option value="admin">Admin</option>
</select>

<input type="text" class="form-control mb-3" name="phone" placeholder="Phone" required>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

<button type="submit" class="btn btn-gradient">Add User</button>

</div>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
