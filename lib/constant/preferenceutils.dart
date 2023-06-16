import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

String appId="appid";
class PreferenceUtils {

  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value) ;
  }

  static String getInt(String key, [String? defValue]) {
    return _prefsInstance!.getInt(key) as String? ?? defValue ??  0 as String ;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);



  }


  static Future<bool?> setlogin(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static bool? getlogin(String key, [bool? defValue])  {
    return _prefsInstance!.getBool(key) ?? defValue;

  }

  static void clear(){


    _prefsInstance!.clear();




  }







}