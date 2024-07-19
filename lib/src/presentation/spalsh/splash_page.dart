import 'dart:async';
import 'package:flutter/material.dart';
import 'package:module5/src/presentation/auth/auth_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  Splash createState() => Splash();
}


class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const AuthPage())));

    const assetsImage = AssetImage('assets/screens/Splash.png');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: assetsImage),
          ),
        ),
      ),
    );
  }
}
