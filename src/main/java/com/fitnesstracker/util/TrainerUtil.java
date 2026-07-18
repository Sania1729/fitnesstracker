package com.fitnesstracker.util;

import com.fitnesstracker.dto.TrainerDTO;
import com.fitnesstracker.dao.TrainerDAO;
import java.util.List;

public class TrainerUtil {
    
    public static int getTrainerIdByName(String userName) {
        TrainerDAO trainerDAO = new TrainerDAO();
        List<TrainerDTO> trainers = trainerDAO.getAllTrainers();
        
        System.out.println("Looking for trainer with name: " + userName);
        
        for (TrainerDTO trainer : trainers) {
            System.out.println("Found trainer: " + trainer.getName() + " with ID: " + trainer.getTrainerId());
            if (trainer.getName().equals(userName)) {
                System.out.println("Matched trainer ID: " + trainer.getTrainerId());
                return trainer.getTrainerId();
            }
        }
        
        System.out.println("No trainer found for user: " + userName);
        return -1;
    }
    
    public static int getTrainerIdByEmail(String userEmail) {
        TrainerDAO trainerDAO = new TrainerDAO();
        List<TrainerDTO> trainers = trainerDAO.getAllTrainers();
        
        for (TrainerDTO trainer : trainers) {
            // You might need to add email to trainers table for this to work
            // For now, we'll use name matching
        }
        
        return -1;
    }
    
    public static boolean createTrainerForUser(String userName, String phone) {
        try {
            TrainerDAO trainerDAO = new TrainerDAO();
            TrainerDTO trainer = new TrainerDTO();
            trainer.setName(userName);
            trainer.setSpecialization("General Fitness");
            trainer.setExperience(0);
            trainer.setPhone(phone);
            
            return trainerDAO.addTrainer(trainer);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
