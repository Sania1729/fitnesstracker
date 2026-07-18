package com.fitnesstracker.dao;

import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrainerDAO {
    
    public boolean addTrainer(TrainerDTO trainer) {
        String sql = "INSERT INTO trainers (name, specialization, experience, phone) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, trainer.getName());
            pstmt.setString(2, trainer.getSpecialization());
            pstmt.setInt(3, trainer.getExperience());
            pstmt.setString(4, trainer.getPhone());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<TrainerDTO> getAllTrainers() {
        List<TrainerDTO> trainers = new ArrayList<>();
        String sql = "SELECT * FROM trainers";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                trainers.add(extractTrainerFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainers;
    }
    
    public boolean updateTrainer(TrainerDTO trainer) {
        String sql = "UPDATE trainers SET name = ?, specialization = ?, experience = ?, phone = ? WHERE trainer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, trainer.getName());
            pstmt.setString(2, trainer.getSpecialization());
            pstmt.setInt(3, trainer.getExperience());
            pstmt.setString(4, trainer.getPhone());
            pstmt.setInt(5, trainer.getTrainerId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteTrainer(int trainerId) {
        String sql = "DELETE FROM trainers WHERE trainer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, trainerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public TrainerDTO getTrainerById(int trainerId) {
        String sql = "SELECT * FROM trainers WHERE trainer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, trainerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractTrainerFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private TrainerDTO extractTrainerFromResultSet(ResultSet rs) throws SQLException {
        return new TrainerDTO(
            rs.getInt("trainer_id"),
            rs.getString("name"),
            rs.getString("specialization"),
            rs.getInt("experience"),
            rs.getString("phone")
        );
    }
}
