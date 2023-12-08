import 'package:countify/firebase_options.dart';
import 'package:countify/signing/views/splash_screen.dart';
import 'package:countify/util/navigation/route_generation.dart';
import 'package:countify/util/theme/color_theme.dart';
import 'package:countify/util/theme/elevated_button_theme.dart';
import 'package:countify/util/theme/text_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// 1:500718134517:android:bf90cda4b119b190f5d1bc  // App Id On Firebase

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = "Countify";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorScheme.primary,
          primary: AppColorScheme.primary,
          secondary: AppColorScheme.secondary,
          tertiary: AppColorScheme.tertiary,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: AppTextTheme.bodyLarge(),
          bodyMedium: AppTextTheme.bodyMedium(),
          bodySmall: AppTextTheme.bodySmall(),
          labelSmall: AppTextTheme.labelSmall(),
        ),
        elevatedButtonTheme: AppButtonTheme.getTheme(),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen.name,
    );
  }
}