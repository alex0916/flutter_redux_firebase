import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux_firebase/redux/reducers.dart';
import 'package:flutter_redux_firebase/redux/store.dart';
import 'package:flutter_redux_firebase/services/services.dart';

import 'firebase_options.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // register singleton for navigation
  setupLocator();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = locator<NavigationService>().navigatorKey;
  // Initialize redux store
  final _store = Store(appStateReducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  void initState() {
    super.initState();

    // Listen for changes sign in / out
    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? 'home' : 'login',
      );
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
          title: 'Test',
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: ThemeMode.system,
          navigatorKey: _navigatorKey,
          initialRoute: _store.state.user.data == null ? 'login' : 'home',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case 'home':
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => const HomePage(
                    title: 'Test',
                  ),
                );
              case 'login':
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => const LoginPage(),
                );
              case 'register':
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => const RegisterPage(),
                );
              default:
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => const LoginPage(),
                );
            }
          }),
    );
  }
}
