// main.dart
import 'package:clean/core/exception/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'movie_failure.freezed.dart';

@freezed
class MovieFailure with _$MovieFailure {
  const factory MovieFailure() = _MovieFailure;

  @Implements(FeatureFailure)
  const factory MovieFailure.listNotAvailable() = ListNotAvailable;

  @Implements(FeatureFailure)
  const factory MovieFailure.nonExistent() = NonExistentMovie;
}
