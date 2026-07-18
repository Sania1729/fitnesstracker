-- Debug script to check database state
USE fitness_db;

-- Check users table
SELECT 'USERS TABLE:' as info;
SELECT user_id, name, email, role, phone FROM users WHERE role = 'trainer';

-- Check trainers table
SELECT 'TRAINERS TABLE:' as info;
SELECT trainer_id, name, specialization, experience, phone FROM trainers;

-- Check if there are any matching names
SELECT 'NAME MATCHES:' as info;
SELECT 
    u.user_id, 
    u.name as user_name, 
    u.email, 
    u.phone as user_phone,
    t.trainer_id,
    t.name as trainer_name,
    t.phone as trainer_phone
FROM users u
LEFT JOIN trainers t ON u.name = t.name
WHERE u.role = 'trainer';

-- Check workout table
SELECT 'WORKOUT TABLE:' as info;
SELECT workout_id, exercise_name, trainer_id FROM workout;

-- Check diet_plan table
SELECT 'DIET_PLAN TABLE:' as info;
SELECT diet_id, meal_name, trainer_id FROM diet_plan;
