import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import 'exception/failure.dart';

abstract class BaseViewModel {
  final Observable<Failure?> _failure = Observable(null);

  Observable<Failure?> get failure => _failure;

  @protected
  Failure handleFailure(Failure failure) {
    return _failure.value = failure;
  }
}
