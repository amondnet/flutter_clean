import 'package:async/src/result/result.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clean/core/interactor/use_case.dart';
import 'package:clean/core/navigator.dart';
import 'package:flutter/widgets.dart' show BuildContext;

class PlayMovie extends UseCase<void, PlayMovieParams> {
  final BuildContext context;
  final Navigator navigator;

  PlayMovie(this.context, this.navigator);

  @override
  Future<Result<void>> call(PlayMovieParams params) async {
    return Result.value(navigator.openVideo(context, params.url));
  }
}

class PlayMovieParams {
  final String url;

  PlayMovieParams(this.url);
}
