import 'package:seeds_system/network/auth_service.dart';

class UserRepository {
  Future<void> signUp(String fullName, String email) async {
    await AuthApiService().signUp(fullName, email);
  }

  Future<void> login(String email) async {
    await AuthApiService().login(email);
  }
}
