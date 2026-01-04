import { supabase } from './supabase';

export interface LeaderboardEntry {
  user_id: string;
  username: string;
  avatar_url: string | null;
  total_quizzes: number;
  total_correct: number;
  total_questions: number;
  accuracy_percentage: number;
  average_score: number;
  last_active: string;
}

export async function fetchLeaderboard(limit = 100): Promise<LeaderboardEntry[]> {
  const { data, error } = await supabase
    .from('leaderboard')
    .select('*')
    .limit(limit);

  if (error) {
    console.error('Error fetching leaderboard:', error);
    return [];
  }

  return data || [];
}

export async function getUserRank(userId: string): Promise<number | null> {
  const leaderboard = await fetchLeaderboard();
  const rank = leaderboard.findIndex(entry => entry.user_id === userId);
  return rank === -1 ? null : rank + 1;
}
