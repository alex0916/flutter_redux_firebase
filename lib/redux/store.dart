import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux_firebase/models/resolvable.dart';

class AppState {
  final Resolvable<User> user;

  AppState({required this.user});

  AppState.initialState()
      : user = Resolvable.fromData(FirebaseAuth.instance.currentUser);
}
