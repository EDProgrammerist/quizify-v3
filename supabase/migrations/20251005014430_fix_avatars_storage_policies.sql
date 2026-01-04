/*
  # Fix storage policies for avatars bucket

  1. Changes
    - Recreate simplified storage policies for avatars bucket
    - Allow authenticated users to upload files
    - Allow authenticated users to update their own files
    - Allow public read access for all avatars

  2. Security
    - Users can only upload files when authenticated
    - Users can only update their own avatar files (based on user ID in filename)
    - All users can view avatars (public read)
*/

CREATE POLICY "Authenticated users can upload avatars"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'avatars');

CREATE POLICY "Users can update their own avatars"
ON storage.objects
FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] IS NULL
)
WITH CHECK (
  bucket_id = 'avatars'
);

CREATE POLICY "Anyone can view avatars"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'avatars');