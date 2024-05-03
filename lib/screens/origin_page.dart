import 'package:final_tutrorial/components/bottomNavBar.dart';
import 'package:final_tutrorial/screens/cart_section_page.dart';
import 'package:final_tutrorial/screens/home_page.dart';
import 'package:final_tutrorial/screens/profile_page.dart';
import 'package:final_tutrorial/services/product_service/models/product_model.dart';
import 'package:flutter/material.dart';

class OriginPage extends StatefulWidget {
  const OriginPage({super.key});

  @override
  State<OriginPage> createState() => _OriginPageState();
}

class _OriginPageState extends State<OriginPage> {
 
  int _selectedIndex = 0;


  // this method will update our selected index
  // when the user taps on the bottom bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//pages to display
  final List<Widget> _pages = [
    // home page
    const HomePage(),

    // cart page
     CartSection(productCart: Product()),

    // profile page
    const ProfilePage(),

  ];
 
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: BNavBar(
            
        onTabChange: (index) => navigateBottomBar(index),
      ),
body: _pages[_selectedIndex],

    );

  }
}