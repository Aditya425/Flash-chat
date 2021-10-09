import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_demo/screens/chat_screen.dart';
import 'package:flash_chat_demo/screens/login_screen.dart';
import 'package:flash_chat_demo/screens/registration_screen.dart';
import 'package:flash_chat_demo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  void initialize() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen()
      },
      theme: ThemeData().copyWith(
        appBarTheme: AppBarTheme(
          elevation: 5,
          backgroundColor: Colors.blue
        )
      ),
    );
  }
}
