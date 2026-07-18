-- =====================================================
-- Fitness Tracker Database Setup Script
-- =====================================================
-- This script creates the complete database structure
-- for the Fitness Tracker application with sample data

---- Create Database
--CREATE DATABASE IF NOT EXISTS fitness_db;
--USE fitness_db;

-- =====================================================
-- Table Structures
-- =====================================================

-- Users Table - Stores user authentication and profile information
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'trainer', 'user') NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trainers Table - Stores trainer professional information
CREATE TABLE trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience INT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Workout Table - Stores workout programs created by trainers
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

-- Diet Plan Table - Stores nutrition plans created by trainers
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

-- =====================================================
-- Sample Data Insertion
-- =====================================================

-- Insert Users (Admin, Trainers, and Regular Users)
INSERT INTO users (name, email, password, role, phone) VALUES
('Admin User', 'admin@fitness.com', 'admin123', 'admin', '1234567890'),
('Alice Brown', 'alice@fitness.com', 'alice123', 'user', '5555555555'),
('Bob Johnson', 'bob@fitness.com', 'bob123', 'user', '5555555556'),
('Carol White', 'carol@fitness.com', 'carol123', 'trainer', '5555555557'),
('David Green', 'david@fitness.com', 'david123', 'user', '5555555558');

-- Insert Trainers
INSERT INTO trainers (name, specialization, experience, phone) VALUES
('John Smith', 'Strength Training', 10, '9876543210'),
('Sarah Johnson', 'Yoga & Pilates', 8, '9876543211'),
('Mike Wilson', 'Cardio & CrossFit', 12, '9876543212'),
('Emily Davis', 'Nutrition & Diet', 6, '9876543213');

-- Insert Workout Programs
INSERT INTO workout (exercise_name, sets, reps, duration, trainer_id) VALUES
('Push-ups', 3, 15, 10, 1),
('Squats', 4, 12, 15, 1),
('Deadlifts', 3, 8, 20, 1),
('Bench Press', 3, 10, 15, 1),
('Pull-ups', 3, 12, 10, 1),
('Yoga Flow', 1, 1, 60, 2),
('Pilates Core', 3, 15, 30, 2),
('Stretching Routine', 1, 1, 20, 2),
('HIIT Cardio', 5, 20, 30, 3),
('Running Intervals', 6, 1, 25, 3),
('Boxing Workout', 8, 3, 35, 3),
('CrossFit WOD', 5, 10, 40, 3);

-- Insert Diet Plans
INSERT INTO diet_plan (meal_name, calories, protein, carbs, fats, trainer_id) VALUES
('Protein Breakfast Bowl', 450, 30.5, 45.2, 15.8, 1),
('Grilled Chicken Salad', 380, 42.1, 25.3, 18.5, 1),
('Beef Stir Fry', 520, 45.8, 35.6, 22.1, 1),
('Protein Shake', 320, 35.8, 28.4, 8.2, 1),
('Vegetarian Buddha Bowl', 420, 18.5, 52.3, 16.8, 2),
('Quinoa Salad', 380, 22.3, 48.5, 14.2, 2),
('Green Smoothie', 280, 15.2, 35.8, 8.5, 2),
('Tofu Scramble', 350, 25.4, 28.6, 18.3, 2),
('Salmon and Quinoa', 480, 38.2, 35.6, 22.1, 3),
('Greek Yogurt Parfait', 320, 28.5, 42.3, 12.8, 3),
('Egg White Omelette', 290, 24.3, 18.5, 15.2, 3),
('Protein Pancakes', 410, 32.1, 38.7, 14.5, 3),
('Chicken Wrap', 440, 35.6, 32.4, 18.9, 4),
('Energy Bowl', 390, 22.8, 45.2, 16.3, 4),
('Recovery Smoothie', 340, 28.9, 38.5, 10.2, 4);

-- =====================================================
-- Indexes for Performance Optimization
-- =====================================================

-- Create indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_name ON users(name);

CREATE INDEX idx_trainers_name ON trainers(name);
CREATE INDEX idx_trainers_specialization ON trainers(specialization);

CREATE INDEX idx_workout_trainer ON workout(trainer_id);
CREATE INDEX idx_workout_exercise ON workout(exercise_name);
CREATE INDEX idx_workout_duration ON workout(duration);

CREATE INDEX idx_diet_trainer ON diet_plan(trainer_id);
CREATE INDEX idx_diet_meal ON diet_plan(meal_name);
CREATE INDEX idx_diet_calories ON diet_plan(calories);

-- =====================================================
-- Views for Common Queries (Optional)
-- =====================================================

-- View for trainer details with their workout and diet counts
CREATE VIEW trainer_summary AS
SELECT 
    t.trainer_id,
    t.name,
    t.specialization,
    t.experience,
    t.phone,
    COUNT(DISTINCT w.workout_id) AS workout_count,
    COUNT(DISTINCT d.diet_id) AS diet_count
FROM trainers t
LEFT JOIN workout w ON t.trainer_id = w.trainer_id
LEFT JOIN diet_plan d ON t.trainer_id = d.trainer_id
GROUP BY t.trainer_id, t.name, t.specialization, t.experience, t.phone;

-- View for user statistics
CREATE VIEW user_stats AS
SELECT 
    role,
    COUNT(*) as count,
    created_at
FROM users
GROUP BY role, created_at;

-- =====================================================
-- Stored Procedures (Optional)
-- =====================================================

DELIMITER //

-- Procedure to get all workouts by trainer
CREATE PROCEDURE GetWorkoutsByTrainer(IN trainer_id_param INT)
BEGIN
    SELECT 
        w.workout_id,
        w.exercise_name,
        w.sets,
        w.reps,
        w.duration,
        w.created_at,
        t.name AS trainer_name
    FROM workout w
    JOIN trainers t ON w.trainer_id = t.trainer_id
    WHERE w.trainer_id = trainer_id_param
    ORDER BY w.exercise_name;
END //

-- Procedure to get all diet plans by trainer
CREATE PROCEDURE GetDietPlansByTrainer(IN trainer_id_param INT)
BEGIN
    SELECT 
        d.diet_id,
        d.meal_name,
        d.calories,
        d.protein,
        d.carbs,
        d.fats,
        d.created_at,
        t.name AS trainer_name
    FROM diet_plan d
    JOIN trainers t ON d.trainer_id = t.trainer_id
    WHERE d.trainer_id = trainer_id_param
    ORDER BY d.meal_name;
END //

-- Procedure to get database statistics
CREATE PROCEDURE GetDatabaseStats()
BEGIN
    SELECT 
        'Total Users' as metric,
        COUNT(*) as count
    FROM users
    
    UNION ALL
    
    SELECT 
        'Total Trainers' as metric,
        COUNT(*) as count
    FROM trainers
    
    UNION ALL
    
    SELECT 
        'Total Workouts' as metric,
        COUNT(*) as count
    FROM workout
    
    UNION ALL
    
    SELECT 
        'Total Diet Plans' as metric,
        COUNT(*) as count
    FROM diet_plan;
END //

DELIMITER ;

-- =====================================================
-- Triggers for Data Integrity (Optional)
-- =====================================================

DELIMITER //

-- Trigger to update created_at timestamp for users
CREATE TRIGGER before_user_insert 
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //

-- Trigger to update created_at timestamp for trainers
CREATE TRIGGER before_trainer_insert 
BEFORE INSERT ON trainers
FOR EACH ROW
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //

-- Trigger to update created_at timestamp for workout
CREATE TRIGGER before_workout_insert 
BEFORE INSERT ON workout
FOR EACH ROW
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //

-- Trigger to update created_at timestamp for diet_plan
CREATE TRIGGER before_diet_insert 
BEFORE INSERT ON diet_plan
FOR EACH ROW
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //

DELIMITER ;

-- =====================================================
-- Final Verification
-- =====================================================

-- Display setup completion message and statistics
SELECT 'Database setup completed successfully!' AS message;

SELECT 
    'users' as table_name,
    COUNT(*) as record_count
FROM users

UNION ALL

SELECT 
    'trainers' as table_name,
    COUNT(*) as record_count
FROM trainers

UNION ALL

SELECT 
    'workout' as table_name,
    COUNT(*) as record_count
FROM workout

UNION ALL

SELECT 
    'diet_plan' as table_name,
    COUNT(*) as record_count
FROM diet_plan;

-- =====================================================
-- Usage Instructions
-- =====================================================

/*
To run this script:

1. Open MySQL Command Line or MySQL Workbench
2. Login with your MySQL credentials:
   mysql -u root -p
   
3. Execute the script:
   source /path/to/database_setup.sql;
   
   OR in MySQL Workbench, copy and paste the entire script

4. Verify the setup:
   USE fitness_db;
   SHOW TABLES;
   
5. Check sample data:
   SELECT * FROM users;
   SELECT * FROM trainers;
   SELECT * FROM workout;
   SELECT * FROM diet_plan;

Database Connection Details:
- Host: localhost
- Port: 3306
- Database: fitness_db
- Username: root
- Password: penta@123 (as configured in DBUtil.java)

Default Login Credentials:
- Admin: admin@fitness.com / admin123
- User: alice@fitness.com / alice123
- Trainer: carol@fitness.com / carol123
*/
