// import 'package:final_tutrorial/button.dart';
import 'dart:async';

import 'package:dio/dio.dart';
// import 'package:final_tutrorial/components/bottomNavBar.dart';
import 'package:final_tutrorial/screens/origin_page.dart';
import 'package:final_tutrorial/screens/signup_page.dart';
import 'package:final_tutrorial/services/auth_service/auth_repo_impl.dart';
import 'package:final_tutrorial/services/auth_service/usecase.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController TextUsernameController;
// circulat loader

  bool _isLoading = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    // Simulating a time-consuming task
    Future.delayed(const Duration(seconds: 3), () {
      _stopLoading();
    });
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });

    login();
  }

  final AuthService _authService = AuthService(AuthRepositoryImplementation());

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// code for token
// * we will save the user id in the shared prefernce
// *then later pass the user id as a parameter
// *in order to fully gain access to the specic user id and cart details

  storeToken(Map<String, dynamic> data) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);
    print("Decoded token is ${decodedToken['sub']}");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', decodedToken['sub'].toString());
  }

  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    Response res = await _authService.login(
        usernameController.text, passwordController.text);
    if (res.statusCode == 200) {
      await prefs.setString('username', usernameController.text);
      print("login username ${prefs.getString('username')}");
      await prefs.setString('password', passwordController.text);
      print("login password ${prefs.getString('password')}");
      _SnackbarCorrect();

      // debugPrint('userame is'+ " "+ prefs.getString(key));
      debugPrint('passwordd is' + " " + passwordController.text);
    } else {
      const CircularProgressIndicator();
      _SnackbarFailed();
    }
    debugPrint("login response is ${res.data}");
    storeToken(res.data);
  }

  void _SnackbarCorrect() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Login Successful',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        elevation: 2,
        backgroundColor: Color.fromRGBO(65, 54, 241, 1),
      ),
    );

// if login is correct and the snackbarCoorect is done displaying
    moveToHome();
  }

  void _SnackbarFailed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Login failed',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        elevation: 2,
        backgroundColor: Color.fromRGBO(65, 54, 241, 1),
      ),
    );
  }

// as soon as login button is tapped validation occurs
  validateInputs() async {
    if (usernameController.text.isEmpty) {
      setState(() {
        usernameErrorText = "Please enter a value";
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        passwordErrorText = "Please enter your password oo";
      });
    } else {
      _startLoading();
    }
  }

  void moveToHome() async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OriginPage()));
    });
  }

  String? usernameErrorText;
  String? passwordErrorText;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: (Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Campton-BoldDEMO 2'),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Campton-BoldDEMO 2'),
                  )),
            ],
          )),
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 390,
                  child: Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 56.73,
                      height: 1.1,
                      fontFamily: 'CabinetGrotesk-Bold',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      //
                      onChanged: (val) {
                        usernameErrorText = null;
                        setState(() {});
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please enter your username";
                        }
                        return val;
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Campton-LightDEMO 2'),
                      decoration: InputDecoration(
                          errorText: usernameErrorText,
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your account username',
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      onChanged: (val) {
                        passwordErrorText = null;
                        setState(() {});
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Please enter your password";
                        }
                        return val;
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Campton-LightDEMO 2'),
                      decoration: InputDecoration(
                        errorText: passwordErrorText,
                        border: const OutlineInputBorder(),
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgotten Passoword?'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Reset',
                      style: TextStyle(color: Color.fromRGBO(0, 204, 255, 1)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(children: <Widget>[
                              Positioned.fill(
                                  child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(0, 204, 255, 1),
                                    Color.fromRGBO(65, 54, 241, 1),
                                  ]),
                                ),
                              )),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(335, 71),
                                    padding: const EdgeInsets.all(15),
                                    textStyle: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    await validateInputs();
                                  }),
                            ]))),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("i don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          'Create',
                          style:
                              TextStyle(color: Color.fromRGBO(0, 204, 255, 1)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
