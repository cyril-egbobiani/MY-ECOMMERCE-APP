import 'package:final_tutrorial/color.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String role = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: AssetImage('images/lady.jpg'),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Sarah Patricia Evans',
                    style: TextStyle(fontFamily: 'CabinetGrotesk-Bold'),
                  ),
                ]),
                Icon(Icons.edit)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfo {}
