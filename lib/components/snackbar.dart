import 'package:flutter/material.dart';

showSnackBar(String message) {
  SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 4),
    elevation: 5,
    backgroundColor: Color.fromRGBO(65, 54, 241, 1),
  );
}
