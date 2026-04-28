import 'package:flutter/material.dart';
import 'package:gharsa_app/features/auth/presentation/forgot_password_screen.dart';
import 'package:gharsa_app/features/home/presentation/profile_screen.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/soil_analysis_form.dart';

import '../../features/main/main_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String soilAnalysis = '/soil_analysis';

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
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case soilAnalysis:
        return MaterialPageRoute(builder: (_) => SoilAnalysisForm());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
