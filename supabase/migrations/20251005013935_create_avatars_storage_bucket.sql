/*
  # Create storage bucket for avatars

  1. New Storage Bucket
    - Create `avatars` bucket for storing user profile pictures
    - Set bucket to public so avatar images can be displayed
    - Allow authenticated users to upload their own avatars

  2. Security
    - RLS policies ensure users can only upload/update their own avatars
    - Public read access for displaying avatars
    - Maximum file size enforced at application level (2MB)
*/

INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Users can upload their own avatar"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = 'avatars'
  AND auth.uid()::text = (regexp_match(name, '^avatars/([^-]+)-'))[1]
);

CREATE POLICY "Users can update their own avatar"
ON storage.objects
FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars'
  AND (storage.foldername(name))[1] = 'avatars'
  AND auth.uid()::text = (regexp_match(name, '^avatars/([^-]+)-'))[1]
);

CREATE POLICY "Anyone can view avatars"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'avatars');