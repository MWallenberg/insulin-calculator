import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final String _dailyDoseName = "dailyDose";

  static Future<int> getDailyDose() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_dailyDoseName) ?? 0;
  }

  static Future<bool> setDailyDose(int dailyDose) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_dailyDoseName, dailyDose);
  }
}

