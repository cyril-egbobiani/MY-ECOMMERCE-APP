
// import 'package:final_tutrorial/button.dart';
import 'package:final_tutrorial/screens/signup_page.dart';
import 'package:flutter/material.dart';

class onboardingScreen extends StatelessWidget {
  const onboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Skip',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Campton-LightDEMO 2',
                  color: Color.fromRGBO(
                    79,
                    79,
                    79,
                    1,
                  ),
                )),
          ],
        )),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 390,
                child: Text(
                  'Get your money value',
                  style: TextStyle(
                    fontSize: 56.73,
                    height: 1.1,
                    fontFamily: 'CabinetGrotesk-Bold',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 350,
                child: Text(
                  'Officia occaecat ipsum ullamco commodo dolore. Amet duis officia tempor id ex quis. Nostrud amet do velit laborum. Amet duis officia tempor id ex quis',
                  style: TextStyle(
                      fontFamily: 'CabinetGrotesk-Light',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color.fromRGBO(79, 79, 79, 1)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Image.asset('images/rafiki.png'),
              ),
              const SizedBox(
                height: 100,
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          style: TextButton.styleFrom(
                            minimumSize: const Size(335, 71),
                            padding: const EdgeInsets.all(15),
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          child: const Text(
                            'Explore Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]))),
            ],
          ),
        ));
  }
}
