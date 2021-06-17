import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class Navigator {
  void openVideo(BuildContext context, String videoUrl) {
    AutoRouter.of(context).pushNamed('path');
  }
}
