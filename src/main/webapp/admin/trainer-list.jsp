<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dto.TrainerDTO, java.util.List" %>

<%
if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("userRole"))) {
    response.sendRedirect("../login.jsp");
    return;
}

List<TrainerDTO> trainers = (List<TrainerDTO>) request.getAttribute("trainers");
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Trainer Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>

/* GLOBAL */

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
url("https://images.unsplash.com/photo-1554284126-aa88f22d8b74");

background-size:cover;
background-position:center;
background-attachment:fixed;

color:white;
min-height:100vh;

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
padding:12px;
border-radius:10px;
}

.sidebar .nav-link:hover,
.sidebar .nav-link.active{
background:rgba(255,255,255,0.2);
}

/* CARD */

.card{
background:rgba(255,255,255,0.12);
backdrop-filter:blur(15px);
border:none;
border-radius:15px;
box-shadow:0 10px 30px rgba(0,0,0,0.5);
color:white;
}

/* PREMIUM TABLE */

.custom-table{
border-collapse:separate;
border-spacing:0 12px;
color:#e6e6e6;
}

/* TABLE HEADER */

.custom-table thead th{
background:rgba(0,0,0,0.75);
color:#d4af37;
font-weight:600;
text-transform:uppercase;
padding:14px;
border:none;
}

/* ROW */

.custom-table tbody tr{
background:rgba(255,255,255,0.05);
border-radius:10px;
transition:0.25s;
}

.custom-table tbody tr:hover{
background:rgba(255,255,255,0.12);
transform:translateY(-2px);
}

.custom-table td{
padding:15px;
border:none;
}

/* BADGES */

.badge-specialization{
background:#d4af37;
color:black;
font-size:11px;
padding:6px 10px;
}

/* ACTION BUTTONS */

.btn-edit{
background:#444;
color:white;
border:none;
margin-right:5px;
}

.btn-edit:hover{
background:#666;
}

.btn-delete{
background:#8b0000;
color:white;
border:none;
}

.btn-delete:hover{
background:#b30000;
}

.btn-primary{
background:#d4af37;
border:none;
color:black;
}

.btn-primary:hover{
background:#b7950b;
}

/* MODAL */

.modal-content{
background:rgba(0,0,0,0.9);
color:white;
}

</style>

</head>

<body>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->

<nav class="col-md-3 col-lg-2 sidebar">

<a class="navbar-brand text-white ps-3" href="<%= request.getContextPath() %>/admin-dashboard.jsp">
<i class="fas fa-dumbbell me-2"></i>
Fitness Tracker
</a>

<ul class="nav flex-column mt-4">

<li class="nav-item">
<a class="nav-link" href="<%= request.getContextPath() %>/admin-dashboard.jsp">
<i class="fas fa-tachometer-alt me-2"></i>Dashboard
</a>
</li>

<li class="nav-item">
<a class="nav-link active" href="<%= request.getContextPath() %>/trainer/list">
<i class="fas fa-users me-2"></i>Trainers
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="<%= request.getContextPath() %>/user/list">
<i class="fas fa-user me-2"></i>Users
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addTrainerModal">
<i class="fas fa-user-plus me-2"></i>Add Trainer
</a>
</li>

</ul>

</nav>


<!-- MAIN CONTENT -->

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

<h2 class="mt-4 mb-4">Trainer Management</h2>

<div class="card p-4">

<h5 class="mb-4">
<i class="fas fa-users me-2"></i>All Trainers
<span class="badge bg-warning text-dark ms-2">
<%= trainers != null ? trainers.size() : 0 %>
</span>
</h5>

<div class="table-responsive">

<table class="table custom-table align-middle">

<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Specialization</th>
<th>Experience</th>
<th>Phone</th>
<th class="text-center">Actions</th>
</tr>
</thead>

<tbody>

<% if (trainers != null) {
for (TrainerDTO trainer : trainers) { %>

<tr>

<td>#<%= trainer.getTrainerId() %></td>

<td>
<strong><%= trainer.getName() %></strong>
</td>

<td>
<span class="badge badge-specialization">
<%= trainer.getSpecialization() %>
</span>
</td>

<td>
<%= trainer.getExperience() %> yrs
</td>

<td>
<i class="fas fa-phone text-success me-1"></i>
<%= trainer.getPhone() %>
</td>

<td class="text-center">

<button class="btn btn-sm btn-edit"
onclick="editTrainer(<%= trainer.getTrainerId() %>)">
<i class="fas fa-edit"></i>
</button>

<button class="btn btn-sm btn-delete"
onclick="deleteTrainer(<%= trainer.getTrainerId() %>)">
<i class="fas fa-trash"></i>
</button>

</td>

</tr>

<% } } %>

</tbody>

</table>

</div>
</div>

</main>
</div>
</div>


<!-- ADD TRAINER MODAL -->

<div class="modal fade" id="addTrainerModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">
<h5 class="modal-title">
<i class="fas fa-user-plus me-2"></i>Add Trainer
</h5>
<button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<form action="../trainer-actions" method="post">

<input type="hidden" name="action" value="add">

<div class="modal-body">

<input type="text" class="form-control mb-3" name="name" placeholder="Name" required>

<input type="text" class="form-control mb-3" name="specialization" placeholder="Specialization" required>

<input type="number" class="form-control mb-3" name="experience" placeholder="Experience" required>

<input type="text" class="form-control" name="phone" placeholder="Phone" required>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

<button class="btn btn-primary">
<i class="fas fa-save me-2"></i>Add Trainer
</button>

</div>

</form>

</div>
</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

function editTrainer(id){
alert("Edit feature coming soon: "+id);
}

function deleteTrainer(id){
if(confirm("Delete this trainer?")){
window.location.href="../trainer-actions?action=delete&id="+id;
}
}

</script>

</body>
</html>