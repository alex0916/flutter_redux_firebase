import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux_firebase/redux/store.dart';

String Function(AppState state) userErrorSelector = (AppState state) =>
    state.user.error != null
        ? (state.user.error as FirebaseAuthException).message ?? ''
        : '';
