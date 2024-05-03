import 'package:final_tutrorial/screens/logo_display_page.dart';
import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  // shared perference function
  // void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var username = preferences.getString('username');
  //   var password = preferences.getString('password');

  //   runApp(MaterialApp(
  //       home: username == null && password == null
  //           ? validateInputs()
  //           : moveToHome()));
  // }

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const logoDisplay(),
    );
  }
}
