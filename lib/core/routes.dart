import 'package:e_shop/screens/home_screen.dart';
import 'package:e_shop/screens/signin_screen.dart';
import 'package:e_shop/screens/signup_screen.dart';
import 'package:e_shop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case '/':
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case '/home':
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case '/signup':
        return PageTransition(
          child: SignUpScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case '/signin':
        return PageTransition(
          child: SignInScreen(),
          type: PageTransitionType.rightToLeft,
        );
    }
    return PageTransition(
      child: SignInScreen(),
      type: PageTransitionType.rightToLeft,
    );
    ;
  }
}
