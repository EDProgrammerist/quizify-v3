'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Navbar } from '@/components/Navbar';
import { ProfileAvatar } from '@/components/ProfileAvatar';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { useAuth } from '@/contexts/AuthContext';
import { fetchLeaderboard, LeaderboardEntry } from '@/lib/leaderboard';
import { Trophy, Medal, Award, TrendingUp, Target, Calendar } from 'lucide-react';
import { format } from 'date-fns';

export default function LeaderboardPage() {
  const { user } = useAuth();
  const router = useRouter();
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) {
      router.push('/auth');
      return;
    }

    loadLeaderboard();
  }, [user, router]);

  const loadLeaderboard = async () => {
    setLoading(true);
    const data = await fetchLeaderboard(100);
    setLeaderboard(data);
    setLoading(false);
  };

  const getRankIcon = (rank: number) => {
    switch (rank) {
      case 1:
        return <Trophy className="w-6 h-6 text-yellow-500" />;
      case 2:
        return <Medal className="w-6 h-6 text-gray-400" />;
      case 3:
        return <Award className="w-6 h-6 text-amber-700" />;
      default:
        return <span className="text-lg font-bold text-muted-foreground">#{rank}</span>;
    }
  };

  const getRankBadgeColor = (rank: number) => {
    switch (rank) {
      case 1:
        return 'bg-gradient-to-br from-yellow-400 to-yellow-600 text-white border-yellow-500';
      case 2:
        return 'bg-gradient-to-br from-gray-300 to-gray-500 text-white border-gray-400';
      case 3:
        return 'bg-gradient-to-br from-amber-600 to-amber-800 text-white border-amber-700';
      default:
        return 'bg-muted text-muted-foreground border-muted';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <Navbar />
        <main className="container mx-auto px-4 py-8">
          <div className="space-y-6">
            <Skeleton className="h-32 w-full" />
            <Skeleton className="h-96 w-full" />
          </div>
        </main>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navbar />

      <main className="container mx-auto px-4 py-8">
        <div className="space-y-8">
          <div className="text-center space-y-4">
            <div className="flex items-center justify-center gap-3">
              <Trophy className="w-10 h-10 text-primary" />
              <h1 className="text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-primary to-primary/60">
                Leaderboard
              </h1>
            </div>
            <p className="text-muted-foreground text-lg">
              Top performers across all quizzes
            </p>
          </div>

          {leaderboard.length === 0 ? (
            <Card className="border-2">
              <CardContent className="py-12 text-center">
                <Trophy className="w-16 h-16 text-muted-foreground mx-auto mb-4" />
                <p className="text-lg text-muted-foreground">
                  No quiz results yet. Be the first to complete a quiz!
                </p>
              </CardContent>
            </Card>
          ) : (
            <Card className="border-2 shadow-lg">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <TrendingUp className="w-5 h-5" />
                  Top 100 Players
                </CardTitle>
                <CardDescription>
                  Rankings based on accuracy, correct answers, and total quizzes completed
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {leaderboard.map((entry, index) => {
                    const rank = index + 1;
                    const isCurrentUser = entry.user_id === user?.id;

                    return (
                      <div
                        key={entry.user_id}
                        className={`flex items-center gap-4 p-4 rounded-lg border-2 transition-all hover:shadow-md ${
                          isCurrentUser
                            ? 'bg-primary/5 border-primary shadow-sm'
                            : 'bg-card border-border hover:border-primary/50'
                        }`}
                      >
                        <div className="flex items-center justify-center w-16">
                          {getRankIcon(rank)}
                        </div>

                        <ProfileAvatar
                          avatarUrl={entry.avatar_url}
                          username={entry.username}
                          size="sm"
                        />

                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2">
                            <h3 className="font-semibold text-lg truncate">
                              {entry.username}
                            </h3>
                            {isCurrentUser && (
                              <Badge variant="secondary" className="text-xs">
                                You
                              </Badge>
                            )}
                          </div>
                          <p className="text-sm text-muted-foreground flex items-center gap-1">
                            <Calendar className="w-3 h-3" />
                            Last active: {format(new Date(entry.last_active), 'MMM d, yyyy')}
                          </p>
                        </div>

                        <div className="grid grid-cols-2 gap-4 text-center">
                          <div className="space-y-1">
                            <div className="flex items-center justify-center gap-1 text-2xl font-bold text-primary">
                              <Target className="w-5 h-5" />
                              {entry.accuracy_percentage}%
                            </div>
                            <p className="text-xs text-muted-foreground">Accuracy</p>
                          </div>

                          <div className="space-y-1">
                            <div className="text-2xl font-bold">
                              {entry.total_correct}
                            </div>
                            <p className="text-xs text-muted-foreground">
                              Correct ({entry.total_questions} total)
                            </p>
                          </div>
                        </div>

                        <div className="text-center space-y-1">
                          <div className="text-2xl font-bold">{entry.total_quizzes}</div>
                          <p className="text-xs text-muted-foreground">Quizzes</p>
                        </div>

                        {rank <= 3 && (
                          <Badge className={`${getRankBadgeColor(rank)} px-3 py-1 text-sm font-bold shadow-md`}>
                            #{rank}
                          </Badge>
                        )}
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
