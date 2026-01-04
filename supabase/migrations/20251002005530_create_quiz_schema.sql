/*
  # Quiz Application Database Schema

  ## Overview
  This migration creates the complete database schema for a quiz application with user authentication,
  quiz categories, questions, and attempt tracking.

  ## New Tables
  
  ### 1. `profiles`
  Stores user profile information extending Supabase auth.users
  - `id` (uuid, primary key) - References auth.users
  - `username` (text, unique) - User's display name
  - `created_at` (timestamptz) - Account creation timestamp
  - `updated_at` (timestamptz) - Last profile update

  ### 2. `categories`
  Quiz categories with metadata
  - `id` (uuid, primary key)
  - `name` (text, unique) - Category name (e.g., "Science", "Technology")
  - `description` (text) - Category description
  - `svg_icon` (text) - SVG markup for category icon
  - `created_at` (timestamptz)

  ### 3. `questions`
  Quiz questions for each category
  - `id` (uuid, primary key)
  - `category_id` (uuid) - Foreign key to categories
  - `question_text` (text) - The question
  - `options` (jsonb) - Array of answer options
  - `correct_answer` (text) - The correct answer
  - `difficulty` (text) - 'easy', 'medium', or 'hard'
  - `created_at` (timestamptz)

  ### 4. `quiz_attempts`
  Tracks user quiz attempts
  - `id` (uuid, primary key)
  - `user_id` (uuid) - Foreign key to profiles
  - `category_id` (uuid) - Foreign key to categories
  - `difficulty` (text) - Selected difficulty level
  - `total_questions` (integer) - Number of questions in attempt
  - `correct_answers` (integer) - Number of correct answers
  - `completed` (boolean) - Whether quiz was completed
  - `started_at` (timestamptz) - When quiz started
  - `completed_at` (timestamptz) - When quiz finished

  ## Security
  - RLS enabled on all tables
  - Users can only access their own profile and quiz attempts
  - Categories and questions are readable by all authenticated users
  - Only authenticated users can create quiz attempts
*/

-- Create profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  description text NOT NULL,
  svg_icon text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Categories are viewable by authenticated users"
  ON categories FOR SELECT
  TO authenticated
  USING (true);

-- Create questions table
CREATE TABLE IF NOT EXISTS questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id uuid NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  question_text text NOT NULL,
  options jsonb NOT NULL,
  correct_answer text NOT NULL,
  difficulty text NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Questions are viewable by authenticated users"
  ON questions FOR SELECT
  TO authenticated
  USING (true);

-- Create quiz_attempts table
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  category_id uuid NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  difficulty text NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  total_questions integer NOT NULL DEFAULT 0,
  correct_answers integer NOT NULL DEFAULT 0,
  completed boolean DEFAULT false,
  started_at timestamptz DEFAULT now(),
  completed_at timestamptz
);

ALTER TABLE quiz_attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own quiz attempts"
  ON quiz_attempts FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own quiz attempts"
  ON quiz_attempts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own quiz attempts"
  ON quiz_attempts FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_questions_category ON questions(category_id);
CREATE INDEX IF NOT EXISTS idx_questions_difficulty ON questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_user ON quiz_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_category ON quiz_attempts(category_id);
