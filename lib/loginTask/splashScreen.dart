import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/loginTask/loginScreen.dart';
import 'package:todo_test/screens/Home_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      bool? Checklogin = prefs.getBool(ComponentClass.Login_pref_key);

      Widget navigateTo = const LoginScreen();
      if (Checklogin != null && Checklogin) {
        navigateTo = const Home_Screen();
      }
      // if (Checklogin == null) {
      //   navigateTo = LoginScreen();
      // } else {
      //   if (Checklogin) {
      //     navigateTo = HomeScreen();
      //   } else {
      //     navigateTo = LoginScreen();
      //   }
      // }
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return navigateTo;
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uicolors.appblue.withAlpha(205),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Welcome TO',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: uicolors.textfildlabel),
          ),
          Text(
            'TO-DO APP',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: uicolors.textfildlabel),
          )
        ]),
      ),
    );
  }
}
