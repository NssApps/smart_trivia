
class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}
class ConnectionTimeout implements Exception {}
class UnprocessableContent implements Exception {}

class CustomError implements Exception {
  final String errorMessage;

  CustomError({required this.errorMessage});
}