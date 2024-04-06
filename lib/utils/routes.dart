import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nymble_assignment/presentation/error_screen.dart';
import 'package:nymble_assignment/presentation/login_screen.dart';
import 'package:nymble_assignment/presentation/music_home_screen.dart';
import 'package:nymble_assignment/presentation/signup_screen.dart';
import 'package:nymble_assignment/presentation/splash_screen.dart';
import 'package:nymble_assignment/utils/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return SlideRightRoute(widget: const LoginScreen());
      case RouteNames.signUp:
        return SlideRightRoute(widget: const SignupScreen());

      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const MusicHomeScreen());

      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  });
}

