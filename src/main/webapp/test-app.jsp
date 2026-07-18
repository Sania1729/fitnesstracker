<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Application Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Application Status Test</h2>
        
        <div class="card">
            <div class="card-header">
                <h5>Basic Tests</h5>
            </div>
            <div class="card-body">
                <div class="alert alert-success">
                    <h6>✅ JSP Working</h6>
                    <p>This JSP page loads successfully.</p>
                </div>
                
                <div class="alert alert-info">
                    <h6>📊 Request Information</h6>
                    <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
                    <p><strong>Request URI:</strong> <%= request.getRequestURI() %></p>
                    <p><strong>Servlet Path:</strong> <%= request.getServletPath() %></p>
                    <p><strong>Server Name:</strong> <%= request.getServerName() %></p>
                    <p><strong>Port:</strong> <%= request.getServerPort() %></p>
                </div>
                
                <div class="alert alert-warning">
                    <h6>🔗 Test Links</h6>
                    <p>
                        <a href="login.jsp" class="btn btn-primary me-2">Login Page</a>
                        <a href="index.jsp" class="btn btn-secondary me-2">Home Page</a>
                        <a href="trainer-dashboard.jsp" class="btn btn-info">Trainer Dashboard</a>
                    </p>
                </div>
                
                <div class="alert alert-secondary">
                    <h6>🕐 Session Info</h6>
                    <p><strong>Session ID:</strong> <%= session.getId() %></p>
                    <p><strong>User in Session:</strong> <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "None" %></p>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <h3>Next Steps</h3>
            <ol>
                <li>If this page loads, application is working</li>
                <li>Test the links above</li>
                <li>If links work, try workout functionality</li>
                <li>If workout list fails, check console logs</li>
            </ol>
        </div>
    </div>
</body>
</html>
