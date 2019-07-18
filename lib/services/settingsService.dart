import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final String _dailyDoseName = "dailyDose";
  static final String _targetMmolName = "targetMmol";

  static Future<int> getDailyDose() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_dailyDoseName) ?? 0;
  }

  static Future<bool> setDailyDose(int dailyDose) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_dailyDoseName, dailyDose);
  }

  static Future<double> getTargetBloodSugar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // We need to set a sensible default here. Otherwise, the app might suggest dangerous insulin levels.
    return prefs.getDouble(_targetMmolName) ?? 7.0;
  }

  static Future<bool> setTargetBloodSugar(double dailyDose) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_targetMmolName, dailyDose);
  }
}

