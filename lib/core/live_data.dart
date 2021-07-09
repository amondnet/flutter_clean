import 'dart:async';

import 'package:async/async.dart';

class LiveData<T> implements Result<T> {
  final Result<T> _result;

  LiveData(this._result);

  @override
  void addTo(EventSink<T> sink) {
    _result.addTo(sink);
  }

  @override
  ErrorResult? get asError => _result.asError;

  @override
  Future<T> get asFuture => _result.asFuture;

  @override
  ValueResult<T>? get asValue => _result.asValue;

  @override
  void complete(Completer<T> completer) {
    _result.complete(completer);
  }

  @override
  bool get isError => _result.isError;

  @override
  bool get isValue => _result.isValue;
}
