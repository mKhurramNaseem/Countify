import 'package:countify/chats/views/chats_detail_screen.dart';
import 'package:countify/chats/views/chats_master_screen.dart';
import 'package:countify/signing/views/home_screen.dart';
import 'package:countify/signing/views/registration_screen.dart';
import 'package:countify/signing/views/login_screen.dart';
import 'package:countify/signing/views/splash_screen.dart';
import 'package:countify/util/error/error_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    SplashScreen.name => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    LoginScreen.name => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    RegistrationScreen.name => MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    HomeScreen.name => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        settings: settings,
      ),
    ChatsMasterScreen.name => MaterialPageRoute(
        builder: (context) => const ChatsMasterScreen(),
        settings: settings,
      ),
    ChatsDetailScreen.name => MaterialPageRoute(
        builder: (context) => const ChatsDetailScreen(),
        settings: settings,
      ),
    _ => MaterialPageRoute(
        builder: (context) => const ErrorScreen(),
      ),
  };
}
