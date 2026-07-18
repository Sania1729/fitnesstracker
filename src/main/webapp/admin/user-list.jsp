<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fitnesstracker.dto.UserDTO, java.util.List" %>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            min-height: 100vh;
        }
        .sidebar .nav-link {
            color: #ecf0f1;
            border-radius: 5px;
            margin: 2px 0;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
        }
        .user-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .badge-role {
            font-size: 11px;
            padding: 4px 8px;
        }
        .role-admin {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
        }
        .role-trainer {
            background: linear-gradient(45deg, #f39c12, #e67e22);
        }
        .role-user {
            background: linear-gradient(45deg, #27ae60, #229954);
        }
        .btn-action {
            padding: 5px 10px;
            font-size: 12px;
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <a class="navbar-brand text-white mb-4" href="admin-dashboard.jsp">
                        <i class="fas fa-dumbbell me-2"></i>Fitness Tracker
                    </a>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="../admin-dashboard.jsp">
                                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../trainer/list">
                                <i class="fas fa-users me-2"></i> Trainers
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="../user/list">
                                <i class="fas fa-user me-2"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-user-plus me-2"></i> Add User
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">User Management</h1>
                    <div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="fas fa-user-plus me-2"></i>Add New User
                        </button>
                    </div>
                </div>

                <% if (request.getParameter("message") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>Operation successful!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>Operation failed!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="d-flex align-items-center">
                                <div class="flex-grow-1">
                                    <h6 class="text-white-50 mb-1">Total Users</h6>
                                    <h3 class="mb-0"><%= users != null ? users.size() : 0 %></h3>
                                </div>
                                <div class="ms-3">
                                    <i class="fas fa-users fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="d-flex align-items-center">
                                <div class="flex-grow-1">
                                    <h6 class="text-white-50 mb-1">Admins</h6>
                                    <h3 class="mb-0">
                                        <%= users != null ? users.stream().filter(u -> "admin".equals(u.getRole())).count() : 0 %>
                                    </h3>
                                </div>
                                <div class="ms-3">
                                    <i class="fas fa-user-shield fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="d-flex align-items-center">
                                <div class="flex-grow-1">
                                    <h6 class="text-white-50 mb-1">Trainers</h6>
                                    <h3 class="mb-0">
                                        <%= users != null ? users.stream().filter(u -> "trainer".equals(u.getRole())).count() : 0 %>
                                    </h3>
                                </div>
                                <div class="ms-3">
                                    <i class="fas fa-user-tie fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="d-flex align-items-center">
                                <div class="flex-grow-1">
                                    <h6 class="text-white-50 mb-1">Regular Users</h6>
                                    <h3 class="mb-0">
                                        <%= users != null ? users.stream().filter(u -> "user".equals(u.getRole())).count() : 0 %>
                                    </h3>
                                </div>
                                <div class="ms-3">
                                    <i class="fas fa-user fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-users me-2"></i>All Users
                            <span class="badge bg-primary ms-2"><%= users != null ? users.size() : 0 %></span>
                        </h5>
                    </div>
                    <div class="card-body">
                        <% if (users != null && !users.isEmpty()) { %>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Phone</th>
                                            <th>Joined</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (UserDTO user : users) { %>
                                            <tr>
                                                <td><%= user.getUserId() %></td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar-circle me-2">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <strong><%= user.getName() %></strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <i class="fas fa-envelope me-1 text-muted"></i>
                                                    <%= user.getEmail() %>
                                                </td>
                                                <td>
                                                    <% 
                                                        String roleClass = "";
                                                        String roleIcon = "";
                                                        if ("admin".equals(user.getRole())) {
                                                            roleClass = "role-admin";
                                                            roleIcon = "fa-user-shield";
                                                        } else if ("trainer".equals(user.getRole())) {
                                                            roleClass = "role-trainer";
                                                            roleIcon = "fa-user-tie";
                                                        } else {
                                                            roleClass = "role-user";
                                                            roleIcon = "fa-user";
                                                        }
                                                    %>
                                                    <span class="badge <%= roleClass %> text-white badge-role">
                                                        <i class="fas <%= roleIcon %> me-1"></i>
                                                        <%= user.getRole().toUpperCase() %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <i class="fas fa-phone me-1 text-muted"></i>
                                                    <%= user.getPhone() %>
                                                </td>
                                                <td>
                                                    <%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %>
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary btn-action" 
                                                            onclick="editUser(<%= user.getUserId() %>)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <% if (!"admin".equals(user.getRole())) { %>
                                                        <button class="btn btn-sm btn-outline-danger btn-action" 
                                                                onclick="deleteUser(<%= user.getUserId() %>)">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">No users found</h5>
                                <p class="text-muted">Add your first user to get started!</p>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                    <i class="fas fa-user-plus me-2"></i>Add First User
                                </button>
                            </div>
                        <% } %>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-user-plus me-2"></i>Add New User
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="../user" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-control" name="role" required>
                                    <option value="user">User</option>
                                    <option value="trainer">Trainer</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Phone</label>
                                <input type="tel" class="form-control" name="phone" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Add User
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editUser(id) {
            // TODO: Implement edit functionality
            alert('Edit user functionality coming soon! User ID: ' + id);
        }
        
        function deleteUser(id) {
            if (confirm('Are you sure you want to delete this user?')) {
                window.location.href = '../user?action=delete&id=' + id;
            }
        }
    </script>
</body>
</html>
