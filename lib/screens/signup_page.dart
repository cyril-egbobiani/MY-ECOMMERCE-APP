// import 'package:final_tutrorial/button.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:final_tutrorial/screens/login_page.dart';
import 'package:final_tutrorial/services/auth_service/auth_repo_impl.dart';
import 'package:final_tutrorial/services/auth_service/usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService(AuthRepositoryImplementation());

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future register() async {
   
   final prefs = await SharedPreferences.getInstance();
 
    Response res = await _authService.register(
        emailController.text, usernameController.text, passwordController.text);
    if (res.statusCode == 200) {
      
      await prefs.setString('username', usernameController.text.trim());
      await prefs.setString('password', passwordController.text.trim());
      
      _SnackbarCorrect();
      debugPrint('Sign-Up Successful');
    } else {
      _SnackbarFailed();
      debugPrint('Sign-Up failed');
    }
  }

  void _SnackbarCorrect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Sign-Up Successful',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        elevation: 2,
        backgroundColor: Color.fromRGBO(65, 54, 241, 1),
      ),
    );
  }

  void _SnackbarFailed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign-Up failed', style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
        elevation: 2,
        backgroundColor: Color.fromRGBO(65, 54, 241, 1),
      ),
    );
  }

  String? emailErrorText;
  String? usernameErrorText;
  String? passwordErrorText;

  final formKey = GlobalKey<FormState>();

  validateInputs() {
    if (emailController.text.isEmpty) {
      setState(() {
        emailErrorText = "Please enter youe email";
      });
    } else if (usernameController.text.isEmpty) {
      setState(() {
        usernameErrorText = "Please enter your username";
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        passwordErrorText = "Please enter your password";
      });
    } else {
      return register();
    }
  }

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
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Campton-BoldDEMO 2',
                    ),
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
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Campton-BoldDEMO 2',
                    ),
                  )),
            ],
          )),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 390,
                    child: Text(
                      'Create a Free Account',
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
                  TextFormField(
                    key: formKey,
                    controller: emailController,
                    onChanged: (val) {
                      passwordErrorText = null;
                      setState(() {});
                    },
                    validator: (String? val) {
                      if (val!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(val)) {
                        return "Please enter your email";
                      }
                      return val;
                    },
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Campton-LightDEMO 2'),
                    decoration: InputDecoration(
                        errorText: emailErrorText,
                        border: const OutlineInputBorder(),
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: usernameController,
                    onChanged: (val) {
                      passwordErrorText = null;
                      setState(() {});
                    },
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Campton-LightDEMO 2'),
                    decoration: InputDecoration(
                      errorText: usernameErrorText,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your username',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
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
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Campton-LightDEMO 2'),
                    decoration: InputDecoration(
                      errorText: passwordErrorText,
                      border: const OutlineInputBorder(),
                      hintText: 'Create a Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: ClipRRect(
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
                              onPressed: () {
                                validateInputs();
                              },
                              style: TextButton.styleFrom(
                                minimumSize: const Size(335, 71),
                                padding: const EdgeInsets.all(15),
                                textStyle: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]))),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(color: Color.fromRGBO(0, 204, 255, 1)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'By creating an account you agree to our')
                                ],
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Terms and Services',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 204, 255, 1)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('and')
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 204, 255, 1)),
                                    )
                                  ]),
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ],
        ));
  }
}
