
class ServerResponseContainErrorException implements Exception {
  final String message;

  ServerResponseContainErrorException(this.message);
}

class ServerException implements Exception {

}

