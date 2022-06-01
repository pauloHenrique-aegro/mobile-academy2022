import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../models/api_exception.dart';

class UserRepository {
  Future<void> signUp(String fullName, String email) async {
    String id = const Uuid().v4().toString();
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/user');

    try {
      final response = await http.post(url,
          body: json.encode({"id": id, "fullName": fullName, "email": email}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          });
      var code = response.statusCode;
      if (code == 409) {
        throw EmailInUse();
      } else if (code == 400) {
        throw InvalidFields();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email) async {
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/user/auth');

    try {
      final response =
          await http.post(url, body: json.encode({"email": email}), headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });

      var code = response.statusCode;
      print(code);
      print(response.body);
      if (code == 404) {
        throw UserNotFound();
      } else if (code == 400) {
        throw InvalidFields();
      }
    } catch (error) {
      rethrow;
    }
  }
}
