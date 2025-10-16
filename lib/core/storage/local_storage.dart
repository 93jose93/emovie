import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveJson(String key, String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json);
  }

  static Future<String?> getJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

// class LocalStorage {
//   //static late, es cuando ya lo valla a usar ya tendra un valor
//   static late SharedPreferences prefs;

//   static Future<void> configurePrefs() async {
//     prefs = await SharedPreferences.getInstance();
//   }
// }
