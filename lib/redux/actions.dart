import 'package:firebase_auth/firebase_auth.dart';

class UserLoading {}

class UserIdle {}

class UserError {
  dynamic error;
  UserError(this.error);
}

class UserSuccess {
  User? user;
  UserSuccess(this.user);
}