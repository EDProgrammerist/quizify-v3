'use client';

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ArrowRight, Brain, Clock } from 'lucide-react';
import Link from 'next/link';
import Image from 'next/image';
import { Progress } from '@/components/ui/progress';

interface CategoryCardProps {
  id: string;
  name: string;
  description: string;
  svgIcon?: string;
  inProgressQuizId?: string;
  progress?: number;
  currentQuestion?: number;
  totalQuestions?: number;
}

const svgImageMap: Record<string, string> = {
  'Art': '/image--art.svg',
  'Biology': '/image--biology.svg',
  'Computer Science': '/image--computer-science.svg',
  'Geography': '/image--geography.svg',
  'History': '/image--history.svg',
  'Mathematics': '/image--mathematics.svg',
  'Physics': '/image--physics.svg',
  'Programming': '/image--programming.svg',
  'Science': '/image--science.svg',
  'Technology': '/image--technology.svg',
};

export function CategoryCard({
  id,
  name,
  description,
  svgIcon,
  inProgressQuizId,
  progress = 0,
  currentQuestion = 0,
  totalQuestions = 0
}: CategoryCardProps) {
  const svgImage = svgImageMap[name];
  const href = inProgressQuizId ? `/quiz/${inProgressQuizId}` : `/quiz/setup?category=${id}`;

  return (
    <Link href={href}>
      <Card className="group cursor-pointer transition-all duration-300 hover:shadow-xl hover:-translate-y-1 border-2 hover:border-primary/50 h-full overflow-hidden">
        {inProgressQuizId && (
          <div className="h-1 bg-gradient-to-r from-primary to-primary/50"></div>
        )}
        <CardHeader className="pb-3 pt-4">
          <div className="flex justify-between items-start mb-2">
            <ArrowRight className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors group-hover:translate-x-1 duration-300" />
            {inProgressQuizId && (
              <div className="flex items-center gap-1 text-xs font-medium text-primary bg-primary/10 px-2 py-1 rounded">
                <Clock className="w-3 h-3" />
                In Progress
              </div>
            )}
          </div>
          <div className="flex justify-center mb-4">
            <div className="w-32 h-32 flex items-center justify-center">
              {svgImage ? (
                <Image
                  src={svgImage}
                  alt={name}
                  width={128}
                  height={128}
                  className="w-full h-full object-contain"
                />
              ) : (
                <Brain className="w-16 h-16 text-primary" />
              )}
            </div>
          </div>
          <CardTitle className="text-lg text-center">{name}</CardTitle>
          <CardDescription className="text-xs line-clamp-2 text-center">
            {description}
          </CardDescription>
        </CardHeader>

        {inProgressQuizId && (
          <CardContent className="pb-4 pt-0 space-y-2">
            <div className="flex items-center justify-between text-xs text-muted-foreground">
              <span>Progress</span>
              <span>{currentQuestion}/{totalQuestions}</span>
            </div>
            <Progress value={progress} className="h-1.5" />
          </CardContent>
        )}
      </Card>
    </Link>
  );
}
