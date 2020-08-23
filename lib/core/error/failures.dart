import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class BottleFailure extends Failure {
  final String message;

  BottleFailure(this.message);
}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}

class PlatformFailure extends Failure {}

class CacheFailure extends Failure {}
