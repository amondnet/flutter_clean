import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

// name: Resource
part 'resource.freezed.dart';

/// A generic class that holds a value with its loading status.

@freezed
class Resource<T> with _$Resource<T> {
  const factory Resource(T data) = Data<T>;

  const factory Resource.error(String msg, T? data) = Error<T>;

  const factory Resource.loading(T? data) = Loading<T>;

  /*
  void addTo(EventSink<Resource<T>> sink) {
    sink.add(this);
  }*/

//Future<T> get asFuture => Future.value(this.data);
}
