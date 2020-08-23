class ServerException implements Exception {}

class CacheException implements Exception {}

class BottleException implements Exception {
  final String message;

  const BottleException(this.message);
}
