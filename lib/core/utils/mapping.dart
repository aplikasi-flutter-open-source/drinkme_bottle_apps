import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/core/utils/const.dart';
import 'package:drinking_assistant/core/utils/input_converter.dart';

class Mapping {
  static String failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidInputFailure:
        return INPUT_FAILURE_MESSAGE;
      case BottleFailure:
        final bottleFailure = failure as BottleFailure;
        return bottleFailure.message;
      default:
        return 'Unexpected Error';
    }
  }
}
