import 'package:flutter/material.dart';

class AdjustmentRecommendation extends StatelessWidget {
  final String _dose;
  final String _gramCarbs;

  AdjustmentRecommendation({double dose, double gramCarbs}):
    _dose = dose?.toStringAsFixed(1),
    _gramCarbs = gramCarbs?.toStringAsFixed(0);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: _dose != null,
          child: Text(
            'Your blood sugar is too high.\nConsider taking insulin.\nRecommended dose: $_dose units.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Visibility(
          visible: _gramCarbs != null,
          child: Text(
            'Your blood sugar is too low.\nConsider eating carbohydrates.\nRecommended meal: $_gramCarbs grams of carbs.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ]
    );
  }
}