package com.fitnesstracker.controller;

import com.fitnesstracker.dto.DietDTO;
import com.fitnesstracker.dao.DietDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-diet")
public class AddDietServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DietDAO dietDAO;
    
    public void init() {
        dietDAO = new DietDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        
        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get trainer ID by name
        int trainerId = TrainerUtil.getTrainerIdByName(userName);
        
        if (trainerId == -1) {
            response.sendRedirect("trainer-dashboard.jsp?error=trainer_not_found");
            return;
        }
        
        String mealName = request.getParameter("mealName");
        int calories = Integer.parseInt(request.getParameter("calories"));
        double protein = Double.parseDouble(request.getParameter("protein"));
        double carbs = Double.parseDouble(request.getParameter("carbs"));
        double fats = Double.parseDouble(request.getParameter("fats"));
        
        DietDTO diet = new DietDTO();
        diet.setMealName(mealName);
        diet.setCalories(calories);
        diet.setProtein(protein);
        diet.setCarbs(carbs);
        diet.setFats(fats);
        diet.setTrainerId(trainerId);
        
        boolean success = dietDAO.addDietPlan(diet);
        
        if (success) {
            response.sendRedirect("trainer-dashboard.jsp?message=diet_added");
        } else {
            response.sendRedirect("trainer-dashboard.jsp?error=diet_failed");
        }
    }
}
