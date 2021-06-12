import 'package:flutter/material.dart';
import 'package:training_application/state/inherited_application_state.dart';
import 'screens/splash_screen.dart';
import 'package:training_application/screens/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Training App',
      home: SplashScreen(),
    );
  }
}
