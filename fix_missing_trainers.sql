-- Fix missing trainer records for existing trainer users
USE fitness_db;

-- Insert trainer records for users that have role='trainer' but no corresponding trainer record
INSERT INTO trainers (name, specialization, experience, phone)
SELECT 
    u.name,
    'General Fitness' as specialization,
    0 as experience,
    u.phone
FROM users u
WHERE u.role = 'trainer' 
AND NOT EXISTS (
    SELECT 1 FROM trainers t WHERE t.name = u.name
);

-- Show the results
SELECT 'Trainer records created:' as message;

-- Show all trainer users
SELECT 'Trainer Users:' as info;
SELECT user_id, name, email, phone FROM users WHERE role = 'trainer';

-- Show all trainer records
SELECT 'Trainer Records:' as info;
SELECT trainer_id, name, specialization, experience, phone FROM trainers;

-- Show any remaining mismatches
SELECT 'Remaining mismatches (should be empty):' as info;
SELECT 
    u.user_id, 
    u.name as user_name, 
    u.email,
    t.trainer_id,
    t.name as trainer_name
FROM users u
LEFT JOIN trainers t ON u.name = t.name
WHERE u.role = 'trainer' AND t.trainer_id IS NULL;
