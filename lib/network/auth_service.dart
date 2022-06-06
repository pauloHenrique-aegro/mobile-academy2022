import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../models/api_exception.dart';
import '../utils/userId_preferences.dart';

class AuthApiService {
  static Future<void> signUp(String fullName, String email) async {
    String id = const Uuid().v4().toString();
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/user');

    try {
      final response = await http.post(url,
          body: json.encode({"id": id, "fullName": fullName, "email": email}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          }).timeout(const Duration(seconds: 20),
          onTimeout: () => throw TimeExceeded());

      var code = response.statusCode;
      if (code == 500) {
        throw EmailInUse();
      } else if (code == 400) {
        throw InvalidFields();
      } else if (code == 503) {
        throw UnavailableServer();
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> login(String email) async {
    late String _externalId;

    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/user/auth');

    try {
      final response = await http
          .post(url, body: json.encode({"email": email}), headers: {
        "content-type": "application/json",
        "accept": "application/json",
      }).timeout(const Duration(seconds: 20),
              onTimeout: () => throw TimeExceeded());

      var code = response.statusCode;
      final responseData = json.decode(response.body);
      if (responseData['id'] != null) {
        _externalId = responseData['id'];
        await UserPreferences().setExternalUserId(_externalId);
      }

      if (code == 404) {
        throw UserNotFound();
      } else if (code == 400) {
        throw InvalidFields();
      } else if (code == 503) {
        throw UnavailableServer();
      }
    } catch (error) {
      rethrow;
    }
  }
}
