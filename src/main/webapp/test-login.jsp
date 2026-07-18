<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dto.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Test - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Login Test</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>Test Login Directly</h5>
            </div>
            <div class="card-body">
                <form method="post">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="john@fitness.com" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" value="john123" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Test Login</button>
                </form>
                
                <%
                    if ("POST".equals(request.getMethod())) {
                        String email = request.getParameter("email");
                        String password = request.getParameter("password");
                        
                        System.out.println("=== Test Login JSP ===");
                        System.out.println("Email: " + email);
                        System.out.println("Password: " + password);
                        
                        UserDAO userDAO = new UserDAO();
                        UserDTO user = userDAO.loginUser(email, password);
                        
                        System.out.println("User found: " + (user != null ? "YES" : "NO"));
                        
                        if (user != null) {
                            System.out.println("User ID: " + user.getUserId());
                            System.out.println("User Name: " + user.getName());
                            System.out.println("User Role: " + user.getRole());
                %>
                            <div class="alert alert-success mt-3">
                                <h6>✅ Login Successful!</h6>
                                <p><strong>User ID:</strong> <%= user.getUserId() %></p>
                                <p><strong>Name:</strong> <%= user.getName() %></p>
                                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                                <p><strong>Role:</strong> <%= user.getRole() %></p>
                                <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                                
                                <a href="login.jsp" class="btn btn-primary">Proceed to Login</a>
                            </div>
                <%
                        } else {
                %>
                            <div class="alert alert-danger mt-3">
                                <h6>❌ Login Failed!</h6>
                                <p>Invalid email or password.</p>
                                <p><strong>Email tried:</strong> <%= email %></p>
                                <p><strong>Password tried:</strong> <%= password %></p>
                            </div>
                <%
                        }
                        System.out.println("=== End Test Login JSP ===");
                    }
                %>
            </div>
        </div>
        
        <div class="mt-3">
            <h3>Database Check</h3>
            <button onclick="checkDatabase()" class="btn btn-info">Check Database Users</button>
            <div id="databaseResults"></div>
        </div>
        
        <div class="mt-3">
            <a href="debug-users.jsp" class="btn btn-secondary me-2">User Debug</a>
            <a href="login.jsp" class="btn btn-primary">Login Page</a>
        </div>
    </div>
    
    <script>
        function checkDatabase() {
            fetch('debug-users.jsp')
                .then(response => response.text())
                .then(html => {
                    document.getElementById('databaseResults').innerHTML = 
                        '<div class="mt-3"><h5>Database Results:</h5><pre>' + html + '</pre></div>';
                })
                .catch(error => {
                    document.getElementById('databaseResults').innerHTML = 
                        '<div class="mt-3 alert alert-danger">Error checking database: ' + error + '</div>';
                });
        }
    </script>
</body>
</html>
