

import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String languageCode = "languageCode";
}

class Preference {
  static SharedPreferences? sharedPref;

  static Future<void> initialize() async {
    sharedPref = await SharedPreferences.getInstance();
  }
  static String? getString(String key) {
    try {
      return sharedPref!.getString(key);
    } catch (error) {

      return null;
    }
  }
  static Future<bool?> setString(String key, String value) async {
    try {
      return await sharedPref!.setString(key, value);
    } catch (error) {

      return null;
    }
  }
  static Future<bool?> clear() async {
    try {

      return await sharedPref!.clear();
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
    return null;
  }


}
