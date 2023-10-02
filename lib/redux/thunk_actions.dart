import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_redux_firebase/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../firebase_options.dart';

ThunkAction signInWithEmailAndPassword(String email, String password) {
  return (Store store) async {
    store.dispatch(UserLoading());
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      store.dispatch(UserSuccess(result.user));
    } catch (error) {
      store.dispatch(UserError(error));
    }
  };
}

ThunkAction createUserWithEmailAndPassword(String email, String password) {
  return (Store store) async {
    store.dispatch(UserLoading());
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      store.dispatch(UserSuccess(result.user));
    } catch (error) {
      store.dispatch(UserError(error));
    }
  };
}

ThunkAction signInWithGoogle() {
  return (Store store) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(clientId: DefaultFirebaseOptions.ios.iosClientId)
            .signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    store.dispatch(UserSuccess(result.user));
  };
}

ThunkAction signOut() {
  return (Store store) async {
    try {
      await FirebaseAuth.instance.signOut();
      store.dispatch(UserSuccess(null));
    } catch (error) {
      store.dispatch(UserError(error));
    }
  };
}
