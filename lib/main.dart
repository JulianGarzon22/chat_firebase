import 'package:flutter/material.dart';

import 'package:chat_firebase/colors/mazarine_blue.dart';
import 'package:chat_firebase/colors/rise_n_shine.dart';

import 'package:chat_firebase/screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primaryColor: mazarineBlue,
        primaryColorBrightness: Brightness.dark,
        accentColor: riseNShine,
        accentColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}
