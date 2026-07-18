package com.fitnesstracker.dto;

public class WorkoutDTO {
    private int workoutId;
    private String exerciseName;
    private int sets;
    private int reps;
    private int duration;
    private int trainerId;
    
    public WorkoutDTO() {}
    
    public WorkoutDTO(int workoutId, String exerciseName, int sets, int reps, int duration, int trainerId) {
        this.workoutId = workoutId;
        this.exerciseName = exerciseName;
        this.sets = sets;
        this.reps = reps;
        this.duration = duration;
        this.trainerId = trainerId;
    }
    
    // Getters and Setters
    public int getWorkoutId() { return workoutId; }
    public void setWorkoutId(int workoutId) { this.workoutId = workoutId; }
    
    public String getExerciseName() { return exerciseName; }
    public void setExerciseName(String exerciseName) { this.exerciseName = exerciseName; }
    
    public int getSets() { return sets; }
    public void setSets(int sets) { this.sets = sets; }
    
    public int getReps() { return reps; }
    public void setReps(int reps) { this.reps = reps; }
    
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    
    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }
}
