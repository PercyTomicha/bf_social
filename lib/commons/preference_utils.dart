import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<List<String>> getListString(String key) async {
    final p = await prefs;
    return p.getStringList(key) ?? [];
  }
  
  static Future setStringList(String key, List<String> value) async {
    final p = await prefs;
    return p.setStringList(key, value);
  }
}