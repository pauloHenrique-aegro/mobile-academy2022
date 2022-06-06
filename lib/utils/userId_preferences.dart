import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  final String _idKey = 'id';

  Future setExternalUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_idKey, id);
  }

  Future<String> getExternalUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey)!;
  }

  Future<bool> containsIdKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_idKey);
  }

  Future prefsClear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_idKey);
  }
}
