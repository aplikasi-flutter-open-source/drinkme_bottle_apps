import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<RightType, Params> {
  Future<Either<Failure, RightType>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
