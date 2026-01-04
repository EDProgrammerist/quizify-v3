'use client';

import { useEffect, useState } from 'react';
import { useRouter, useSearchParams, useParams } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/lib/supabase';
import { Navbar } from '@/components/Navbar';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { CircleCheck as CheckCircle2, Circle as XCircle, ArrowRight } from 'lucide-react';
import { toast } from 'sonner';

interface Question {
  id: string;
  question_text: string;
  options: string[];
  correct_answer: string;
  difficulty: string;
}

interface QuizProgress {
  currentQuestionIndex: number;
  answers: Record<number, string>;
}

export default function QuizPage() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const params = useParams();
  const searchParams = useSearchParams();
  const attemptId = params.id as string;
  const questionCount = parseInt(searchParams.get('count') || '10');
  const difficulty = searchParams.get('difficulty') || 'medium';

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set());
  const [correctAnswers, setCorrectAnswers] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const [isComplete, setIsComplete] = useState(false);
  const [loadingQuestions, setLoadingQuestions] = useState(true);
  const [isResuming, setIsResuming] = useState(false);

  useEffect(() => {
    if (!loading && !user) {
      router.push('/auth');
    }
  }, [user, loading, router]);

  useEffect(() => {
    if (user && attemptId) {
      loadQuestions();
    }
  }, [user, attemptId]);

  const loadQuestions = async () => {
    const { data: attempt, error: attemptError } = await supabase
      .from('quiz_attempts')
      .select('category_id, difficulty, total_questions, correct_answers, progress')
      .eq('id', attemptId)
      .maybeSingle();

    if (attemptError || !attempt) {
      toast.error('Quiz attempt not found');
      router.push('/');
      return;
    }

    const isResume = !searchParams.get('count');
    setIsResuming(isResume);

    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .eq('category_id', attempt.category_id)
      .eq('difficulty', attempt.difficulty)
      .limit(attempt.total_questions * 2);

    if (error) {
      console.error('Error loading questions:', error);
      toast.error('Failed to load questions');
      setLoadingQuestions(false);
      return;
    }

    if (!data || data.length === 0) {
      toast.error('No questions available for this category');
      router.push('/');
      return;
    }

    const shuffled = data.sort(() => Math.random() - 0.5);
    setQuestions(shuffled.slice(0, attempt.total_questions));

    if (isResume && attempt.progress) {
      const progress = attempt.progress as QuizProgress;
      setCurrentQuestionIndex(progress.currentQuestionIndex);
      setCorrectAnswers(attempt.correct_answers);

      const answered = new Set<number>();
      Object.keys(progress.answers).forEach(key => {
        answered.add(parseInt(key));
      });
      setAnsweredQuestions(answered);
      toast.success('Quiz resumed from where you left off');
    }

    setLoadingQuestions(false);
  };

  const handleAnswerSelect = (answer: string) => {
    if (answeredQuestions.has(currentQuestionIndex)) return;
    setSelectedAnswer(answer);
  };

  const saveProgress = async (index: number, score: number, answered: Set<number>) => {
    const progress: QuizProgress = {
      currentQuestionIndex: index,
      answers: {}
    };

    answered.forEach(idx => {
      progress.answers[idx] = 'answered';
    });

    const { error } = await supabase
      .from('quiz_attempts')
      .update({
        correct_answers: score,
        progress: progress
      })
      .eq('id', attemptId);

    if (error) {
      console.error('Error saving progress:', error);
    }
  };

  const handleSubmitAnswer = () => {
    if (!selectedAnswer) return;

    const currentQuestion = questions[currentQuestionIndex];
    const isCorrect = selectedAnswer === currentQuestion.correct_answer;

    let newScore = correctAnswers;
    if (isCorrect) {
      newScore = correctAnswers + 1;
      setCorrectAnswers(newScore);
    }

    const newAnswered = new Set(answeredQuestions).add(currentQuestionIndex);
    setAnsweredQuestions(newAnswered);
    setShowResult(true);

    setTimeout(async () => {
      if (currentQuestionIndex < questions.length - 1) {
        const nextIndex = currentQuestionIndex + 1;
        await saveProgress(nextIndex, newScore, newAnswered);
        setCurrentQuestionIndex(nextIndex);
        setSelectedAnswer(null);
        setShowResult(false);
      } else {
        completeQuiz(isCorrect, newScore);
      }
    }, 1500);
  };

  const completeQuiz = async (lastAnswerCorrect: boolean, currentScore: number) => {
    const finalScore = currentScore + (lastAnswerCorrect ? 1 : 0);

    const { error } = await supabase
      .from('quiz_attempts')
      .update({
        correct_answers: finalScore,
        completed: true,
        completed_at: new Date().toISOString(),
        progress: null
      })
      .eq('id', attemptId);

    if (error) {
      console.error('Error updating quiz attempt:', error);
    }

    setIsComplete(true);
  };

  if (loading || loadingQuestions || !user || questions.length === 0) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  if (isComplete) {
    const percentage = Math.round((correctAnswers / questions.length) * 100);

    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
        <Navbar />
        <main className="container mx-auto px-4 py-8">
          <div className="max-w-2xl mx-auto">
            <Card className="border-2 text-center">
              <CardHeader>
                <CardTitle className="text-3xl">Quiz Complete!</CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-2">
                  <div className="text-6xl font-bold text-primary">
                    {percentage}%
                  </div>
                  <p className="text-lg text-muted-foreground">
                    You got {correctAnswers} out of {questions.length} questions correct
                  </p>
                </div>

                <div className="flex flex-col gap-3">
                  <Button onClick={() => router.push('/stats')} size="lg" className="w-full">
                    View Stats
                  </Button>
                  <Button onClick={() => router.push('/')} variant="outline" size="lg" className="w-full">
                    Back to Home
                  </Button>
                </div>
              </CardContent>
            </Card>
          </div>
        </main>
      </div>
    );
  }

  const currentQuestion = questions[currentQuestionIndex];
  const progress = ((currentQuestionIndex + 1) / questions.length) * 100;
  const isAnswered = answeredQuestions.has(currentQuestionIndex);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <Navbar />

      <main className="container mx-auto px-4 py-8">
        <div className="max-w-3xl mx-auto space-y-6">
          <div className="space-y-2">
            <div className="flex justify-between items-center text-sm text-muted-foreground">
              <span>
                Question {currentQuestionIndex + 1} of {questions.length}
              </span>
              <span>
                Score: {correctAnswers}/{currentQuestionIndex + (isAnswered ? 1 : 0)}
              </span>
            </div>
            <Progress value={progress} className="h-2" />
          </div>

          <Card className="border-2">
            <CardHeader>
              <CardTitle className="text-2xl leading-relaxed">
                {currentQuestion.question_text}
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {currentQuestion.options.map((option, index) => {
                const isSelected = selectedAnswer === option;
                const isCorrect = option === currentQuestion.correct_answer;
                const showCorrect = showResult && isCorrect;
                const showIncorrect = showResult && isSelected && !isCorrect;

                return (
                  <button
                    key={index}
                    onClick={() => handleAnswerSelect(option)}
                    disabled={isAnswered}
                    className={`w-full p-4 rounded-lg border-2 text-left transition-all duration-300 ${
                      showCorrect
                        ? 'border-green-500 bg-green-50 dark:bg-green-950'
                        : showIncorrect
                        ? 'border-red-500 bg-red-50 dark:bg-red-950'
                        : isSelected
                        ? 'border-primary bg-primary/10'
                        : 'border-muted hover:border-primary/50 hover:bg-accent'
                    } ${isAnswered ? 'cursor-not-allowed' : 'cursor-pointer'}`}
                  >
                    <div className="flex items-center justify-between">
                      <span className="flex-1">{option}</span>
                      {showCorrect && (
                        <CheckCircle2 className="w-5 h-5 text-green-600 animate-in zoom-in" />
                      )}
                      {showIncorrect && (
                        <XCircle className="w-5 h-5 text-red-600 animate-in zoom-in" />
                      )}
                    </div>
                  </button>
                );
              })}

              {!showResult && (
                <Button
                  onClick={handleSubmitAnswer}
                  disabled={!selectedAnswer}
                  size="lg"
                  className="w-full mt-4 group"
                >
                  Submit Answer
                  <ArrowRight className="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" />
                </Button>
              )}
            </CardContent>
          </Card>
        </div>
      </main>
    </div>
  );
}
