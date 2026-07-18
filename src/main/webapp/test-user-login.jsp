<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dto.UserDTO, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login Test - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>User Login Test</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>All User Accounts in Database</h5>
            </div>
            <div class="card-body">
                <%
                    UserDAO userDAO = new UserDAO();
                    List<UserDTO> users = userDAO.getAllUsers();
                    
                    if (users == null || users.isEmpty()) {
                %>
                    <div class="alert alert-warning">
                        No users found in database.
                    </div>
                <%
                    } else {
                        for (UserDTO user : users) {
                            if ("user".equals(user.getRole())) {
                %>
                                <div class="card mb-3">
                                    <div class="card-header">
                                        <h6>User: <%= user.getName() %></h6>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>Email:</strong> <%= user.getEmail() %></p>
                                        <p><strong>Role:</strong> <%= user.getRole() %></p>
                                        <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                                        <p><strong>Password in DB:</strong> <%= user.getPassword() %></p>
                                        
                                        <div class="mt-3">
                                            <h6>Test Login:</h6>
                                            <form method="post" action="" class="d-inline">
                                                <input type="hidden" name="testEmail" value="<%= user.getEmail() %>">
                                                <input type="hidden" name="testPassword" value="<%= user.getPassword() %>">
                                                <button type="submit" class="btn btn-sm btn-primary">Test with DB Password</button>
                                            </form>
                                            
                                            <form method="post" action="" class="d-inline ms-2">
                                                <input type="hidden" name="testEmail" value="<%= user.getEmail() %>">
                                                <input type="hidden" name="testPassword" value="password123">
                                                <button type="submit" class="btn btn-sm btn-secondary">Test with "password123"</button>
                                            </form>
                                        </div>
                                        
                                        <%
                                            if ("POST".equals(request.getMethod())) {
                                                String testEmail = request.getParameter("testEmail");
                                                String testPassword = request.getParameter("testPassword");
                                                
                                                if (testEmail != null && testEmail.equals(user.getEmail())) {
                                                    UserDTO loginUser = userDAO.loginUser(testEmail, testPassword);
                                                    
                                                    if (loginUser != null) {
                                        %>
                                                        <div class="alert alert-success mt-2">
                                                            ✅ Login SUCCESS with password: "<%= testPassword %>"
                                                        </div>
                                        %>
                                                    } else {
                                        %>
                                                        <div class="alert alert-danger mt-2">
                                                            ❌ Login FAILED with password: "<%= testPassword %>"
                                                        </div>
                                        %>
                                                    }
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                <%
                            }
                        }
                    }
                %>
            </div>
        </div>
        
        <div class="card mt-3">
            <div class="card-header">
                <h5>Manual Login Test</h5>
            </div>
            <div class="card-body">
                <form method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="manualEmail" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="manualPassword" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Test Manual Login</button>
                </form>
                
                <%
                    if ("POST".equals(request.getMethod())) {
                        String manualEmail = request.getParameter("manualEmail");
                        String manualPassword = request.getParameter("manualPassword");
                        
                        if (manualEmail != null && manualPassword != null) {
                            UserDTO manualLogin = userDAO.loginUser(manualEmail, manualPassword);
                            
                            if (manualLogin != null) {
                %>
                                <div class="alert alert-success mt-3">
                                    <h6>✅ Manual Login SUCCESS!</h6>
                                    <p><strong>User:</strong> <%= manualLogin.getName() %></p>
                                    <p><strong>Email:</strong> <%= manualLogin.getEmail() %></p>
                                    <p><strong>Role:</strong> <%= manualLogin.getRole() %></p>
                                    <p><strong>Password used:</strong> <%= manualPassword %></p>
                                </div>
                <%
                            } else {
                %>
                                <div class="alert alert-danger mt-3">
                                    <h6>❌ Manual Login FAILED!</h6>
                                    <p><strong>Email tried:</strong> <%= manualEmail %></p>
                                    <p><strong>Password tried:</strong> <%= manualPassword %></p>
                                </div>
                <%
                            }
                        }
                    }
                %>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="login.jsp" class="btn btn-primary me-2">Login Page</a>
            <a href="register.jsp" class="btn btn-success me-2">Register User</a>
            <a href="debug-users.jsp" class="btn btn-info">Debug All Users</a>
        </div>
    </div>
</body>
</html>
