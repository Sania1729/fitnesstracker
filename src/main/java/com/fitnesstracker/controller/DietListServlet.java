package com.fitnesstracker.controller;

import com.fitnesstracker.dto.DietDTO;
import com.fitnesstracker.dao.DietDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/diet-list")
public class DietListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DietDAO dietDAO;
    
    public void init() {
        dietDAO = new DietDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== DietListServlet START ===");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        
        System.out.println("DietListServlet - userName from session: " + userName);
        
        if (userName == null) {
            System.out.println("DietListServlet - No userName in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get trainer ID by name
        int trainerId = TrainerUtil.getTrainerIdByName(userName);
        
        System.out.println("DietListServlet - trainerId found: " + trainerId);
        
        if (trainerId == -1) {
            System.out.println("DietListServlet - No trainer found, redirecting to dashboard with error");
            response.sendRedirect("trainer-dashboard.jsp?error=trainer_not_found");
            return;
        }
        
        List<DietDTO> diets = dietDAO.getDietPlansByTrainer(trainerId);
        
        System.out.println("DietListServlet - diets retrieved: " + (diets != null ? diets.size() : "null"));
        
        request.setAttribute("diets", diets);
        request.getRequestDispatcher("diet-list-simple.jsp").forward(request, response);
        
        System.out.println("=== DietListServlet END ===");
    }
}
