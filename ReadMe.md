# 🧠 Quizify V3

**The Next Generation Quiz Platform for Interactive Learning**

![Next JS](https://img.shields.io/badge/Next-black?style=for-the-badge&logo=next.js&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-181818?style=for-the-badge&logo=supabase&logoColor=3ECF8E)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![shadcn/ui](https://img.shields.io/badge/shadcn%2Fui-000000?style=for-the-badge&logo=shadcnui&logoColor=white)

## 📖 About The Project

**Quizify V3** is a modern, full-stack application designed to revolutionize how quizzes are created, taken, and analyzed. Built with performance and scalability in mind, it leverages the Next.js App Router and Supabase to provide a seamless, real-time experience for educators and students.

### ✨ Key Features

- **🔐 Secure Authentication**: Robust user management powered by Supabase Auth.
- **⚡ Real-time Updates**: Live score tracking and instant feedback.
- **🎨 Dynamic Quiz Creation**: Intuitive interface for creating complex questions.
- **📊 Advanced Analytics**: Visual dashboards to track performance trends and history.
- **📱 Fully Responsive**: Mobile-first design using Tailwind CSS.
- **🌙 Dark Mode**: Built-in support for light and dark themes.

---

## 🛠 Tech Stack

**Frontend:**
- **Framework**: [Next.js 16](https://nextjs.org/) (App Router)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **UI Components**: [Shadcn/ui](https://ui.shadcn.com/) (presumed based on structure) & [Framer Motion](https://www.framer.com/motion/)

**Backend & Database:**
- **BaaS**: [Supabase](https://supabase.com/) (PostgreSQL Database, Auth, Realtime)

---

## 🚀 Getting Started

Follow these steps to set up the project locally.

### Prerequisites

- **Node.js** (v18 or higher)
- **npm**, **yarn**, or **pnpm**
- **Git**
- A [Supabase](https://supabase.com/) project

### Installation

1. **Clone the repository**
   ```bash
   git clone [https://github.com/EDProgrammerist/quizify-v3.git](https://github.com/EDProgrammerist/quizify-v3.git)
   cd quizify-v3
Install dependencies

Bash

npm install
# or
yarn install
Environment Variables Create a .env.local file in the root directory and add your Supabase credentials:

Code snippet

NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
Run the development server

Bash

npm run dev
Open http://localhost:3000 with your browser to see the result.

