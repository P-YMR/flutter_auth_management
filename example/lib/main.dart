import 'package:auth_management/core.dart';
import 'package:auth_management_apple_delegate/auth_management_apple_delegate.dart';
import 'package:auth_management_biometric_delegate/auth_management_biometric_delegate.dart';
import 'package:auth_management_facebook_delegate/auth_management_facebook_delegate.dart';
import 'package:auth_management_google_delegate/auth_management_google_delegate.dart';
import 'package:example/startup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'backup_delegate.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthProvider<UserModel>(
      initialCheck: true,
      controller: AuthController.getInstance<UserModel>(
        backup: UserBackupDelegate(),
        oauth: OAuthDelegates(
          appleAuthDelegate: AppleAuthDelegate(),
          biometricAuthDelegate: BiometricAuthDelegate(),
          facebookAuthDelegate: FacebookAuthDelegate(),
          googleAuthDelegate: GoogleAuthDelegate(),
        ),
      ),
      child: const MaterialApp(
        title: 'Auth Management',
        onGenerateRoute: routes,
      ),
    );
  }
}

Route<T> routes<T>(RouteSettings settings) {
  final name = settings.name;
  if (name == "home") {
    return MaterialPageRoute(
      builder: (_) {
        return const HomePage();
      },
    );
  } else if (name == "login") {
    return MaterialPageRoute(
      builder: (_) {
        return const LoginPage();
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (_) {
        return const StartupPage();
      },
    );
  }
}
