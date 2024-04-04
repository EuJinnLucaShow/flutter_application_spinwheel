import 'package:flutter/material.dart';
import 'quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreensaverScreen(),
    );
  }
}

class ScreensaverScreen extends StatelessWidget {
  const ScreensaverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 85, 191),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                height: 300,
                child: Image.asset(
                  'images/balloon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(
                  300,
                  80,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Game',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                ), // Set the font size of the button text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
