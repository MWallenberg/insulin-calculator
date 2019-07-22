import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  int _dailyDose;
  double _targetMmol;
  SharedPreferences _prefs;

  static final String _dailyDoseName = "dailyDose";
  static final String _targetMmolName = "targetMmol";

  Preferences() {
    _initValues();
  }

  void _initValues() async {
    _prefs = await SharedPreferences.getInstance();
    _dailyDose = _prefs.getInt(_dailyDoseName) ?? 0;

    // We need to set a sensible default here. Otherwise, the app might suggest dangerous insulin levels.
    _targetMmol = _prefs.getDouble(_targetMmolName) ?? 7.0;
  }

  int getDailyDose() => _dailyDose;

  double getTargetMmol() => _targetMmol;

  void setDailyDose(int dailyDose) {
    _prefs.setInt(_dailyDoseName, dailyDose);
    _dailyDose = dailyDose;
    notifyListeners();
  }

  void setTargetBloodSugar(double targetMmol) {
    _prefs.setDouble(_targetMmolName, targetMmol);
    _targetMmol = targetMmol;
    notifyListeners();
  }
}