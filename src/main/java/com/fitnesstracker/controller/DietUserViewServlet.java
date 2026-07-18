package com.fitnesstracker.controller;

import com.fitnesstracker.dto.DietDTO;
import com.fitnesstracker.dao.DietDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/diet-user-view")
public class DietUserViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DietDAO dietDAO;
    
    public void init() {
        dietDAO = new DietDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== DietUserViewServlet START ===");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("DietUserViewServlet - userName: " + userName);
        System.out.println("DietUserViewServlet - userRole: " + userRole);
        
        if (userName == null) {
            System.out.println("DietUserViewServlet - No user in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get all diet plans for user view
        List<DietDTO> diets = dietDAO.getAllDietPlans();
        
        System.out.println("DietUserViewServlet - diets retrieved: " + (diets != null ? diets.size() : "null"));
        
        request.setAttribute("diets", diets);
        request.getRequestDispatcher("diet-user-view.jsp").forward(request, response);
        
        System.out.println("=== DietUserViewServlet END ===");
    }
}
