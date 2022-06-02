import 'package:shared_preferences/shared_preferences.dart';

class UserIdPreferences {
  final String _key = 'id';

  Future setExternalUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, id);
  }

  Future<String> getExternalUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key)!;
  }
}
