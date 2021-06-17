import 'package:async/async.dart';
import 'package:clean/core/exception/failure.dart';

extension ResultX<T> on Result<T> {
  Failure get failure => asError!.error as Failure;

  static Future<Result<R>> fromNetwork<R>(Future<R> future) {
    return future.then((value) => ValueResult(value),
        onError: (Object error, StackTrace stackTrace) =>
            ErrorResult(ServerError(error), stackTrace));
  }
}
