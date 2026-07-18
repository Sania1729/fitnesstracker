<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Register - Fitness Tracker</title>

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

min-height:100vh;
display:flex;
align-items:center;
justify-content:center;

background:
linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
url("https://images.unsplash.com/photo-1534438327276-14e5300c3a48");

background-size:cover;
background-position:center;

padding:20px;

}

/* REGISTER CARD */

.register-card{

background:rgba(255,255,255,0.12);
backdrop-filter:blur(20px);

border-radius:20px;
padding:45px;

width:100%;
max-width:480px;

box-shadow:0 20px 50px rgba(0,0,0,0.6);

color:white;

}

/* LOGO */

.brand-logo{

font-size:45px;
text-align:center;
margin-bottom:10px;
color:#0d6efd;

}

.brand-title{

text-align:center;
margin-bottom:30px;
font-weight:600;

}

/* INPUTS */

.form-control{

border:none;
border-radius:10px;
padding:12px;

}

.form-control:focus{

box-shadow:0 0 0 2px rgba(13,110,253,0.4);

}

.input-group-text{

background:white;
border:none;

}

/* REGISTER BUTTON */

.btn-register{

background:linear-gradient(45deg,#0d6efd,#4facfe);

border:none;

padding:12px;

border-radius:10px;

font-weight:bold;

color:white;

transition:0.3s;

}

.btn-register:hover{

transform:translateY(-3px);

box-shadow:0 10px 20px rgba(0,0,0,0.5);

background:linear-gradient(45deg,#0b5ed7,#3ea0ff);

}

/* LINKS */

.links a{

text-decoration:none;
color:#4facfe;

}

.links a:hover{

text-decoration:underline;

}

.alert{

border-radius:10px;

}

</style>

</head>

<body>

<div class="register-card">

<div class="brand-logo">
<i class="fas fa-dumbbell"></i>
</div>

<h3 class="brand-title">
Create Your Account
</h3>

<% if (request.getParameter("error") != null) { %>

<div class="alert alert-danger">
Registration failed! Please try again.
</div>

<% } %>

<form action="register" method="post">

<div class="mb-3">

<label class="form-label">Full Name</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-user"></i>
</span>

<input
type="text"
class="form-control"
name="name"
placeholder="Enter your full name"
required>

</div>

</div>

<div class="mb-3">

<label class="form-label">Email</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-envelope"></i>
</span>

<input
type="email"
class="form-control"
name="email"
placeholder="Enter your email"
required>

</div>

</div>

<div class="mb-3">

<label class="form-label">Password</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-lock"></i>
</span>

<input
type="password"
class="form-control"
name="password"
id="password"
placeholder="Enter your password"
required>

<span class="input-group-text" onclick="togglePassword()" style="cursor:pointer">

<i class="fas fa-eye" id="eyeIcon"></i>

</span>

</div>

</div>

<div class="mb-3">

<label class="form-label">Role</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-user-tag"></i>
</span>

<select class="form-control" name="role" required>

<option value="">Select Role</option>
<option value="user">User</option>
<option value="trainer">Trainer</option>

</select>

</div>

</div>

<div class="mb-3">

<label class="form-label">Phone</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-phone"></i>
</span>

<input
type="tel"
class="form-control"
name="phone"
placeholder="Enter phone number"
required>

</div>

</div>

<button type="submit" class="btn btn-register w-100 mb-3">

<i class="fas fa-user-plus me-2"></i>
Register

</button>

</form>

<div class="text-center links">

<p>
Already have an account?
<a href="login.jsp">Login</a>
</p>

<p>
<a href="index.jsp">Back to Home</a>
</p>

</div>

</div>

<script>

function togglePassword(){

var password=document.getElementById("password");
var icon=document.getElementById("eyeIcon");

if(password.type==="password"){

password.type="text";
icon.classList.remove("fa-eye");
icon.classList.add("fa-eye-slash");

}else{

password.type="password";
icon.classList.remove("fa-eye-slash");
icon.classList.add("fa-eye");

}

}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>