<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Application Status Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Application Status Check</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>Application Information</h5>
            </div>
            <div class="card-body">
                <div class="alert alert-info">
                    <h6>📊 Request Information</h6>
                    <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
                    <p><strong>Request URI:</strong> <%= request.getRequestURI() %></p>
                    <p><strong>Servlet Path:</strong> <%= request.getServletPath() %></p>
                    <p><strong>Server Name:</strong> <%= request.getServerName() %></p>
                    <p><strong>Server Port:</strong> <%= request.getServerPort() %></p>
                    <p><strong>Remote Addr:</strong> <%= request.getRemoteAddr() %></p>
                </div>
                
                <div class="alert alert-success">
                    <h6>✅ Application Status</h6>
                    <p><strong>JSP Working:</strong> This page loads successfully</p>
                    <p><strong>Session Status:</strong> 
                        <% 
                            if (session.getAttribute("userName") != null) {
                                out.print("Active - User: " + session.getAttribute("userName"));
                            } else {
                                out.print("No active session");
                            }
                        %>
                    </p>
                </div>
                
                <div class="mt-3">
                    <h6>🔧 Troubleshooting Steps</h6>
                    <ol>
                        <li><strong>Step 1:</strong> Check if Tomcat is running</li>
                        <li><strong>Step 2:</strong> Verify application is deployed correctly</li>
                        <li><strong>Step 3:</strong> Check the correct URL format</li>
                        <li><strong>Step 4:</strong> Try accessing different URLs</li>
                    </ol>
                </div>
                
                <div class="mt-3">
                    <h6>🌐 Test URLs to Try</h6>
                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <div class="card">
                                <div class="card-body">
                                    <h6>Direct Access</h6>
                                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary">Home Page</a>
                                    <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-secondary">Login Page</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-2">
                            <div class="card">
                                <div class="card-body">
                                    <h6>Servlet Tests</h6>
                                    <a href="<%= request.getContextPath() %>/hello" class="btn btn-info">Test Servlet</a>
                                    <a href="<%= request.getContextPath() %>/workout-list" class="btn btn-success">Workout List</a>
                                    <a href="<%= request.getContextPath() %>/diet-list" class="btn btn-warning">Diet List</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
