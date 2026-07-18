package com.fitnesstracker.controller;

import com.fitnesstracker.dto.DietDTO;
import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.dao.DietDAO;
import com.fitnesstracker.dao.TrainerDAO;
import com.fitnesstracker.util.TrainerUtil;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/diet/*")
public class DietController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DietDAO dietDAO;
    private TrainerDAO trainerDAO;
    
    public void init() {
        dietDAO = new DietDAO();
        trainerDAO = new TrainerDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            HttpSession session = request.getSession();
            String userName = (String) session.getAttribute("userName");
            
            // Try to get trainer ID
            int trainerId = TrainerUtil.getTrainerIdByName(userName);
            
            // If trainer not found, create one
            if (trainerId == -1) {
                String userPhone = (String) session.getAttribute("userPhone");
                if (userPhone == null) userPhone = "0000000000"; // Default phone
                
                boolean created = TrainerUtil.createTrainerForUser(userName, userPhone);
                if (created) {
                    // Try again to get the trainer ID
                    trainerId = TrainerUtil.getTrainerIdByName(userName);
                }
            }
            
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
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if ("/list".equals(pathInfo)) {
            HttpSession session = request.getSession();
            Integer trainerId = (Integer) session.getAttribute("trainerId");
            
            if (trainerId != null) {
                List<DietDTO> diets = dietDAO.getDietPlansByTrainer(trainerId);
                request.setAttribute("diets", diets);
                request.getRequestDispatcher("../trainer/view-diets.jsp").forward(request, response);
            } else {
                response.sendRedirect("../login.jsp");
            }
        } else if ("/user-view".equals(pathInfo)) {
            List<DietDTO> diets = dietDAO.getAllDietPlans();
            request.setAttribute("diets", diets);
            request.getRequestDispatcher("../user/view-diets.jsp").forward(request, response);
        }
    }
}
