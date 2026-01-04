'use client';

import { useEffect, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/lib/supabase';
import { Navbar } from '@/components/Navbar';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Slider } from '@/components/ui/slider';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { ArrowLeft, Play } from 'lucide-react';
import Link from 'next/link';

interface Category {
  id: string;
  name: string;
  description: string;
}

export default function QuizSetupPage() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const searchParams = useSearchParams();
  const categoryId = searchParams.get('category');

  const [category, setCategory] = useState<Category | null>(null);
  const [questionCount, setQuestionCount] = useState(10);
  const [difficulty, setDifficulty] = useState<'easy' | 'medium' | 'hard'>('medium');
  const [isStarting, setIsStarting] = useState(false);

  useEffect(() => {
    if (!loading && !user) {
      router.push('/auth');
    }
  }, [user, loading, router]);

  useEffect(() => {
    if (categoryId && user) {
      loadCategory();
    }
  }, [categoryId, user]);

  const loadCategory = async () => {
    if (!categoryId) return;

    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .eq('id', categoryId)
      .maybeSingle();

    if (error) {
      console.error('Error loading category:', error);
    } else if (data) {
      setCategory(data);
    }
  };

  const startQuiz = async () => {
    if (!user || !categoryId || isStarting) return;

    setIsStarting(true);

    const { data: profile } = await supabase
      .from('profiles')
      .select('id')
      .eq('id', user.id)
      .maybeSingle();

    if (!profile) {
      console.error('Profile not found');
      setIsStarting(false);
      return;
    }

    const { data: attempt, error } = await supabase
      .from('quiz_attempts')
      .insert({
        user_id: user.id,
        category_id: categoryId,
        difficulty,
        total_questions: questionCount,
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating quiz attempt:', error);
      setIsStarting(false);
    } else if (attempt) {
      router.push(`/quiz/${attempt.id}?count=${questionCount}&difficulty=${difficulty}`);
    }
  };

  if (loading || !user || !category) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navbar />

      <main className="container mx-auto px-4 py-8">
        <Link
          href="/"
          className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground mb-6 transition-colors"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to categories
        </Link>

        <div className="max-w-2xl mx-auto">
          <Card className="border-2">
            <CardHeader className="space-y-1">
              <CardTitle className="text-3xl">{category.name} Quiz</CardTitle>
              <CardDescription className="text-base">
                {category.description}
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-8">
              <div className="space-y-4">
                <div>
                  <Label className="text-lg font-semibold">
                    Number of Questions: {questionCount}
                  </Label>
                  <p className="text-sm text-muted-foreground mb-4">
                    Choose how many questions you want to answer (5-20)
                  </p>
                  <Slider
                    value={[questionCount]}
                    onValueChange={(value) => setQuestionCount(value[0])}
                    min={5}
                    max={20}
                    step={1}
                    className="w-full"
                  />
                  <div className="flex justify-between text-xs text-muted-foreground mt-2">
                    <span>5</span>
                    <span>20</span>
                  </div>
                </div>
              </div>

              <div className="space-y-4">
                <Label className="text-lg font-semibold">Difficulty Level</Label>
                <RadioGroup
                  value={difficulty}
                  onValueChange={(value) => setDifficulty(value as 'easy' | 'medium' | 'hard')}
                  className="grid grid-cols-3 gap-4"
                >
                  <div>
                    <RadioGroupItem
                      value="easy"
                      id="easy"
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor="easy"
                      className="flex flex-col items-center justify-center rounded-lg border-2 border-muted bg-popover p-4 hover:bg-accent hover:text-accent-foreground peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10 cursor-pointer transition-all"
                    >
                      <span className="text-2xl mb-1">😊</span>
                      <span className="font-semibold">Easy</span>
                    </Label>
                  </div>
                  <div>
                    <RadioGroupItem
                      value="medium"
                      id="medium"
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor="medium"
                      className="flex flex-col items-center justify-center rounded-lg border-2 border-muted bg-popover p-4 hover:bg-accent hover:text-accent-foreground peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10 cursor-pointer transition-all"
                    >
                      <span className="text-2xl mb-1">🤔</span>
                      <span className="font-semibold">Medium</span>
                    </Label>
                  </div>
                  <div>
                    <RadioGroupItem
                      value="hard"
                      id="hard"
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor="hard"
                      className="flex flex-col items-center justify-center rounded-lg border-2 border-muted bg-popover p-4 hover:bg-accent hover:text-accent-foreground peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10 cursor-pointer transition-all"
                    >
                      <span className="text-2xl mb-1">🔥</span>
                      <span className="font-semibold">Hard</span>
                    </Label>
                  </div>
                </RadioGroup>
              </div>

              <Button
                onClick={startQuiz}
                disabled={isStarting}
                size="lg"
                className="w-full text-lg h-14 group"
              >
                {isStarting ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent mr-2" />
                    Preparing Quiz...
                  </>
                ) : (
                  <>
                    <Play className="w-5 h-5 mr-2 group-hover:scale-110 transition-transform" />
                    Start Quiz
                  </>
                )}
              </Button>
            </CardContent>
          </Card>
        </div>
      </main>
    </div>
  );
}
