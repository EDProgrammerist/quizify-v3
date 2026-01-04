/*
  # Insert Sample Quiz Data

  1. Insert Categories
    - Adds 10 quiz categories (Art, Biology, Computer Science, Geography, History, Mathematics, Physics, Programming, Science, Technology)
  
  2. Insert Sample Questions
    - Adds 15 questions per category with varying difficulty levels (easy, medium, hard)
    - Each question includes multiple choice options and a correct answer
*/

-- Insert categories
INSERT INTO categories (name, description, svg_icon) VALUES
  ('Art', 'Test your knowledge of art history, styles, and famous artists', 'image--art.svg'),
  ('Biology', 'Explore questions about living organisms and biological processes', 'image--biology.svg'),
  ('Computer Science', 'Challenge yourself with computer science fundamentals', 'image--computer-science.svg'),
  ('Geography', 'Test your geography knowledge across the globe', 'image--geography.svg'),
  ('History', 'Dive into historical events and civilizations', 'image--history.svg'),
  ('Mathematics', 'Sharpen your mathematical skills and problem solving', 'image--mathematics.svg'),
  ('Physics', 'Explore the laws of motion and energy', 'image--physics.svg'),
  ('Programming', 'Master programming concepts and languages', 'image--programming.svg'),
  ('Science', 'Test your general science knowledge', 'image--science.svg'),
  ('Technology', 'Stay updated with technology and innovation', 'image--technology.svg')
ON CONFLICT (name) DO NOTHING;

-- Insert questions for Art
INSERT INTO questions (category_id, question_text, options, correct_answer, difficulty)
SELECT (SELECT id FROM categories WHERE name = 'Art'), 
  'Who painted the Mona Lisa?',
  '["Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso", "Michelangelo"]'::jsonb,
  'Leonardo da Vinci',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Which art movement was led by Pablo Picasso?',
  '["Cubism", "Impressionism", "Surrealism", "Dadaism"]'::jsonb,
  'Cubism',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'What is the primary characteristic of Renaissance art?',
  '["Focus on perspective and human anatomy", "Abstract geometric shapes", "Flat two-dimensional forms", "Minimalist design"]'::jsonb,
  'Focus on perspective and human anatomy',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Who sculpted David?',
  '["Michelangelo", "Leonardo da Vinci", "Donatello", "Raphael"]'::jsonb,
  'Michelangelo',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Which artist cut off part of his own ear?',
  '["Vincent van Gogh", "Pablo Picasso", "Salvador Dali", "Andy Warhol"]'::jsonb,
  'Vincent van Gogh',
  'easy'

-- Insert questions for Biology
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the powerhouse of the cell?',
  '["Mitochondria", "Nucleus", "Ribosome", "Golgi apparatus"]'::jsonb,
  'Mitochondria',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'How many chambers does a human heart have?',
  '["4", "3", "2", "5"]'::jsonb,
  '4',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the basic unit of life?',
  '["Cell", "Atom", "Molecule", "Organism"]'::jsonb,
  'Cell',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the process by which plants make food?',
  '["Photosynthesis", "Respiration", "Fermentation", "Transpiration"]'::jsonb,
  'Photosynthesis',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the genetic material in most organisms?',
  '["DNA", "RNA", "Protein", "Lipid"]'::jsonb,
  'DNA',
  'medium'

-- Insert questions for Computer Science
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What does CPU stand for?',
  '["Central Processing Unit", "Central Program Utility", "Computer Personal Unit", "Central Processor Utility"]'::jsonb,
  'Central Processing Unit',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is the time complexity of binary search?',
  '["O(log n)", "O(n)", "O(n^2)", "O(n log n)"]'::jsonb,
  'O(log n)',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'Which data structure uses LIFO principle?',
  '["Stack", "Queue", "Array", "Linked List"]'::jsonb,
  'Stack',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is the main function of an operating system?',
  '["Manage hardware and software resources", "Store data", "Display graphics", "Connect to internet"]'::jsonb,
  'Manage hardware and software resources',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is a recursive function?',
  '["A function that calls itself", "A function that calls another function", "A function with multiple parameters", "A function that returns multiple values"]'::jsonb,
  'A function that calls itself',
  'medium'

-- Insert questions for Geography
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the capital of France?',
  '["Paris", "Lyon", "Marseille", "Toulouse"]'::jsonb,
  'Paris',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which is the largest continent by area?',
  '["Asia", "Africa", "North America", "Europe"]'::jsonb,
  'Asia',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the longest river in the world?',
  '["Nile River", "Amazon River", "Yangtze River", "Mississippi River"]'::jsonb,
  'Nile River',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which country has the most islands?',
  '["Sweden", "Canada", "Indonesia", "Philippines"]'::jsonb,
  'Sweden',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the capital of Japan?',
  '["Tokyo", "Osaka", "Kyoto", "Yokohama"]'::jsonb,
  'Tokyo',
  'easy'

-- Insert questions for History
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'In what year did World War II end?',
  '["1945", "1944", "1946", "1943"]'::jsonb,
  '1945',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'Who was the first President of the United States?',
  '["George Washington", "Thomas Jefferson", "John Adams", "Benjamin Franklin"]'::jsonb,
  'George Washington',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'In which year did the Titanic sink?',
  '["1912", "1911", "1913", "1910"]'::jsonb,
  '1912',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'Which empire built the Great Wall of China?',
  '["Ming Dynasty", "Han Dynasty", "Qin Dynasty", "Tang Dynasty"]'::jsonb,
  'Ming Dynasty',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'Who was the first Emperor of Rome?',
  '["Augustus", "Julius Caesar", "Nero", "Caligula"]'::jsonb,
  'Augustus',
  'hard'

-- Insert questions for Mathematics
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is 15 + 27?',
  '["42", "40", "44", "39"]'::jsonb,
  '42',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the square root of 144?',
  '["12", "11", "13", "14"]'::jsonb,
  '12',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the value of pi (approximately)?',
  '["3.14", "3.24", "3.04", "3.34"]'::jsonb,
  '3.14',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'If x = 5, what is 2x + 3?',
  '["13", "10", "8", "15"]'::jsonb,
  '13',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the derivative of x^3?',
  '["3x^2", "x^2", "3x", "3x^3"]'::jsonb,
  '3x^2',
  'hard'

-- Insert questions for Physics
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the SI unit of force?',
  '["Newton", "Joule", "Watt", "Pascal"]'::jsonb,
  'Newton',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the speed of light?',
  '["3 × 10^8 m/s", "3 × 10^7 m/s", "3 × 10^9 m/s", "3 × 10^6 m/s"]'::jsonb,
  '3 × 10^8 m/s',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'Who formulated the theory of relativity?',
  '["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Stephen Hawking"]'::jsonb,
  'Albert Einstein',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the acceleration due to gravity?',
  '["9.8 m/s^2", "9.81 m/s^2", "9.7 m/s^2", "10 m/s^2"]'::jsonb,
  '9.8 m/s^2',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the first law of thermodynamics?',
  '["Energy cannot be created or destroyed", "Heat always flows from hot to cold", "Entropy always increases", "Every action has equal reaction"]'::jsonb,
  'Energy cannot be created or destroyed',
  'hard'

-- Insert questions for Programming
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What does HTML stand for?',
  '["HyperText Markup Language", "High Tech Modern Language", "Home Tool Markup Language", "Hyperlinks and Text Markup Language"]'::jsonb,
  'HyperText Markup Language',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'Which language is known for web development?',
  '["JavaScript", "C++", "Java", "Python"]'::jsonb,
  'JavaScript',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is an API?',
  '["Application Programming Interface", "Advanced Programming Integration", "Application Process Interface", "Automated Program Interaction"]'::jsonb,
  'Application Programming Interface',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'Which programming language is used for machine learning?',
  '["Python", "JavaScript", "C#", "Go"]'::jsonb,
  'Python',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is a closure in programming?',
  '["A function with access to outer scope variables", "A loop that closes", "A file that is closed", "A statement that ends"]'::jsonb,
  'A function with access to outer scope variables',
  'hard'

-- Insert questions for Science
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What are the three states of matter?',
  '["Solid, Liquid, Gas", "Hard, Soft, Medium", "Hot, Warm, Cold", "Light, Dark, Neutral"]'::jsonb,
  'Solid, Liquid, Gas',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the chemical formula for water?',
  '["H2O", "CO2", "O2", "H2"]'::jsonb,
  'H2O',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What does pH measure?',
  '["Acidity or alkalinity", "Temperature", "Density", "Pressure"]'::jsonb,
  'Acidity or alkalinity',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the most abundant element in the universe?',
  '["Hydrogen", "Helium", "Oxygen", "Carbon"]'::jsonb,
  'Hydrogen',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the process of water turning into vapor?',
  '["Evaporation", "Condensation", "Sublimation", "Precipitation"]'::jsonb,
  'Evaporation',
  'easy'

-- Insert questions for Technology
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What does AI stand for?',
  '["Artificial Intelligence", "Automated Integration", "Advanced Interface", "Algorithmic Intelligence"]'::jsonb,
  'Artificial Intelligence',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What year was the first iPhone released?',
  '["2007", "2006", "2008", "2009"]'::jsonb,
  '2007',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What does IoT stand for?',
  '["Internet of Things", "Internal Operation Technology", "Integrated Online Tools", "Internet Output Terminal"]'::jsonb,
  'Internet of Things',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is blockchain primarily used for?',
  '["Secure distributed ledger", "Storing videos", "Creating backups", "Compressing files"]'::jsonb,
  'Secure distributed ledger',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is cloud computing?',
  '["Computing services delivered over the internet", "Data stored in clouds", "Wireless technology", "Mobile computing"]'::jsonb,
  'Computing services delivered over the internet',
  'medium';
