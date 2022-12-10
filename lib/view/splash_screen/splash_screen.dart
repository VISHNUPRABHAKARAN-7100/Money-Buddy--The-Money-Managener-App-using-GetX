import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomeScreen(),
      duration: 4000,
      imageSize: 310,
      imageSrc: "assets\\money-buddy-logo.png",
      backgroundColor: Colors.white,
    );
  }
}
