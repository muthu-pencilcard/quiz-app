import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int numberOfCards;
  final VoidCallback onStartQuiz;

  const HomePage(
      {Key? key, required this.numberOfCards, required this.onStartQuiz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Quiz App!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20),
          Text(
            'Number of questions: $numberOfCards',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onStartQuiz,
            child: Text('Generate Quiz'),
          ),
        ],
      ),
    );
  }
}
