import 'package:flutter/material.dart';
import 'package:insulin_calc/screens/start/start.dart';
import 'package:insulin_calc/theme/style.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insulin Calculator',
      theme: appTheme(),
      home: Start(),
    );
  }
}