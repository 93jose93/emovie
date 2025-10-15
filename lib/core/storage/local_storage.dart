import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  //static late, es cuando ya lo valla a usar ya tendra un valor
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
