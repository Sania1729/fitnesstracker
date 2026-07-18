package com.fitnesstracker.dao;

import com.fitnesstracker.dto.DietDTO;
import com.fitnesstracker.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DietDAO {
    
    public boolean addDietPlan(DietDTO diet) {
        String sql = "INSERT INTO diet_plan (meal_name, calories, protein, carbs, fats, trainer_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, diet.getMealName());
            pstmt.setInt(2, diet.getCalories());
            pstmt.setDouble(3, diet.getProtein());
            pstmt.setDouble(4, diet.getCarbs());
            pstmt.setDouble(5, diet.getFats());
            pstmt.setInt(6, diet.getTrainerId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<DietDTO> getDietPlansByTrainer(int trainerId) {
        List<DietDTO> dietPlans = new ArrayList<>();
        String sql = "SELECT * FROM diet_plan WHERE trainer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, trainerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                dietPlans.add(extractDietFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dietPlans;
    }
    
    public List<DietDTO> getAllDietPlans() {
        List<DietDTO> dietPlans = new ArrayList<>();
        String sql = "SELECT * FROM diet_plan";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                dietPlans.add(extractDietFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dietPlans;
    }
    
    public boolean updateDietPlan(DietDTO diet) {
        String sql = "UPDATE diet_plan SET meal_name = ?, calories = ?, protein = ?, carbs = ?, fats = ?, trainer_id = ? WHERE diet_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, diet.getMealName());
            pstmt.setInt(2, diet.getCalories());
            pstmt.setDouble(3, diet.getProtein());
            pstmt.setDouble(4, diet.getCarbs());
            pstmt.setDouble(5, diet.getFats());
            pstmt.setInt(6, diet.getTrainerId());
            pstmt.setInt(7, diet.getDietId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteDietPlan(int dietId) {
        String sql = "DELETE FROM diet_plan WHERE diet_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, dietId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public DietDTO getDietPlanById(int dietId) {
        String sql = "SELECT * FROM diet_plan WHERE diet_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, dietId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractDietFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private DietDTO extractDietFromResultSet(ResultSet rs) throws SQLException {
        return new DietDTO(
            rs.getInt("diet_id"),
            rs.getString("meal_name"),
            rs.getInt("calories"),
            rs.getDouble("protein"),
            rs.getDouble("carbs"),
            rs.getDouble("fats"),
            rs.getInt("trainer_id")
        );
    }
}
