// import 'dart:html';

// import 'package:final_tutrorial/color.dart';
// import 'package:final_tutrorial/screens/cart_section_page.dart';
// import 'package:final_tutrorial/screens/description_page.dart';
// import 'package:final_tutrorial/screens/home_page.dart';
// import 'package:final_tutrorial/screens/profile_page.dart';
// import 'package:final_tutrorial/services/product_service/models/product_model.dart';
// import 'package:final_tutrorial/services/product_service/models/product_model.dart';
// import 'package:final_tutrorial/color.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BNavBar extends StatelessWidget {
  void Function(int)? onTabChange;

  BNavBar({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), color: Colors.red,
        gradient: const  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:  [
              Color.fromRGBO(65, 54, 241, 1),
              Color.fromRGBO(0, 204, 255, 1),
            ]),

        // gradient: LinearGradient()
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.white,
        activeColor: Color.fromRGBO(65, 54, 241, 1),
        tabBackgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 100,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
          ),
          GButton(
            icon: Icons.person_2_outlined,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
