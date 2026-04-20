import 'package:flutter/material.dart';
import 'package:gharsa_app/ui/auth/forgot_password_screen.dart';

import '../../ui/main/main_screen.dart';
import '../../ui/auth/login_screen.dart';
import '../../ui/auth/signup_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/';
  static const String signup = '/signup';

  static const String forgotPassword = '/forgot_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
