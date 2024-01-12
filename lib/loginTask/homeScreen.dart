import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/loginTask/loginScreen.dart';
import 'package:todo_test/loginTask/splashScreen.dart';
import 'package:todo_test/screens/Home_screen.dart';

class HomeScreendummy extends StatefulWidget {
  HomeScreendummy({super.key});

  @override
  State<HomeScreendummy> createState() => _HomeScreendummyState();
}

class _HomeScreendummyState extends State<HomeScreendummy> {
  var username;
  var email;
  var password;
  @override
  void initState() {
    super.initState();
    prefvalueGetter();
  }

  prefvalueGetter() async {
    var prefs = await SharedPreferences.getInstance();
    var getusername = prefs.getString(ComponentClass.username_pref);
    var getemail = prefs.getString(ComponentClass.email_pref);
    var getpassword = prefs.getString(ComponentClass.password_pref);

    username = getusername!;
    email = getemail!;
    password = getpassword!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: uicolors.appblue,
        appBar: AppBar(
          backgroundColor: uicolors.appblue,
          elevation: 0,
          leading: IconButton(
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setBool(ComponentClass.Login_pref_key, false);
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SplashPage();
                  },
                ));
              },
              icon: Icon(Icons.logout_outlined)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome To NotesApp",
                style: TextStyle(
                  fontSize: 30,
                  color: uicolors.textfildlabel,
                ),
              ),
              SizedBox(height: 25),
              Text(
                '''
Name : ${username}\n
Email : $email\n
''',
                style: TextStyle(fontSize: 25, color: uicolors.textfildlabel),
              )
            ],
          ),
        ));
  }
}
