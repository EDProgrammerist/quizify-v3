'use client';

import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Brain, LogOut, ChartBar as BarChart3, Trophy } from 'lucide-react';
import Link from 'next/link';
import { useRouter, usePathname } from 'next/navigation';

export function Navbar() {
  const { user, signOut } = useAuth();
  const router = useRouter();
  const pathname = usePathname();

  const handleSignOut = async () => {
    await signOut();
    router.push('/auth');
  };

  if (!user) return null;

  return (
    <nav className="border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 sticky top-0 z-50">
      <div className="container mx-auto px-4 h-16 flex items-center justify-between">
        <Link href="/" className="flex items-center space-x-2 group">
          <div className="w-10 h-10 rounded-lg bg-primary flex items-center justify-center group-hover:scale-110 transition-transform">
            <Brain className="w-6 h-6 text-primary-foreground" />
          </div>
          <span className="text-xl font-bold">Quizify</span>
        </Link>

        <div className="flex items-center space-x-4">
          <Link href="/leaderboard">
            <Button
              variant={pathname === '/leaderboard' ? 'default' : 'ghost'}
              className="flex items-center gap-2"
            >
              <Trophy className="w-4 h-4" />
              Leaderboard
            </Button>
          </Link>
          <Link href="/stats">
            <Button
              variant={pathname === '/stats' ? 'default' : 'ghost'}
              className="flex items-center gap-2"
            >
              <BarChart3 className="w-4 h-4" />
              My Stats
            </Button>
          </Link>
          <Button
            variant="ghost"
            size="icon"
            onClick={handleSignOut}
            title="Sign out"
          >
            <LogOut className="w-4 h-4" />
          </Button>
        </div>
      </div>
    </nav>
  );
}
