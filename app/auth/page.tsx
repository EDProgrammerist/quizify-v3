'use client';

import { useState } from 'react';
import Image from 'next/image';
import { LoginForm } from '@/components/auth/LoginForm';
import { SignupForm } from '@/components/auth/SignupForm';

export default function AuthPage() {
  const [isLogin, setIsLogin] = useState(true);

  return (
    <div className="min-h-screen flex items-center justify-center relative overflow-hidden p-4 bg-white dark:bg-black">
      <div className="absolute top-8 left-8 flex items-center gap-3 z-10 animate-fade-in">
        <div className="w-12 h-12 rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 flex items-center justify-center overflow-hidden">
          <Image
            src="/brain.png" // logo
            alt="Quizify Logo"
            width={48}
            height={48}
            priority
            className="w-full h-full object-contain p-1"
          />
        </div>
        <span className="text-2xl font-bold text-black dark:text-white">Quizify</span>
      </div>

      <div className="absolute top-20 right-8 hidden lg:flex flex-col gap-6 z-10 w-32">
        <div className="group flex flex-col items-center justify-center gap-3 bg-gray-100 dark:bg-gray-900 rounded-2xl p-6 shadow-lg hover:shadow-xl border border-gray-200 dark:border-gray-800 animate-slide-in-right hover:translate-x-2 transition-all duration-300 cursor-pointer">
          <div className="w-16 h-16 rounded-xl shadow-md group-hover:scale-110 transition-transform duration-300 flex items-center justify-center overflow-hidden flex-shrink-0">
            <Image
              src="/Interactive Quizzes.png"
              alt="Interactive Quizzes"
              width={64}
              height={64}
              className="w-full h-full object-contain"
            />
          </div>
          <div className="text-center">
            <p className="text-xs font-bold text-black dark:text-white">Interactive Quizzes</p>
            <p className="text-[10px] text-gray-600 dark:text-gray-400">Test knowledge</p>
          </div>
        </div>
        <div className="group flex flex-col items-center justify-center gap-3 bg-gray-100 dark:bg-gray-900 rounded-2xl p-6 shadow-lg hover:shadow-xl border border-gray-200 dark:border-gray-800 animate-slide-in-right hover:translate-x-2 transition-all duration-300 cursor-pointer" style={{ animationDelay: '0.1s' }}>
          <div className="w-16 h-16 rounded-xl shadow-md group-hover:scale-110 transition-transform duration-300 flex items-center justify-center overflow-hidden flex-shrink-0">
            <Image
              src="/Track Progress.jpg"
              alt="Track Progress"
              width={64}
              height={64}
              className="w-full h-full object-contain"
            />
          </div>
          <div className="text-center">
            <p className="text-xs font-bold text-black dark:text-white">Track Progress</p>
            <p className="text-[10px] text-gray-600 dark:text-gray-400">Monitor growth</p>
          </div>
        </div>
        <div className="group flex flex-col items-center justify-center gap-3 bg-gray-100 dark:bg-gray-900 rounded-2xl p-6 shadow-lg hover:shadow-xl border border-gray-200 dark:border-gray-800 animate-slide-in-right hover:translate-x-2 transition-all duration-300 cursor-pointer" style={{ animationDelay: '0.2s' }}>
          <div className="w-16 h-16 rounded-xl shadow-md group-hover:scale-110 transition-transform duration-300 flex items-center justify-center overflow-hidden flex-shrink-0">
            <Image
              src="/Compete Globally.png"
              alt="Compete Globally"
              width={64}
              height={64}
              className="w-full h-full object-contain"
            />
          </div>
          <div className="text-center">
            <p className="text-xs font-bold text-black dark:text-white">Compete Globally</p>
            <p className="text-[10px] text-gray-600 dark:text-gray-400">Challenge others</p>
          </div>
        </div>
      </div>

      <div className="w-full max-w-md relative z-20">
        <div className="transition-all duration-500 ease-in-out transform">
          {isLogin ? (
            <div key="login">
              <LoginForm onToggle={() => setIsLogin(false)} />
            </div>
          ) : (
            <div key="signup">
              <SignupForm onToggle={() => setIsLogin(true)} />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
