import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux_firebase/models/resolvable.dart';
import 'package:flutter_redux_firebase/redux/actions.dart';
import 'package:flutter_redux_firebase/redux/store.dart';
import 'package:redux/redux.dart';

Resolvable<User> _setUserLoading(Resolvable<User> _, UserLoading __) =>
    Resolvable.loading();

Resolvable<User> _setUserIdle(Resolvable<User> _, UserIdle __) =>
    Resolvable.idle();

Resolvable<User> _setUserError(Resolvable<User> _, UserError action) =>
    Resolvable.fromError(action.error);

Resolvable<User> _setUser(Resolvable<User> _, UserSuccess action) =>
    Resolvable.fromData(action.user);

final userReducer = combineReducers<Resolvable<User>>([
  TypedReducer<Resolvable<User>, UserLoading>(_setUserLoading),
  TypedReducer<Resolvable<User>, UserIdle>(_setUserIdle),
  TypedReducer<Resolvable<User>, UserError>(_setUserError),
  TypedReducer<Resolvable<User>, UserSuccess>(_setUser),
]);

AppState appStateReducer(AppState state, action) =>
    AppState(user: userReducer(state.user, action));
