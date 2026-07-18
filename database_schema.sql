-- Fitness Tracker Database Schema
-- MySQL Database

-- Create Database
CREATE DATABASE IF NOT EXISTS fitness_db;
USE fitness_db;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'trainer', 'user') NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trainers Table
CREATE TABLE trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience INT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Workout Table
CREATE TABLE workout (
    workout_id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_name VARCHAR(100) NOT NULL,
    sets INT NOT NULL,
    reps INT NOT NULL,
    duration INT NOT NULL COMMENT 'Duration in minutes',
    trainer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) ON DELETE CASCADE
);

-- Diet Plan Table
CREATE TABLE diet_plan (
    diet_id INT AUTO_INCREMENT PRIMARY KEY,
    meal_name VARCHAR(100) NOT NULL,
    calories INT NOT NULL,
    protein DECIMAL(5,2) NOT NULL,
    carbs DECIMAL(5,2) NOT NULL,
    fats DECIMAL(5,2) NOT NULL,
    trainer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) ON DELETE CASCADE
);

-- Insert Sample Data

-- Insert Admin User
INSERT INTO users (name, email, password, role, phone) VALUES
('Admin User', 'admin@fitness.com', 'admin123', 'admin', '1234567890');

-- Insert Sample Trainers
INSERT INTO trainers (name, specialization, experience, phone) VALUES
('John Smith', 'Strength Training', 10, '9876543210'),
('Sarah Johnson', 'Yoga & Pilates', 8, '9876543211'),
('Mike Wilson', 'Cardio & CrossFit', 12, '9876543212');

-- Insert Sample Users
INSERT INTO users (name, email, password, role, phone) VALUES
('Alice Brown', 'alice@fitness.com', 'alice123', 'user', '5555555555'),
('Bob Johnson', 'bob@fitness.com', 'bob123', 'user', '5555555556'),
('Carol White', 'carol@fitness.com', 'carol123', 'trainer', '5555555557');

-- Insert Sample Workouts
INSERT INTO workout (exercise_name, sets, reps, duration, trainer_id) VALUES
('Push-ups', 3, 15, 10, 1),
('Squats', 4, 12, 15, 1),
('Deadlifts', 3, 8, 20, 1),
('Yoga Flow', 1, 1, 60, 2),
('HIIT Cardio', 5, 20, 30, 3);

-- Insert Sample Diet Plans
INSERT INTO diet_plan (meal_name, calories, protein, carbs, fats, trainer_id) VALUES
('Protein Breakfast Bowl', 450, 30.5, 45.2, 15.8, 1),
('Grilled Chicken Salad', 380, 42.1, 25.3, 18.5, 1),
('Vegetarian Buddha Bowl', 420, 18.5, 52.3, 16.8, 2),
('Salmon and Quinoa', 480, 38.2, 35.6, 22.1, 3);

-- Create Indexes for Better Performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_workout_trainer ON workout(trainer_id);
CREATE INDEX idx_diet_trainer ON diet_plan(trainer_id);

-- Database Setup Complete
SELECT 'Fitness Tracker Database Setup Complete!' AS message;
