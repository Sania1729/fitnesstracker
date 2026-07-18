package com.fitnesstracker.dto;

public class TrainerDTO {
    private int trainerId;
    private String name;
    private String specialization;
    private int experience;
    private String phone;
    
    public TrainerDTO() {}
    
    public TrainerDTO(int trainerId, String name, String specialization, int experience, String phone) {
        this.trainerId = trainerId;
        this.name = name;
        this.specialization = specialization;
        this.experience = experience;
        this.phone = phone;
    }
    
    // Getters and Setters
    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
    
    public int getExperience() { return experience; }
    public void setExperience(int experience) { this.experience = experience; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
