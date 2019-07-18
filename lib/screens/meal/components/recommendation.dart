import 'package:flutter/material.dart';

class DoseRecommendation extends StatelessWidget {
  final String _dose;

  DoseRecommendation({@required double dose}):
    _dose = dose?.toStringAsFixed(1);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Recommended dose: $_dose units.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ]
    );
  }
}