<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dto.UserDTO, java.util.List" %>

<%
if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("userRole"))) {
    response.sendRedirect("login.jsp");
    return;
}

List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Management</title>

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
transition:0.3s;

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


/* CLASSY PREMIUM TABLE */

.custom-table{

width:100%;
border-collapse:separate;
border-spacing:0 12px;
color:#e6e6e6;

}

/* HEADER */

.custom-table thead th{

background:rgba(0,0,0,0.75);
color:#d4af37;
font-weight:600;
letter-spacing:1px;
text-transform:uppercase;
border:none;
padding:14px;

}

/* ROW */

.custom-table tbody tr{

background:rgba(255,255,255,0.05);
backdrop-filter:blur(10px);
border-radius:10px;
transition:all 0.25s ease;

}

.custom-table tbody tr:hover{

background:rgba(255,255,255,0.12);
transform:translateY(-2px);

}

.custom-table td{

padding:15px;
border:none;

}


/* AVATAR */

.avatar-circle{

width:40px;
height:40px;
border-radius:50%;
background:#d4af37;
display:flex;
align-items:center;
justify-content:center;
color:black;

}


/* ROLE BADGES */

.role-admin{
background:#8b0000;
}

.role-trainer{
background:#b7950b;
}

.role-user{
background:#1e8449;
}

.badge-role{

font-size:11px;
padding:6px 12px;
border-radius:20px;

}


/* BUTTONS */

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
<a class="nav-link" href="<%= request.getContextPath() %>/user/list">
<i class="fas fa-user me-2"></i>Users
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="<%= request.getContextPath() %>/trainer/list">
<i class="fas fa-users me-2"></i>Trainers
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

<h2 class="mt-4 mb-4">User Management</h2>

<div class="card p-4">

<h5 class="mb-4">
<i class="fas fa-users me-2"></i>All Users
</h5>

<div class="table-responsive">

<table class="table custom-table align-middle">

<thead>

<tr>
<th>ID</th>
<th>User</th>
<th>Email</th>
<th>Role</th>
<th>Phone</th>
<th class="text-center">Actions</th>
</tr>

</thead>

<tbody>

<% if(users!=null){
for(UserDTO user:users){ %>

<tr>

<td>#<%=user.getUserId()%></td>

<td>

<div class="d-flex align-items-center">

<div class="avatar-circle me-3">
<i class="fas fa-user"></i>
</div>

<strong><%=user.getName()%></strong>

</div>

</td>

<td>
<i class="fas fa-envelope me-1 text-warning"></i>
<%=user.getEmail()%>
</td>

<td>

<%
String roleClass="";
String roleIcon="";

if("admin".equals(user.getRole())){
roleClass="role-admin";
roleIcon="fa-user-shield";
}
else if("trainer".equals(user.getRole())){
roleClass="role-trainer";
roleIcon="fa-user-tie";
}
else{
roleClass="role-user";
roleIcon="fa-user";
}
%>

<span class="badge <%=roleClass%> badge-role">
<i class="fas <%=roleIcon%> me-1"></i>
<%=user.getRole().toUpperCase()%>
</span>

</td>

<td>
<i class="fas fa-phone text-success me-1"></i>
<%=user.getPhone()%>
</td>

<td class="text-center">

<button class="btn btn-sm btn-edit"
onclick="editUser(<%=user.getUserId()%>)">
<i class="fas fa-edit"></i>
</button>

<% if(!"admin".equals(user.getRole())){ %>

<button class="btn btn-sm btn-delete"
onclick="deleteUser(<%=user.getUserId()%>)">
<i class="fas fa-trash"></i>
</button>

<% } %>

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


<!-- ADD USER MODAL -->

<div class="modal fade" id="addUserModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">
<i class="fas fa-user-plus me-2"></i>Add User
</h5>

<button class="btn-close" data-bs-dismiss="modal"></button>

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

<input type="text" class="form-control" name="phone" placeholder="Phone" required>

</div>

<div class="modal-footer">

<button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

<button class="btn btn-primary">
<i class="fas fa-save me-2"></i>Add User
</button>

</div>

</form>

</div>
</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

function editUser(id){
alert("Edit feature coming soon: "+id);
}

function deleteUser(id){
if(confirm("Delete this user?")){
window.location.href="user?action=delete&id="+id;
}
}

</script>

</body>
</html>