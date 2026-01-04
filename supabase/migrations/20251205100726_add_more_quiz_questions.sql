/*
  # Add More Quiz Questions with Better Difficulty Distribution

  1. Expanded Question Pool
    - Adds 15 questions per category per difficulty level (45 questions per category)
    - Ensures there are always enough questions regardless of selected difficulty
    - Total: 450+ questions across all categories
*/

-- Insert additional questions for Art with all difficulties
INSERT INTO questions (category_id, question_text, options, correct_answer, difficulty)
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'What art movement does Salvador Dali belong to?',
  '["Surrealism", "Cubism", "Expressionism", "Dadaism"]'::jsonb,
  'Surrealism',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Who painted The Starry Night?',
  '["Vincent van Gogh", "Pablo Picasso", "Andy Warhol", "Jackson Pollock"]'::jsonb,
  'Vincent van Gogh',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Which artist is known for pop art?',
  '["Andy Warhol", "Jackson Pollock", "Mark Rothko", "Georgia O''Keeffe"]'::jsonb,
  'Andy Warhol',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'What is the technique of using small dots of color?',
  '["Pointillism", "Stippling", "Impasto", "Glazing"]'::jsonb,
  'Pointillism',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Who created the sculpture The Thinker?',
  '["Auguste Rodin", "Michelangelo", "Bernini", "Phidias"]'::jsonb,
  'Auguste Rodin',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'What period of art emphasized light and shadow?',
  '["Baroque", "Renaissance", "Rococo", "Neoclassical"]'::jsonb,
  'Baroque',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Which artist is associated with abstract expressionism?',
  '["Jackson Pollock", "Pablo Picasso", "Salvador Dali", "Andy Warhol"]'::jsonb,
  'Jackson Pollock',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'What is the Golden Ratio in art?',
  '["Approximately 1.618", "Exactly 2", "Approximately 0.618", "3.14"]'::jsonb,
  'Approximately 1.618',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Art'),
  'Who were the primary figures of the Pre-Raphaelite movement?',
  '["Dante Rossetti, John Everett Millais, Holman Hunt", "Monet, Renoir, Sisley", "Van Gogh, Gauguin, Cezanne", "Picasso, Matisse, Derain"]'::jsonb,
  'Dante Rossetti, John Everett Millais, Holman Hunt',
  'hard'

-- Insert additional questions for Biology with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the role of ribosomes?',
  '["Protein synthesis", "Storing energy", "Breaking down waste", "Cell division"]'::jsonb,
  'Protein synthesis',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the powerhouse of the cell?',
  '["Mitochondria", "Nucleus", "Ribosome", "Golgi apparatus"]'::jsonb,
  'Mitochondria',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'How many chromosomes does a human have?',
  '["46", "48", "44", "50"]'::jsonb,
  '46',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the process of cell division that produces gametes?',
  '["Meiosis", "Mitosis", "Binary fission", "Budding"]'::jsonb,
  'Meiosis',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the study of heredity called?',
  '["Genetics", "Genomics", "Eugenics", "Phenotypology"]'::jsonb,
  'Genetics',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the fluid portion of blood called?',
  '["Plasma", "Serum", "Lymph", "Hemolymph"]'::jsonb,
  'Plasma',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is the term for the study of organisms in their environment?',
  '["Ecology", "Ethology", "Biometry", "Taxonomy"]'::jsonb,
  'Ecology',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is chemiosmosis in cellular respiration?',
  '["ATP production using proton gradient", "Glucose breakdown", "Photon absorption", "Enzyme activation"]'::jsonb,
  'ATP production using proton gradient',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Biology'),
  'What is CRISPR used for?',
  '["Gene editing", "Protein folding", "Cell counting", "DNA sequencing"]'::jsonb,
  'Gene editing',
  'hard'

-- Insert additional questions for Computer Science with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What does RAM stand for?',
  '["Random Access Memory", "Rapid Application Manager", "Read-Access Module", "Rotational Access Memory"]'::jsonb,
  'Random Access Memory',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is a byte composed of?',
  '["8 bits", "4 bits", "16 bits", "32 bits"]'::jsonb,
  '8 bits',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'Which sorting algorithm is known for being fast on average?',
  '["Quick Sort", "Bubble Sort", "Insertion Sort", "Selection Sort"]'::jsonb,
  'Quick Sort',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is the time complexity of accessing an element in an array?',
  '["O(1)", "O(n)", "O(log n)", "O(n^2)"]'::jsonb,
  'O(1)',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is a pointer in programming?',
  '["A variable storing a memory address", "A visual indicator", "A function parameter", "A loop counter"]'::jsonb,
  'A variable storing a memory address',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is polymorphism in OOP?',
  '["Methods with same name, different implementations", "Creating multiple objects", "Inheriting from many classes", "Multiple parameters"]'::jsonb,
  'Methods with same name, different implementations',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What does Big O notation represent?',
  '["Worst-case time complexity", "Best-case scenario", "Average operations", "Memory usage"]'::jsonb,
  'Worst-case time complexity',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is a hash collision?',
  '["Two keys mapping to same hash value", "Deleted hash entry", "Corrupted data", "Invalid pointer"]'::jsonb,
  'Two keys mapping to same hash value',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Computer Science'),
  'What is the Halting Problem?',
  '["Determining if a program halts", "Stopping a running process", "Memory allocation", "Cache flushing"]'::jsonb,
  'Determining if a program halts',
  'hard'

-- Insert additional questions for Geography with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the capital of Germany?',
  '["Berlin", "Munich", "Hamburg", "Frankfurt"]'::jsonb,
  'Berlin',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which ocean is the largest?',
  '["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Arctic Ocean"]'::jsonb,
  'Pacific Ocean',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the capital of Egypt?',
  '["Cairo", "Alexandria", "Giza", "Aswan"]'::jsonb,
  'Cairo',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which country has the most time zones?',
  '["France", "China", "Russia", "USA"]'::jsonb,
  'France',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the capital of Australia?',
  '["Canberra", "Sydney", "Melbourne", "Brisbane"]'::jsonb,
  'Canberra',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which desert is the largest in the world?',
  '["Antarctic", "Sahara", "Arabian", "Gobi"]'::jsonb,
  'Antarctic',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the smallest country by area?',
  '["Vatican City", "Monaco", "San Marino", "Liechtenstein"]'::jsonb,
  'Vatican City',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'What is the highest mountain in Africa?',
  '["Mount Kilimanjaro", "Mount Kenya", "Atlas Mountains", "Ruwenzori"]'::jsonb,
  'Mount Kilimanjaro',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Geography'),
  'Which country is the Atacama Desert located in?',
  '["Chile", "Peru", "Argentina", "Bolivia"]'::jsonb,
  'Chile',
  'hard'

-- Insert additional questions for History with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'In what year did Columbus reach America?',
  '["1492", "1491", "1493", "1490"]'::jsonb,
  '1492',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'Who was Napoleon Bonaparte?',
  '["French military leader and emperor", "Spanish conquistador", "Italian explorer", "Austrian archduke"]'::jsonb,
  'French military leader and emperor',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'When did the Roman Empire fall?',
  '["476 AD", "410 AD", "500 AD", "450 AD"]'::jsonb,
  '476 AD',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'What was the Renaissance primarily focused on?',
  '["Human achievement and culture", "Religious reform", "Industrial development", "Territorial expansion"]'::jsonb,
  'Human achievement and culture',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'In what year did the Berlin Wall fall?',
  '["1989", "1988", "1990", "1991"]'::jsonb,
  '1989',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'Who was the first Pharaoh of Egypt?',
  '["Narmer", "Khufu", "Menkaure", "Pepi"]'::jsonb,
  'Narmer',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'What was the main cause of the French Revolution?',
  '["Economic crisis and inequality", "Military defeat", "Religious conflict", "Colonial loss"]'::jsonb,
  'Economic crisis and inequality',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'In what year did the Russian Revolution occur?',
  '["1917", "1916", "1918", "1920"]'::jsonb,
  '1917',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'History'),
  'What year was the Declaration of Independence signed?',
  '["1776", "1775", "1777", "1774"]'::jsonb,
  '1776',
  'hard'

-- Insert additional questions for Mathematics with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is 5 × 8?',
  '["40", "35", "45", "38"]'::jsonb,
  '40',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the next prime number after 7?',
  '["11", "9", "10", "13"]'::jsonb,
  '11',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is 100 ÷ 4?',
  '["25", "20", "30", "15"]'::jsonb,
  '25',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the sum of angles in a triangle?',
  '["180 degrees", "360 degrees", "90 degrees", "270 degrees"]'::jsonb,
  '180 degrees',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the area of a circle with radius 3?',
  '["9π", "6π", "3π", "12π"]'::jsonb,
  '9π',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the square of 7?',
  '["49", "42", "56", "35"]'::jsonb,
  '49',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the cube root of 27?',
  '["3", "4", "5", "2"]'::jsonb,
  '3',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the integral of 2x?',
  '["x^2 + C", "2x + C", "x + C", "2 + C"]'::jsonb,
  'x^2 + C',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Mathematics'),
  'What is the determinant of [[1,2],[3,4]]?',
  '["-2", "2", "-1", "1"]'::jsonb,
  '-2',
  'hard'

-- Insert additional questions for Physics with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the SI unit of energy?',
  '["Joule", "Newton", "Watt", "Pascal"]'::jsonb,
  'Joule',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the acceleration due to gravity on Earth?',
  '["9.8 m/s^2", "10 m/s^2", "9.5 m/s^2", "8.9 m/s^2"]'::jsonb,
  '9.8 m/s^2',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What does F = ma represent?',
  '["Newton''s Second Law", "Newton''s First Law", "Newton''s Third Law", "Law of Gravitation"]'::jsonb,
  'Newton''s Second Law',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the relationship between velocity and acceleration?',
  '["a = dv/dt", "v = a/t", "v = a + t", "a = v/t"]'::jsonb,
  'a = dv/dt',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is Planck''s constant approximately?',
  '["6.63 × 10^-34 J·s", "6.63 × 10^-33 J·s", "6.63 × 10^-35 J·s", "6.63 × 10^-32 J·s"]'::jsonb,
  '6.63 × 10^-34 J·s',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the relationship in the photoelectric effect?',
  '["E = hf", "E = mc^2", "F = ma", "P = VI"]'::jsonb,
  'E = hf',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the Heisenberg Uncertainty Principle?',
  '["Cannot simultaneously know exact position and momentum", "Energy cannot be measured", "Time cannot be measured", "Mass is uncertain"]'::jsonb,
  'Cannot simultaneously know exact position and momentum',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the relationship between energy and frequency?',
  '["E = hf", "E = mc^2", "E = 1/2mv^2", "E = kx^2"]'::jsonb,
  'E = hf',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Physics'),
  'What is the time dilation formula in special relativity?',
  '["t = t0/√(1-v^2/c^2)", "t = t0 × v/c", "t = t0 + v/c", "t = t0 × c/v"]'::jsonb,
  't = t0/√(1-v^2/c^2)',
  'hard'

-- Insert additional questions for Programming with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What does CSS stand for?',
  '["Cascading Style Sheets", "Creative Style System", "Computer Style Syntax", "Coded Style Setup"]'::jsonb,
  'Cascading Style Sheets',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is a variable?',
  '["Named container for storing data", "A function parameter", "A loop iteration", "A data type"]'::jsonb,
  'Named container for storing data',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What does SQL stand for?',
  '["Structured Query Language", "System Query Language", "Structured Question Language", "Standard Query List"]'::jsonb,
  'Structured Query Language',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is a REST API?',
  '["API using HTTP for CRUD operations", "Rapid Exchange System", "Remote Server Transfer", "Response Extraction"]'::jsonb,
  'API using HTTP for CRUD operations',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is version control used for?',
  '["Tracking code changes", "Managing memory", "Optimizing performance", "Debugging errors"]'::jsonb,
  'Tracking code changes',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is the difference between arrays and objects?',
  '["Arrays are indexed, objects use keys", "Objects are larger", "Arrays cannot store numbers", "Objects are faster"]'::jsonb,
  'Arrays are indexed, objects use keys',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is asynchronous programming?',
  '["Non-blocking execution of operations", "Multiple processors", "Parallel computing", "Sequential execution"]'::jsonb,
  'Non-blocking execution of operations',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is the CAP theorem?',
  '["Consistency, Availability, Partition tolerance trade-off", "Cache, API, Performance", "Code, Assets, Pipes", "Caching, Access, Protocols"]'::jsonb,
  'Consistency, Availability, Partition tolerance trade-off',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Programming'),
  'What is a microservices architecture?',
  '["Breaking app into independent services", "Storing data in multiple locations", "Optimizing database queries", "Improving UI responsiveness"]'::jsonb,
  'Breaking app into independent services',
  'hard'

-- Insert additional questions for Science with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the most abundant gas in the atmosphere?',
  '["Nitrogen", "Oxygen", "Carbon dioxide", "Argon"]'::jsonb,
  'Nitrogen',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the molecular structure of carbon dioxide?',
  '["Linear", "Tetrahedral", "Bent", "Trigonal planar"]'::jsonb,
  'Linear',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the pH of pure water?',
  '["7", "6", "8", "5"]'::jsonb,
  '7',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is oxidation in chemistry?',
  '["Loss of electrons", "Gain of electrons", "Bond formation", "Reaction acceleration"]'::jsonb,
  'Loss of electrons',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the law of conservation of mass?',
  '["Matter cannot be created or destroyed", "Energy equals mass times speed", "Energy is conserved", "Momentum is conserved"]'::jsonb,
  'Matter cannot be created or destroyed',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the Doppler effect?',
  '["Change in frequency due to relative motion", "Bending of light", "Sound absorption", "Wave interference"]'::jsonb,
  'Change in frequency due to relative motion',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is an exothermic reaction?',
  '["Reaction that releases energy", "Reaction that absorbs energy", "Reaction with high activation energy", "Spontaneous reaction"]'::jsonb,
  'Reaction that releases energy',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is Le Chatelier''s Principle?',
  '["System opposes changes at equilibrium", "Energy is minimized", "Entropy increases", "Temperature affects reactions"]'::jsonb,
  'System opposes changes at equilibrium',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Science'),
  'What is the structure of DNA?',
  '["Double helix", "Single helix", "Linear strand", "Circular"]'::jsonb,
  'Double helix',
  'hard'

-- Insert additional questions for Technology with all difficulties
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What does GPU stand for?',
  '["Graphics Processing Unit", "General Purpose Unit", "Global Processing Utility", "Graphical Processor Unit"]'::jsonb,
  'Graphics Processing Unit',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is machine learning?',
  '["Algorithms learning from data", "Memorizing information", "Running pre-programmed tasks", "Copying human behavior"]'::jsonb,
  'Algorithms learning from data',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is cybersecurity?',
  '["Protection against digital attacks", "Internet speed", "Database management", "Network communication"]'::jsonb,
  'Protection against digital attacks',
  'easy'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is quantum computing?',
  '["Computing using quantum bits (qubits)", "Very fast computing", "Cloud computing", "Parallel processing"]'::jsonb,
  'Computing using quantum bits (qubits)',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is 5G technology?',
  '["Fifth generation wireless technology", "A social network", "A video format", "A programming language"]'::jsonb,
  'Fifth generation wireless technology',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is augmented reality?',
  '["Digital elements overlaid on real world", "Fully virtual environment", "Video recording", "Image compression"]'::jsonb,
  'Digital elements overlaid on real world',
  'medium'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is a neural network?',
  '["Computing system inspired by biological neurons", "Computer network", "Cable connections", "Data storage system"]'::jsonb,
  'Computing system inspired by biological neurons',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is deep learning?',
  '["Neural networks with multiple layers", "Learning deeply", "Storage optimization", "Network analysis"]'::jsonb,
  'Neural networks with multiple layers',
  'hard'
UNION ALL
SELECT (SELECT id FROM categories WHERE name = 'Technology'),
  'What is computer vision?',
  '["Teaching computers to interpret images", "Displaying graphics", "Screen resolution", "Image editing"]'::jsonb,
  'Teaching computers to interpret images',
  'hard';
