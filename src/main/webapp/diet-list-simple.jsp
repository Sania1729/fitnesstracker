<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.fitnesstracker.dto.DietDTO" %>

<%
if (session.getAttribute("user") == null || !"trainer".equals(session.getAttribute("userRole"))) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>

<head>

<title>My Diet Plans - Fitness Tracker</title>

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
url("https://images.unsplash.com/photo-1490645935967-10de6ba17061");

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

background:linear-gradient(45deg,#28a745,#7ed957);

border:none;

font-weight:bold;

color:white;

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

<h2><i class="fas fa-apple-alt me-2"></i>My Diet Plans</h2>

<a href="trainer-dashboard.jsp" class="btn btn-secondary">

<i class="fas fa-arrow-left me-2"></i>
Back to Dashboard

</a>

</div>

<div class="glass-card p-4">

<h5 class="mb-3">Diet Plan List</h5>

<%

List<DietDTO> diets = (List<DietDTO>) request.getAttribute("diets");

if (diets == null || diets.isEmpty()) {

%>

<div class="alert alert-info">

<i class="fas fa-info-circle me-2"></i>

No diet plans found. Start by adding your first diet plan!

</div>

<%

} else {

%>

<table class="table table-striped table-hover">

<thead>

<tr>

<th>Meal Name</th>
<th>Calories</th>
<th>Protein (g)</th>
<th>Carbs (g)</th>
<th>Fats (g)</th>

</tr>

</thead>

<tbody>

<%

for (DietDTO diet : diets) {

%>

<tr>

<td><%= diet.getMealName() %></td>
<td><%= diet.getCalories() %></td>
<td><%= diet.getProtein() %></td>
<td><%= diet.getCarbs() %></td>
<td><%= diet.getFats() %></td>

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

onclick="showAddDietModal()">

<i class="fas fa-plus me-2"></i>

Add New Diet Plan

</button>

</div>

</div>

<!-- ADD DIET MODAL -->

<div class="modal fade" id="addDietModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5>Add New Diet Plan</h5>

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

<label>Protein (g)</label>

<input type="number" step="0.1" name="protein" class="form-control" required>

</div>

<div class="mb-3">

<label>Carbs (g)</label>

<input type="number" step="0.1" name="carbs" class="form-control" required>

</div>

<div class="mb-3">

<label>Fats (g)</label>

<input type="number" step="0.1" name="fats" class="form-control" required>

</div>

</div>

<div class="modal-footer">

<button type="button" class="btn btn-secondary"

data-bs-dismiss="modal">

Cancel

</button>

<button type="submit" class="btn btn-theme">

Add Diet Plan

</button>

</div>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

function showAddDietModal(){

var modal = new bootstrap.Modal(document.getElementById('addDietModal'));

modal.show();

}

</script>

</body>

</html>
