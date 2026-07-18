<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dao.UserDAO, com.fitnesstracker.dto.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Check User - Fitness Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Check Specific User</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>User Lookup Results</h5>
            </div>
            <div class="card-body">
                <%
                    String email = "pavan@gmaiil.com"; // The email you tried
                    String password = "your_password"; // We'll check what password is stored
                    
                    UserDAO userDAO = new UserDAO();
                    
                    // Check if user exists with any password
                    try {
                        java.sql.Connection conn = com.fitnesstracker.util.DBUtil.getConnection();
                        java.sql.PreparedStatement pstmt = conn.prepareStatement(
                            "SELECT * FROM users WHERE email = ?");
                        pstmt.setString(1, email);
                        java.sql.ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                %>
                            <div class="alert alert-warning">
                                <h6>⚠️ User Found But Login Failed</h6>
                                <p><strong>User ID:</strong> <%= rs.getInt("user_id") %></p>
                                <p><strong>Name:</strong> <%= rs.getString("name") %></p>
                                <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                                <p><strong>Password in DB:</strong> <%= rs.getString("password") %></p>
                                <p><strong>Role:</strong> <%= rs.getString("role") %></p>
                                <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
                                
                                <div class="mt-3">
                                    <h6>🔍 Issue Analysis:</h6>
                                    <ul>
                                        <li>Check if the password you entered matches exactly what's stored</li>
                                        <li>Look for extra spaces or case differences</li>
                                        <li>Verify the email spelling is correct</li>
                                    </ul>
                                </div>
                            </div>
                <%
                        } else {
                %>
                            <div class="alert alert-danger">
                                <h6>❌ User Not Found</h6>
                                <p>No user found with email: <strong><%= email %></strong></p>
                                
                                <div class="mt-3">
                                    <h6>🔍 Possible Issues:</h6>
                                    <ul>
                                        <li>Email typo: <code>pavan@gmaiil.com</code> (extra "i")</li>
                                        <li>Try: <code>pavan@gmail.com</code> (correct spelling)</li>
                                        <li>User not registered yet</li>
                                    </ul>
                                </div>
                            </div>
                <%
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                %>
                            <div class="alert alert-danger">
                                <h6>❌ Database Error</h6>
                                <p><%= e.getMessage() %></p>
                            </div>
                <%
                    }
                %>
                
                <div class="mt-3">
                    <h6>🔧 Quick Fixes:</h6>
                    <ol>
                        <li><strong>Check email spelling:</strong> Try <code>pavan@gmail.com</code> instead of <code>pavan@gmaiil.com</code></li>
                        <li><strong>Register new user:</strong> <a href="register.jsp">Register User</a></li>
                        <li><strong>Try different credentials:</strong> <a href="test-login.jsp">Test Login</a></li>
                    </ol>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="login.jsp" class="btn btn-primary me-2">Back to Login</a>
            <a href="debug-users.jsp" class="btn btn-info me-2">Debug Users</a>
            <a href="test-login.jsp" class="btn btn-secondary">Test Login</a>
        </div>
    </div>
</body>
</html>
