import 'package:do_an_movie/ui/main/main_ui.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoSize: 100,
      logo: Image.asset(
          'assets/logos/logo_Frame.png'),
      backgroundColor: const Color(0xFFDB5252),
      showLoader: false,
      navigator: const MainUi(),
      durationInSeconds: 5,
    );
  }
}

