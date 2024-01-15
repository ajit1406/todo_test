import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/screens/Home_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class ComponentClass {
  static const String Login_pref_key = 'islogin';
  static const String username_pref = 'username';
  static const String email_pref = 'email';
  static const String password_pref = 'password';
}

class _LoginScreenState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uicolors.appblue.withAlpha(210),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register Now',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: uicolors.textfildlabel),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 330,
                child: TextField(
                    style: textfildtextstyle(),
                    controller: usernameController,
                    decoration: textfildDecoration('User Name'))),
            const SizedBox(height: 20),
            SizedBox(
                width: 330,
                child: TextField(
                    style: textfildtextstyle(),
                    controller: emailController,
                    decoration: textfildDecoration('Email Address'))),
            const SizedBox(height: 20),
            SizedBox(
                width: 330,
                child: TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: textfildtextstyle(),
                    controller: passwordController,
                    decoration: textfildDecoration('Password'))),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  var usernamevalue = usernameController.text.toString();
                  var emailvalue = emailController.text.toString();
                  var passwordvalue = passwordController.text.toString();
                  var prefs = await SharedPreferences.getInstance();

                  prefs.setString(ComponentClass.username_pref, usernamevalue);
                  prefs.setString(ComponentClass.email_pref, emailvalue);
                  prefs.setString(ComponentClass.password_pref, passwordvalue);

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   loginSuccesSnackbar());

                  if (usernameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    prefs.setBool(ComponentClass.Login_pref_key, true);
                    topsuccesscnackbar(context);

                    Timer(const Duration(milliseconds: 1500), () {
                      Navigator.pushReplacement(context, PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const Home_Screen();
                        },
                      ));
                    });
                  } else if (usernameController.text.isEmpty &&
                      emailController.text.isEmpty &&
                      passwordController.text.isEmpty) {
                    toperrorsnackbar(context,
                        messagetext: "Details is Required");
                  } else {
                    if (usernameController.text.isEmpty) {
                      toperrorsnackbar(context,
                          messagetext: "User Name is Required");
                    } else if (emailController.text.isEmpty) {
                      toperrorsnackbar(context,
                          messagetext: "Email is Required");
                    } else {
                      toperrorsnackbar(context,
                          messagetext: "Password is Required");
                    }
                  }

                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: uicolors.textfildlabel, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: uicolors.appblue,
                    foregroundColor: uicolors.textfildlabel),
                child: const Text(
                  'Login Now',
                  style: TextStyle(fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }

  void toperrorsnackbar(BuildContext context, {required String messagetext}) {
    return showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 1),
        CustomSnackBar.error(

            // backgroundColor: uicolors.appblue,
            textStyle: TextStyle(
                fontSize: 30,
                color: uicolors.textfildlabel,
                fontWeight: FontWeight.bold),
            message: messagetext));
  }

  void topsuccesscnackbar(BuildContext context) {
    return showTopSnackBar(
        displayDuration: const Duration(seconds: 0),
        Overlay.of(context),
        CustomSnackBar.success(
            backgroundColor: uicolors.appblue,
            textStyle: TextStyle(color: uicolors.textfildlabel, fontSize: 35),
            message: 'Login Successfully'));
  }

  SnackBar loginSuccesSnackbar() {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      content: Center(
        child: Text(
          'Login Successfully',
          style: TextStyle(color: uicolors.textfildlabel, fontSize: 25),
        ),
      ),
      backgroundColor: uicolors.appblue,
      // duration: Duration(milliseconds: 1500),
    );
  }

  TextStyle textfildtextstyle() =>
      TextStyle(color: uicolors.textfildlabel, fontSize: 20);

  InputDecoration textfildDecoration(String label) {
    return InputDecoration(
      fillColor: uicolors.appblue,
      filled: true,
      labelText: label,
      labelStyle:
          TextStyle(color: uicolors.textfildlabel, fontWeight: FontWeight.bold),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 1)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 1)),
    );
  }
}
