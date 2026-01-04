'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/lib/supabase';
import { Navbar } from '@/components/Navbar';
import { ProfileAvatar } from '@/components/ProfileAvatar';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { CategoryStatsChart } from '@/components/charts/CategoryStatsChart';
import { Trophy, Target, CircleCheck as CheckCircle, Clock } from 'lucide-react';
import { format } from 'date-fns';

interface Profile {
  username: string;
  created_at: string;
  avatar_url: string | null;
}

interface QuizAttempt {
  id: string;
  category_id: string;
  difficulty: string;
  total_questions: number;
  correct_answers: number;
  completed: boolean;
  started_at: string;
  completed_at: string | null;
}

interface Category {
  id: string;
  name: string;
}

interface CategoryStats {
  name: string;
  attempts: number;
  completions: number;
  averageScore: number;
}

export default function StatsPage() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const [profile, setProfile] = useState<Profile | null>(null);
  const [attempts, setAttempts] = useState<QuizAttempt[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [loadingStats, setLoadingStats] = useState(true);

  useEffect(() => {
    if (!loading && !user) {
      router.push('/auth');
    }
  }, [user, loading, router]);

  useEffect(() => {
    if (user) {
      loadStats();
    }
  }, [user]);

  const loadStats = async () => {
    if (!user) return;

    const [profileRes, attemptsRes, categoriesRes] = await Promise.all([
      supabase.from('profiles').select('*').eq('id', user.id).maybeSingle(),
      supabase.from('quiz_attempts').select('*').eq('user_id', user.id).order('started_at', { ascending: false }),
      supabase.from('categories').select('id, name'),
    ]);

    if (profileRes.data) setProfile(profileRes.data);
    if (attemptsRes.data) setAttempts(attemptsRes.data);
    if (categoriesRes.data) setCategories(categoriesRes.data);

    setLoadingStats(false);
  };

  if (loading || loadingStats || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  const totalAttempts = attempts.length;
  const totalCompleted = attempts.filter((a) => a.completed).length;
  const completionRate = totalAttempts > 0 ? Math.round((totalCompleted / totalAttempts) * 100) : 0;

  const categoryStatsMap = new Map<string, CategoryStats>();

  categories.forEach((cat) => {
    const categoryAttempts = attempts.filter((a) => a.category_id === cat.id);
    const completedAttempts = categoryAttempts.filter((a) => a.completed);
    const totalScore = completedAttempts.reduce((sum, a) => sum + a.correct_answers, 0);
    const totalQuestions = completedAttempts.reduce((sum, a) => sum + a.total_questions, 0);
    const avgScore = totalQuestions > 0 ? Math.round((totalScore / totalQuestions) * 100) : 0;

    if (categoryAttempts.length > 0) {
      categoryStatsMap.set(cat.id, {
        name: cat.name,
        attempts: categoryAttempts.length,
        completions: completedAttempts.length,
        averageScore: avgScore,
      });
    }
  });

  const categoryStats = Array.from(categoryStatsMap.values());

  return (
    <div className="min-h-screen bg-white dark:bg-black">
      <Navbar />

      <main className="container mx-auto px-4 py-8">
        <div className="space-y-8">
          <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-primary/10 via-primary/5 to-transparent border-2 border-primary/20 p-8 mb-8">
            <div className="flex flex-col items-center gap-6">
              <ProfileAvatar
                avatarUrl={profile?.avatar_url}
                username={profile?.username || 'User'}
                editable={true}
                size="xl"
                onAvatarUpdate={(url) => {
                  if (profile) {
                    setProfile({ ...profile, avatar_url: url });
                  }
                }}
              />
              <div className="text-center space-y-2">
                <h2 className="text-3xl font-bold flex items-center justify-center gap-3">
                  {profile?.username || 'User'}
                </h2>
                <div className="flex items-center justify-center gap-2 text-sm text-muted-foreground">
                  <Clock className="w-4 h-4" />
                  Member since {profile ? format(new Date(profile.created_at), 'MMMM d, yyyy') : ''}
                </div>
              </div>
            </div>
          </div>

          <Card className="border-2">
            <CardHeader>
              <CardTitle>Overview</CardTitle>
              <CardDescription>A summary of your recent activity and performance</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="space-y-2 p-4 rounded-lg bg-primary/5 border border-primary/20">
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Target className="w-4 h-4" />
                    Total Attempts
                  </div>
                  <div className="text-3xl font-bold">{totalAttempts}</div>
                </div>

                <div className="space-y-2 p-4 rounded-lg bg-green-500/5 border border-green-500/20">
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <CheckCircle className="w-4 h-4" />
                    Completed
                  </div>
                  <div className="text-3xl font-bold">{totalCompleted}</div>
                </div>

                <div className="space-y-2 p-4 rounded-lg bg-blue-500/5 border border-blue-500/20">
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Trophy className="w-4 h-4" />
                    Completion Rate
                  </div>
                  <div className="text-3xl font-bold">{completionRate}%</div>
                </div>
              </div>
            </CardContent>
          </Card>

          <CategoryStatsChart
            data={categoryStats.map((stat) => ({
              name: stat.name,
              averageScore: stat.averageScore,
            }))}
            trendingUp={true}
            trendPercentage={5.2}
          />

          {categoryStats.length > 0 && (
            <Card className="border-2">
              <CardHeader>
                <CardTitle>Category Breakdown</CardTitle>
                <CardDescription>Detailed performance across all categories</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b">
                        <th className="text-left py-3 px-4 font-semibold">Category</th>
                        <th className="text-center py-3 px-4 font-semibold">Attempts</th>
                        <th className="text-center py-3 px-4 font-semibold">Completed</th>
                        <th className="text-center py-3 px-4 font-semibold">Success Rate</th>
                        <th className="text-center py-3 px-4 font-semibold">Average Score</th>
                      </tr>
                    </thead>
                    <tbody>
                      {categoryStats.map((stat) => (
                        <tr key={stat.name} className="border-b hover:bg-accent/50 transition-colors">
                          <td className="py-3 px-4">{stat.name}</td>
                          <td className="text-center py-3 px-4">{stat.attempts}</td>
                          <td className="text-center py-3 px-4">{stat.completions}</td>
                          <td className="text-center py-3 px-4">
                            {stat.attempts > 0 ? Math.round((stat.completions / stat.attempts) * 100) : 0}%
                          </td>
                          <td className="text-center py-3 px-4 font-semibold">{stat.averageScore}%</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          )}

          {attempts.length > 0 && (
            <Card className="border-2">
              <CardHeader>
                <CardTitle>Recent Activity</CardTitle>
                <CardDescription>Your most recent quiz attempts</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {attempts.slice(0, 10).map((attempt) => {
                    const category = categories.find((c) => c.id === attempt.category_id);
                    const percentage = attempt.completed
                      ? Math.round((attempt.correct_answers / attempt.total_questions) * 100)
                      : 0;

                    return (
                      <div
                        key={attempt.id}
                        className="flex items-center justify-between p-3 rounded-lg border hover:bg-accent transition-colors"
                      >
                        <div className="space-y-1">
                          <div className="font-medium">{category?.name || 'Unknown'}</div>
                          <div className="text-xs text-muted-foreground">
                            {format(new Date(attempt.started_at), 'MMM d, yyyy h:mm a')} •{' '}
                            {attempt.difficulty} • {attempt.total_questions} questions
                          </div>
                        </div>
                        <div className="text-right">
                          {attempt.completed ? (
                            <div className="space-y-1">
                              <div className="font-bold text-lg">{percentage}%</div>
                              <div className="text-xs text-muted-foreground">
                                {attempt.correct_answers}/{attempt.total_questions}
                              </div>
                            </div>
                          ) : (
                            <div className="text-sm text-yellow-600">In Progress</div>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          )}
        </div>
      </main>
    </div>
  );
}
