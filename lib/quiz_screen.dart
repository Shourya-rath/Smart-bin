import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the primary purpose of recycling?',
      'options': [
        'A) To reduce landfill waste',
        'B) To increase plastic production',
        'C) To create more pollution',
        'D) To consume more resources'
      ],
      'correctAnswer': 0, // Index of the correct answer
    },
    {
      'question':
          'Which of the following is considered a biodegradable material?',
      'options': [
        'A) Plastic bag',
        'B) Glass bottle',
        'C) Food scraps',
        'D) Aluminum can'
      ],
      'correctAnswer': 2,
    },
  ];

  int currentQuestionIndex = 0;
  List<Color> cardColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  bool answered = false;

  void checkAnswer(int selectedIndex) {
    if (answered) return;

    setState(() {
      answered = true;
      if (selectedIndex == questions[currentQuestionIndex]['correctAnswer']) {
        cardColors[selectedIndex] = Colors.lightGreen; // Correct answer
      } else {
        cardColors[selectedIndex] = Colors.red; // Wrong answer
        cardColors[questions[currentQuestionIndex]['correctAnswer']] =
            Colors.lightGreen; // Reveal correct answer
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        cardColors = [
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white
        ]; // Reset colors
        answered = false; // Reset answered state
      } else {
        // Handle the end of the quiz (e.g., show a dialog or navigate to another screen)
        // For now, we'll just show a simple message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quiz Completed'),
            content: const Text('You have completed the quiz!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Go back to home screen
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff25d0d0),
        title: const Text('Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to home screen
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/quizlogo.png',
                width: 200,
                height: 100,
              ),
              const SizedBox(height: 16),
              Text(
                questions[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...List.generate(4, (index) {
                return GestureDetector(
                  onTap: () => checkAnswer(index),
                  child: Card(
                    color: cardColors[index],
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        questions[currentQuestionIndex]['options'][index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextQuestion,
                child: Text(
                  currentQuestionIndex < questions.length - 1 ? 'Next' : 'End',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
