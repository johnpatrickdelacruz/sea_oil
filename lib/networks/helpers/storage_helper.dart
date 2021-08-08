import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static const String access_token = "ACCESS_TOKEN";
}

class StorageHelper {
  static const FlutterSecureStorage _prefs = FlutterSecureStorage();
  static Future<dynamic> _getInstance() async => _prefs;

  static Future clearSecureStorageOnReinstall() async {
    const String key = 'hasRunBefore';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(key) == true)) {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      await storage.deleteAll();
      prefs.setBool(key, true);
    }
  }

  static Future get(String key) async {
    await _getInstance();
    return _prefs.read(key: key);
  }

  static Future setVar(String key, var value) async {
    await _getInstance();
    _prefs.write(key: key, value: value.toString());
  }

  static Future set(String key, String value) async {
    await _getInstance();
    _prefs.write(key: key, value: value);
  }

  static Future remove(String key) async {
    await _getInstance();
    _prefs.delete(key: key);
  }
}
