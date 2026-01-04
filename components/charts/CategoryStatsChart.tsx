'use client';

import { TrendingUp } from 'lucide-react';
import { Bar, BarChart, CartesianGrid, LabelList, XAxis, YAxis } from 'recharts';

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from '@/components/ui/chart';

interface CategoryStatsChartProps {
  data: Array<{
    name: string;
    averageScore: number;
  }>;
  trendingUp?: boolean;
  trendPercentage?: number;
}

const chartConfig = {
  averageScore: {
    label: 'Average Score',
    color: 'var(--chart-1)',
  },
} satisfies ChartConfig;

export function CategoryStatsChart({
  data,
  trendingUp = true,
  trendPercentage = 5.2,
}: CategoryStatsChartProps) {
  if (data.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Category Performance</CardTitle>
          <CardDescription>Average score by category</CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-center text-muted-foreground py-8">
            No data available yet. Complete quizzes to see your performance.
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Category Performance</CardTitle>
        <CardDescription>Average score by category</CardDescription>
      </CardHeader>
      <CardContent className="h-48 p-2">
        <ChartContainer config={chartConfig} className="h-full w-full">
          <BarChart
            accessibilityLayer
            data={data}
            margin={{
              top: 15,
              right: 5,
              left: -20,
              bottom: 5,
            }}
          >
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="name"
              tickLine={false}
              tickMargin={8}
              axisLine={false}
              tickFormatter={(value) => value.slice(0, 8)}
              height={40}
            />
            <YAxis
              tickLine={false}
              axisLine={false}
              domain={[0, 100]}
            />
            <ChartTooltip
              cursor={false}
              content={<ChartTooltipContent hideLabel />}
            />
            <Bar
              dataKey="averageScore"
              fill="var(--color-averageScore)"
              radius={6}
              maxBarSize={40}
            >
              <LabelList
                position="top"
                offset={8}
                className="fill-foreground"
                fontSize={11}
              />
            </Bar>
          </BarChart>
        </ChartContainer>
      </CardContent>
      <CardFooter className="flex-col items-start gap-2 text-sm py-3">
        <div className="flex gap-2 leading-none font-medium">
          {trendingUp ? 'Trending up' : 'Trending down'} by {trendPercentage}%{' '}
          {trendingUp && <TrendingUp className="h-4 w-4" />}
        </div>
        <div className="text-muted-foreground leading-none">
          Showing average scores across all categories
        </div>
      </CardFooter>
    </Card>
  );
}
