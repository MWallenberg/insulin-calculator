import 'package:flutter/material.dart';
import 'package:insulin_calc/models/preferences.dart';
import 'package:insulin_calc/screens/adjust/adjust.dart';
import 'package:insulin_calc/screens/meal/meal.dart';
import 'package:insulin_calc/screens/settings/settings.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StartState();
  }
}

class _StartState extends State<Start> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MealScreen(),
    AdjustScreen(),
    SettingsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Preferences(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Insulin Calculator'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.restaurant),
              title: Text('Eat'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.timeline),
              title: Text('Adjust'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: Text('Settings'),
            )
          ],
        ),
      ),
    );
  }
}
