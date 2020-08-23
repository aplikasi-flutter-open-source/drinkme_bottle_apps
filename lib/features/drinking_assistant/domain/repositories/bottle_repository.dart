import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/bottle_entity.dart';

abstract class BottleRepository {
  Future<Either<Failure, BottleEntity>> authenticateBottle(int bottleCode);
}
