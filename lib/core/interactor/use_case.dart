import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

/// Abstract class for a Use Case (Interactor in terms of Clean Architecture).
/// This abstraction represents an execution unit for different use cases (this means that any use
/// case in the application should implement this contract).
abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}
@immutable
class None {}