import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string;
          username: string;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          username: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          username?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      categories: {
        Row: {
          id: string;
          name: string;
          description: string;
          svg_icon: string;
          created_at: string;
        };
      };
      questions: {
        Row: {
          id: string;
          category_id: string;
          question_text: string;
          options: string[];
          correct_answer: string;
          difficulty: 'easy' | 'medium' | 'hard';
          created_at: string;
        };
      };
      quiz_attempts: {
        Row: {
          id: string;
          user_id: string;
          category_id: string;
          difficulty: 'easy' | 'medium' | 'hard';
          total_questions: number;
          correct_answers: number;
          completed: boolean;
          started_at: string;
          completed_at: string | null;
        };
        Insert: {
          id?: string;
          user_id: string;
          category_id: string;
          difficulty: 'easy' | 'medium' | 'hard';
          total_questions: number;
          correct_answers?: number;
          completed?: boolean;
          started_at?: string;
          completed_at?: string | null;
        };
        Update: {
          correct_answers?: number;
          completed?: boolean;
          completed_at?: string | null;
        };
      };
    };
  };
};
