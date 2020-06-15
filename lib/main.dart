import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_firebase/screens/auth_screen.dart';
import 'package:chat_firebase/screens/chat_screen.dart';

import 'package:chat_firebase/colors/mazarine_blue.dart';
import 'package:chat_firebase/colors/rise_n_shine.dart';

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }

          return AuthScreen();
        },
      ),
    );
  }
}
