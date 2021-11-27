import 'package:dasgal/presentation/screens/authentication/register.dart';
import 'package:dasgal/presentation/screens/introduction.dart';
import 'package:dasgal/presentation/screens/main/main.dart';
import 'package:dasgal/presentation/screens/splash.dart';
import 'package:dasgal/presentation/screens/term_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/options':
        return MaterialPageRoute(
          builder: (_) => const IntroductionScreen(),
        );
      case '/main':
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case '/term':
        return MaterialPageRoute(
          builder: (_) => const TermScreen(),
        );
      // case '/main':
      //   return PageRouteBuilder(
      //       settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
      //       pageBuilder: (_, __, ___) => MainHome(),
      //       transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
