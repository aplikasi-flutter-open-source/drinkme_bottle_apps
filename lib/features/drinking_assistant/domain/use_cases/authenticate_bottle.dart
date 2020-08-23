import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/core/usecases/usecase.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/bottle_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/bottle_repository.dart';

class AuthenticateBottle extends Usecase<BottleEntity, BottleCodeParams> {
  BottleRepository repository;

  AuthenticateBottle(this.repository);

  @override
  Future<Either<Failure, BottleEntity>> call(BottleCodeParams params) async {
    return await repository.authenticateBottle(params.bottleCode);
  }
}

class BottleCodeParams {
  final int bottleCode;

  BottleCodeParams(this.bottleCode);
}
