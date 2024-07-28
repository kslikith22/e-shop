import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_shop/core/theme.dart';
import 'package:e_shop/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    late String uid;


  @override
  void initState() {
    super.initState();
      Preferences().initialize().then((_) {
      uid = Preferences().getUid();
      _handleNextScreen();
    });
  }
void _handleNextScreen() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        if (uid.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/signin');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Text(
            "E-Shop",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      duration: 3000,
      backgroundColor: ThemeConstants.blueColor,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: Container(),
    );
  }
}
