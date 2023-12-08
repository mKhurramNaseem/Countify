import 'dart:async';

import 'package:countify/signing/views/login_screen.dart';
import 'package:countify/signing/widgets/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const name = '/splash';
  static const heroTag = 'logo';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  static const widthPercent = 0.7;
  static const heightPercent = 0.5;
  static const companyName = 'All In One';
  static const delayDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    Timer(delayDuration, () {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(tag: SplashScreen.heroTag,child: Logo(width: width * widthPercent,height: height * heightPercent,),),
              Text(
                companyName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: (width + height) / 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
