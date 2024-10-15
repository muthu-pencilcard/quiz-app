import 'dart:math';

import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  final int numberOfCards;

  const CardExample({Key? key, required this.numberOfCards}) : super(key: key);

  @override
  _CardExampleState createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  late List<Map<String, dynamic>> _cardData;
  int _currentIndex = 0;
  List<String> _selectedOptions = [];

  final List<Map<String, dynamic>> _allQuestions = [
    {
      'question': 'What is your favorite color?',
      'options': ['Red', 'Blue', 'Green', 'Yellow'],
      'correctAnswer': 'Blue'
    },
    {
      'question': 'Which season do you prefer?',
      'options': ['Spring', 'Summer', 'Autumn', 'Winter'],
      'correctAnswer': 'Summer'
    },
    {
      'question': 'Choose a pet:',
      'options': ['Dog', 'Cat', 'Bird', 'Fish'],
      'correctAnswer': 'Dog'
    },
    {
      'question': 'What\'s your favorite cuisine?',
      'options': ['Italian', 'Chinese', 'Mexican', 'Indian'],
      'correctAnswer': 'Italian'
    },
    {
      'question': 'Which sport do you enjoy watching?',
      'options': ['Football', 'Basketball', 'Tennis', 'Swimming'],
      'correctAnswer': 'Basketball'
    },
    {
      'question': 'What\'s your preferred mode of transportation?',
      'options': ['Car', 'Bicycle', 'Train', 'Walking'],
      'correctAnswer': 'Bicycle'
    },
    {
      'question': 'Which\'s your favorite place?',
      'options': ['switzerland', 'Kodaikanal', 'ooty', 'Kodiveri'],
      'correctAnswer': 'ooty'
    },
  ];

  @override
  void initState() {
    super.initState();
    _cardData = _getRandomQuestions(widget.numberOfCards);
  }

  List<Map<String, dynamic>> _getRandomQuestions(int count) {
    final random = Random();
    final List<Map<String, dynamic>> selectedQuestions = [];
    final List<int> indices =
        List.generate(_allQuestions.length, (index) => index);

    for (int i = 0; i < count && indices.isNotEmpty; i++) {
      final int randomIndex = random.nextInt(indices.length);
      final int selectedIndex = indices[randomIndex];
      selectedQuestions.add(_allQuestions[selectedIndex]);
      indices.removeAt(randomIndex);
    }

    return selectedQuestions;
  }

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! > 0) {
      // Swiped right
      setState(() {
        _currentIndex = (_currentIndex - 1).clamp(0, _cardData.length);
      });
    } else if (details.primaryVelocity! < 0) {
      // Swiped left
      setState(() {
        _currentIndex = (_currentIndex + 1).clamp(0, _cardData.length);
      });
    }
  }

  void _selectOption(String option) {
    setState(() {
      if (_currentIndex < _selectedOptions.length) {
        _selectedOptions[_currentIndex] = option;
      } else {
        _selectedOptions.add(option);
      }
      _currentIndex = (_currentIndex + 1).clamp(0, _cardData.length);
    });
  }

  Widget _buildQuestionCard(int index) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _cardData[index]['question'],
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ..._cardData[index]['options']
                .map<Widget>(
                  (option) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () => _selectOption(option),
                      child: Text(option),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                      ),
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 20),
            Text(
              'Swipe to change questions',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    int correctAnswers = 0;
    for (int i = 0; i < _selectedOptions.length; i++) {
      if (_selectedOptions[i] == _cardData[i]['correctAnswer']) {
        correctAnswers++;
      }
    }
    double percentageCorrect = (correctAnswers / _cardData.length) * 100;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 300,
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Results',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              for (int i = 0; i < _selectedOptions.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        _cardData[i]['question'],
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Your answer: ${_selectedOptions[i]}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Correct answer: ${_cardData[i]['correctAnswer']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Icon(
                        _selectedOptions[i] == _cardData[i]['correctAnswer']
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                            _selectedOptions[i] == _cardData[i]['correctAnswer']
                                ? Colors.green
                                : Colors.red,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Total Correct: $correctAnswers out of ${_cardData.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Percentage Correct: ${percentageCorrect.toStringAsFixed(2)}%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),
              Text(
                'Swipe right to review questions',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Quiz')),
      body: Center(
        child: GestureDetector(
          onHorizontalDragEnd: _handleSwipe,
          child: _currentIndex < _cardData.length
              ? _buildQuestionCard(_currentIndex)
              : _buildSummaryCard(),
        ),
      ),
    );
  }
}
