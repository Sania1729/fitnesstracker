package com.fitnesstracker.dao;

import com.fitnesstracker.dto.WorkoutDTO;
import com.fitnesstracker.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorkoutDAO {
    
    public boolean addWorkout(WorkoutDTO workout) {
        String sql = "INSERT INTO workout (exercise_name, sets, reps, duration, trainer_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, workout.getExerciseName());
            pstmt.setInt(2, workout.getSets());
            pstmt.setInt(3, workout.getReps());
            pstmt.setInt(4, workout.getDuration());
            pstmt.setInt(5, workout.getTrainerId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<WorkoutDTO> getWorkoutsByTrainer(int trainerId) {
        List<WorkoutDTO> workouts = new ArrayList<>();
        String sql = "SELECT * FROM workout WHERE trainer_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, trainerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                workouts.add(extractWorkoutFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workouts;
    }
    
    public List<WorkoutDTO> getAllWorkouts() {
        List<WorkoutDTO> workouts = new ArrayList<>();
        String sql = "SELECT * FROM workout";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                workouts.add(extractWorkoutFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workouts;
    }
    
    public boolean updateWorkout(WorkoutDTO workout) {
        String sql = "UPDATE workout SET exercise_name = ?, sets = ?, reps = ?, duration = ?, trainer_id = ? WHERE workout_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, workout.getExerciseName());
            pstmt.setInt(2, workout.getSets());
            pstmt.setInt(3, workout.getReps());
            pstmt.setInt(4, workout.getDuration());
            pstmt.setInt(5, workout.getTrainerId());
            pstmt.setInt(6, workout.getWorkoutId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteWorkout(int workoutId) {
        String sql = "DELETE FROM workout WHERE workout_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, workoutId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public WorkoutDTO getWorkoutById(int workoutId) {
        String sql = "SELECT * FROM workout WHERE workout_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, workoutId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractWorkoutFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private WorkoutDTO extractWorkoutFromResultSet(ResultSet rs) throws SQLException {
        return new WorkoutDTO(
            rs.getInt("workout_id"),
            rs.getString("exercise_name"),
            rs.getInt("sets"),
            rs.getInt("reps"),
            rs.getInt("duration"),
            rs.getInt("trainer_id")
        );
    }
}
