import 'package:meta/meta.dart' show sealed;

/// Base Class for handling errors/failures/exceptions.
/// Every feature specific failure should extend [FeatureFailure] class.
@sealed
abstract class Failure implements Exception {}

class NetworkConnection extends Failure {}

class ServerError extends Failure {
  final Object error;

  ServerError(this.error);
}

/// Extend this class for feature specific failures.
abstract class FeatureFailure extends Failure {}
