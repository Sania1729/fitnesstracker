<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dto.UserDTO, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Debug - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>User Database Debug</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>All Users in Database</h5>
            </div>
            <div class="card-body">
                <%
                    try {
                        UserDAO userDAO = new UserDAO();
                        List<UserDTO> users = userDAO.getAllUsers();
                        
                        if (users == null || users.isEmpty()) {
                %>
                    <div class="alert alert-warning">
                        <h6>⚠️ No Users Found</h6>
                        <p>The database is empty. You need to register users first.</p>
                        <a href="register.jsp" class="btn btn-primary">Register New User</a>
                    </div>
                <%
                        } else {
                %>
                    <div class="alert alert-success">
                        <h6>✅ Found <%= users.size() %> Users</h6>
                    </div>
                    
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Phone</th>
                                <th>Test Login</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (UserDTO user : users) {
                            %>
                            <tr>
                                <td><%= user.getUserId() %></td>
                                <td><%= user.getName() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><span class="badge bg-<%= 
                                    "admin".equals(user.getRole()) ? "danger" : 
                                    "trainer".equals(user.getRole()) ? "primary" : "success" %>">
                                    <%= user.getRole() %>
                                </span></td>
                                <td><%= user.getPhone() %></td>
                                <td>
                                    <form action="login.jsp" method="post" style="display: inline;">
                                        <input type="hidden" name="email" value="<%= user.getEmail() %>">
                                        <input type="hidden" name="password" value="password123">
                                        <button type="submit" class="btn btn-sm btn-outline-primary">Test Login</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <div class="alert alert-danger">
                        <h6>❌ Database Error</h6>
                        <p><%= e.getMessage() %></p>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
        
        <div class="mt-3">
            <h3>Common Test Credentials</h3>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h6>Admin</h6>
                            <p><strong>Email:</strong> admin@fitness.com<br>
                            <strong>Password:</strong> admin123</p>
                            <a href="login.jsp" class="btn btn-danger btn-sm">Login as Admin</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h6>Trainer</h6>
                            <p><strong>Email:</strong> carol@fitness.com<br>
                            <strong>Password:</strong> carol123</p>
                            <a href="login.jsp" class="btn btn-primary btn-sm">Login as Trainer</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h6>User</h6>
                            <p><strong>Email:</strong> john@fitness.com<br>
                            <strong>Password:</strong> john123</p>
                            <a href="login.jsp" class="btn btn-success btn-sm">Login as User</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <h3>Quick Actions</h3>
            <a href="register.jsp" class="btn btn-primary me-2">Register New User</a>
            <a href="login.jsp" class="btn btn-secondary me-2">Login Page</a>
            <a href="index.jsp" class="btn btn-info">Home</a>
        </div>
    </div>
</body>
</html>
