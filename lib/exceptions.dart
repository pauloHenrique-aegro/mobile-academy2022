class EmailInUse implements Exception {}

class InvalidFields implements Exception {}

class UserNotFound implements Exception {}

class TimeExceeded implements Exception {}

class UnavailableServer implements Exception {}

class DbException implements Exception {
  @override
  String toString() {
    return 'Erro ao conectar com o banco de dados';
  }
}
