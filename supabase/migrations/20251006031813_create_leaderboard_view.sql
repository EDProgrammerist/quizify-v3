/*
  # Create Leaderboard View and Policies

  ## Overview
  Creates a materialized view for the leaderboard showing top performers across the quiz application.
  
  ## New Database Objects
  
  ### 1. `leaderboard` (View)
  A view that aggregates quiz performance metrics per user
  - `user_id` (uuid) - User identifier
  - `username` (text) - User display name
  - `avatar_url` (text) - User avatar URL
  - `total_quizzes` (bigint) - Total number of completed quizzes
  - `total_correct` (bigint) - Total correct answers
  - `total_questions` (bigint) - Total questions attempted
  - `accuracy_percentage` (numeric) - Overall accuracy rate
  - `average_score` (numeric) - Average score per quiz
  - `last_active` (timestamptz) - Most recent quiz completion time
  
  ## Security
  - View is readable by all authenticated users
  - RLS policy allows authenticated users to see all leaderboard entries
  
  ## Notes
  - Only includes completed quizzes
  - Accuracy percentage is calculated as (correct/total * 100)
  - Users with no completed quizzes won't appear in leaderboard
*/

-- Create leaderboard view
CREATE OR REPLACE VIEW leaderboard AS
SELECT 
  p.id as user_id,
  p.username,
  p.avatar_url,
  COUNT(qa.id) as total_quizzes,
  SUM(qa.correct_answers) as total_correct,
  SUM(qa.total_questions) as total_questions,
  ROUND(
    CASE 
      WHEN SUM(qa.total_questions) > 0 
      THEN (SUM(qa.correct_answers)::numeric / SUM(qa.total_questions)::numeric * 100)
      ELSE 0 
    END, 
    2
  ) as accuracy_percentage,
  ROUND(
    AVG(
      CASE 
        WHEN qa.total_questions > 0 
        THEN (qa.correct_answers::numeric / qa.total_questions::numeric * 100)
        ELSE 0 
      END
    ), 
    2
  ) as average_score,
  MAX(qa.completed_at) as last_active
FROM profiles p
INNER JOIN quiz_attempts qa ON p.id = qa.user_id
WHERE qa.completed = true AND qa.completed_at IS NOT NULL
GROUP BY p.id, p.username, p.avatar_url
HAVING COUNT(qa.id) > 0
ORDER BY accuracy_percentage DESC, total_correct DESC, total_quizzes DESC;

-- Grant access to authenticated users
GRANT SELECT ON leaderboard TO authenticated;