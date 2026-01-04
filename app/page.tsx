'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/lib/supabase';
import { CategoryCard } from '@/components/CategoryCard';
import { Navbar } from '@/components/Navbar';

interface Category {
  id: string;
  name: string;
  description: string;
  svg_icon: string;
}

interface InProgressQuiz {
  id: string;
  categoryName: string;
  difficulty: string;
  progress: number;
  currentQuestion: number;
  totalQuestions: number;
}

interface InProgressMap {
  [categoryId: string]: InProgressQuiz & { quizId: string };
}

export default function Home() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const [categories, setCategories] = useState<Category[]>([]);
  const [inProgressMap, setInProgressMap] = useState<InProgressMap>({});
  const [loadingCategories, setLoadingCategories] = useState(true);

  useEffect(() => {
    const loadData = async () => {
      if (!loading && !user) {
        router.push('/auth');
        return;
      }

      if (user) {
        const [categoriesRes, quizzesRes] = await Promise.all([
          supabase
            .from('categories')
            .select('*')
            .order('name'),
          supabase
            .from('quiz_attempts')
            .select('id, category_id, difficulty, total_questions, progress, categories(name)')
            .eq('user_id', user.id)
            .eq('completed', false)
            .order('started_at', { ascending: false })
        ]);

        if (categoriesRes.error) {
          console.error('Error loading categories:', categoriesRes.error);
        } else {
          setCategories(categoriesRes.data || []);
        }

        if (quizzesRes.error) {
          console.error('Error loading in-progress quizzes:', quizzesRes.error);
        } else {
          const inProgressByCategory: InProgressMap = {};
          (quizzesRes.data || []).forEach((quiz: any) => {
            const progressData = typeof quiz.progress === 'string'
              ? JSON.parse(quiz.progress)
              : quiz.progress;
            const currentQuestionIndex = progressData?.currentQuestionIndex || 0;
            inProgressByCategory[quiz.category_id] = {
              quizId: quiz.id,
              id: quiz.id,
              categoryName: quiz.categories.name,
              difficulty: quiz.difficulty,
              currentQuestion: currentQuestionIndex,
              totalQuestions: quiz.total_questions,
              progress: (currentQuestionIndex / quiz.total_questions) * 100
            };
          });
          setInProgressMap(inProgressByCategory);
        }
        setLoadingCategories(false);
      }
    };

    loadData();
  }, [user, loading, router]);

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navbar />

      <main className="container mx-auto px-4 py-8 space-y-16">
        <div className="text-center space-y-4">
          <h1 className="text-4xl md:text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-primary to-primary/60">
            Quiz Catalog
          </h1>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            Challenge yourself with our diverse collection of quizzes. Choose a category and test your knowledge!
          </p>
        </div>

        {loadingCategories ? (
          <div className="flex justify-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
          </div>
        ) : (
          <section className="space-y-6">
            <div>
              <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">Quiz Catalog</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 max-w-7xl mx-auto">
                {categories.map((category) => {
                  const inProgress = inProgressMap[category.id];
                  return (
                    <CategoryCard
                      key={category.id}
                      id={category.id}
                      name={category.name}
                      description={category.description}
                      svgIcon={category.svg_icon}
                      inProgressQuizId={inProgress?.quizId}
                      progress={inProgress?.progress}
                      currentQuestion={inProgress?.currentQuestion}
                      totalQuestions={inProgress?.totalQuestions}
                    />
                  );
                })}
              </div>
            </div>
          </section>
        )}
      </main>
    </div>
  );
}
