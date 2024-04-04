import 'dart:math';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;

  static final List<Map<String, dynamic>> questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'Madrid', 'score': 0},
        {'text': 'Berlin', 'score': 0},
        {'text': 'Paris', 'score': 100},
        {'text': 'Rome', 'score': 0},
      ],
    },
    {
      'questionText': 'Who wrote "Romeo and Juliet"?',
      'answers': [
        {'text': 'Charles Dickens', 'score': 0},
        {'text': 'William Shakespeare', 'score': 100},
        {'text': 'Mark Twain', 'score': 0},
        {'text': 'Jane Austen', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the chemical symbol for water?',
      'answers': [
        {'text': 'H2O', 'score': 100},
        {'text': 'CO2', 'score': 0},
        {'text': 'NaCl', 'score': 0},
        {'text': 'O2', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': [
        {'text': 'Jupiter', 'score': 0},
        {'text': 'Mars', 'score': 100},
        {'text': 'Venus', 'score': 0},
        {'text': 'Saturn', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the tallest mammal on Earth?',
      'answers': [
        {'text': 'Elephant', 'score': 0},
        {'text': 'Giraffe', 'score': 100},
        {'text': 'Horse', 'score': 0},
        {'text': 'Rhino', 'score': 0},
      ],
    },
    {
      'questionText': 'Which country is home to the kangaroo?',
      'answers': [
        {'text': 'Australia', 'score': 100},
        {'text': 'Brazil', 'score': 0},
        {'text': 'Canada', 'score': 0},
        {'text': 'India', 'score': 0},
      ],
    },
    {
      'questionText': 'Who painted the Mona Lisa?',
      'answers': [
        {'text': 'Pablo Picasso', 'score': 0},
        {'text': 'Leonardo da Vinci', 'score': 100},
        {'text': 'Vincent van Gogh', 'score': 0},
        {'text': 'Michelangelo', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the largest ocean on Earth?',
      'answers': [
        {'text': 'Atlantic Ocean', 'score': 0},
        {'text': 'Indian Ocean', 'score': 0},
        {'text': 'Pacific Ocean', 'score': 100},
        {'text': 'Arctic Ocean', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is known as the "Morning Star"?',
      'answers': [
        {'text': 'Mars', 'score': 0},
        {'text': 'Mercury', 'score': 100},
        {'text': 'Venus', 'score': 0},
        {'text': 'Jupiter', 'score': 0},
      ],
    },
    {
      'questionText': 'Who wrote "To Kill a Mockingbird"?',
      'answers': [
        {'text': 'J.K. Rowling', 'score': 0},
        {'text': 'Harper Lee', 'score': 100},
        {'text': 'Stephen King', 'score': 0},
        {'text': 'Ernest Hemingway', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 85, 191),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 28, 85, 191),
      body: _currentQuestionIndex < questions.length
          ? QuizQuestion(
              question: questions[_currentQuestionIndex],
              answerQuestion: _answerQuestion,
            )
          : QuizResult(
              totalScore: _totalScore,
              resetQuiz: _resetQuiz,
            ),
    );
  }
}

class QuizQuestion extends StatelessWidget {
  final Map<String, dynamic> question;
  final Function(int) answerQuestion;

  const QuizQuestion({
    super.key,
    required this.question,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(30),
          child: Text(
            question['questionText'],
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 30),
        ...question['answers'].map<Widget>((answer) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () => answerQuestion(answer['score']),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(
                  350,
                  80,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                answer['text'],
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 8, 76, 132),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ignore: must_be_immutable
class QuizResult extends StatefulWidget {
  int totalScore;
  final Function resetQuiz;

  QuizResult({
    super.key,
    required this.totalScore,
    required this.resetQuiz,
  });

  @override
  QuizResultState createState() => QuizResultState();
}

class QuizResultState extends State<QuizResult>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotationAngle = 0.0;

  final List<MultiplierSection> multiplierSections = [
    MultiplierSection(startAngle: 0, endAngle: 72, multiplier: 5),
    MultiplierSection(startAngle: 72, endAngle: 144, multiplier: 10),
    MultiplierSection(startAngle: 144, endAngle: 216, multiplier: 25),
    MultiplierSection(startAngle: 216, endAngle: 288, multiplier: 1),
    MultiplierSection(startAngle: 288, endAngle: 360, multiplier: 1),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSpin() {
    _controller.reset();
    _controller.forward().then((value) {
      final sectionIndex = getSectionIndex(_rotationAngle);
      final multiplier = multiplierSections[sectionIndex].multiplier;
      final updatedScore = widget.totalScore * multiplier;

      setState(() {
        widget.totalScore = updatedScore;
      });
    });
  }

  int getSectionIndex(double angle) {
    double normalizedAngle = angle % (2 * pi);
    if (normalizedAngle < 0) {
      normalizedAngle += (2 * pi);
    }
    for (int i = 0; i < multiplierSections.length; i++) {
      final section = multiplierSections[i];
      if (normalizedAngle >= section.startAngle &&
          normalizedAngle < section.endAngle) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your score: ${widget.totalScore}',
              style: const TextStyle(fontSize: 40, color: Colors.white)),
          const SizedBox(height: 30),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              _rotationAngle = _controller.value * pi * 2.0;
              return Transform.rotate(
                angle: _rotationAngle,
                child: child,
              );
            },
            child: Image.asset(
              'images/wheel.png',
              fit: BoxFit.contain,
              width: 350,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _startSpin,
            child: Container(
              width: 300,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 216, 72),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 6, 57, 99),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiplierSection {
  final double startAngle;
  final double endAngle;
  final int multiplier;

  MultiplierSection({
    required this.startAngle,
    required this.endAngle,
    required this.multiplier,
  });
}
