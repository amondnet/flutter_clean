import 'package:injectable/injectable.dart';

@Singleton()
class Authenticator {
  //Learning purpose: We assume the user is always logged in
  //Here you should put your own logic to return whether the user
  //is authenticated or not
  bool get userLoggedIn => true;
}