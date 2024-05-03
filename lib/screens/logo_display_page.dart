import 'dart:async';

import 'package:final_tutrorial/color.dart';
// import 'package:final_tutrorial/components/bottomNavBar.dart';
// import 'package:final_tutrorial/screens/home_page.dart';
import 'package:final_tutrorial/screens/origin_page.dart';
import 'package:final_tutrorial/screens/signup_page.dart';
// import 'package:final_tutrorial/screens/onboarding_screen.dart';
// import 'package:final_tutrorial/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logoDisplay extends StatefulWidget {
  const logoDisplay({super.key});

  @override
  State<logoDisplay> createState() => _logoDisplayState();
}

// final AuthService _authService = AuthService(AuthRepositoryImplementation());

class _logoDisplayState extends State<logoDisplay> {
//   String usernameController = 'mor_2314';
//   String passwordController = '83r5^_';

  @override
  void initState() {
    super.initState();
    navToOnboard();
  }

  void moveToSignup() async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpPage()));
    });
  }

  navToOnboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    var password = preferences.getString('password');

    if (username == null && password == null) {
      moveToSignup();
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OriginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), navToOnboard);

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blue,
            blue2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Image.asset('images/logo.png'),
      ),
    ));
  }
}
