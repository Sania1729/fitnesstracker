package com.fitnesstracker.dto;

public class DietDTO {
    private int dietId;
    private String mealName;
    private int calories;
    private double protein;
    private double carbs;
    private double fats;
    private int trainerId;
    
    public DietDTO() {}
    
    public DietDTO(int dietId, String mealName, int calories, double protein, double carbs, double fats, int trainerId) {
        this.dietId = dietId;
        this.mealName = mealName;
        this.calories = calories;
        this.protein = protein;
        this.carbs = carbs;
        this.fats = fats;
        this.trainerId = trainerId;
    }
    
    // Getters and Setters
    public int getDietId() { return dietId; }
    public void setDietId(int dietId) { this.dietId = dietId; }
    
    public String getMealName() { return mealName; }
    public void setMealName(String mealName) { this.mealName = mealName; }
    
    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }
    
    public double getProtein() { return protein; }
    public void setProtein(double protein) { this.protein = protein; }
    
    public double getCarbs() { return carbs; }
    public void setCarbs(double carbs) { this.carbs = carbs; }
    
    public double getFats() { return fats; }
    public void setFats(double fats) { this.fats = fats; }
    
    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }
}
