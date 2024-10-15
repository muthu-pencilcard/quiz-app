import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final int numberOfCards;
  final ValueChanged<int> onNumberOfCardsChanged;

  const SettingsPage(
      {Key? key,
      required this.numberOfCards,
      required this.onNumberOfCardsChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select number of questions:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Slider(
            value: numberOfCards.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            label: numberOfCards.toString(),
            onChanged: (double value) {
              onNumberOfCardsChanged(value.round());
            },
          ),
        ],
      ),
    );
  }
}
