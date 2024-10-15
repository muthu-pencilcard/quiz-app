import 'package:flutter/material.dart';
import 'package:quiz_app/cards_example.dart';
import 'package:quiz_app/home_page.dart';
import 'package:quiz_app/settings_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _numberOfCards = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardExample(numberOfCards: _numberOfCards),
      ),
    );
  }

  void _updateNumberOfCards(int value) {
    setState(() {
      _numberOfCards = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Home' : 'Settings'),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? HomePage(numberOfCards: _numberOfCards, onStartQuiz: _startQuiz)
            : SettingsPage(
                numberOfCards: _numberOfCards,
                onNumberOfCardsChanged: _updateNumberOfCards,
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
