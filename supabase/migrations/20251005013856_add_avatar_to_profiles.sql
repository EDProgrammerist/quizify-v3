/*
  # Add avatar support to profiles

  1. Changes
    - Add `avatar_url` column to `profiles` table to store user profile pictures
    - Users can have their Google profile picture URL or upload custom picture
    - Column is nullable to support users without avatars

  2. Notes
    - For Google OAuth users, this will store their Google profile picture URL
    - For users without Google pictures, they can upload custom avatars
    - Avatar URLs can be from Google or from Supabase Storage
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'profiles' AND column_name = 'avatar_url'
  ) THEN
    ALTER TABLE profiles ADD COLUMN avatar_url text;
  END IF;
END $$;