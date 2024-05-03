// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_tutrorial/services/auth_service/auth_repo_impl.dart';

class AuthService {
  final AuthRepositoryImplementation impl;
  AuthService(this.impl);

  Future<Response> login(String username, String password) async {
    return await impl.logIn(username, password);
  }

  Future register(String email, String username, String password ) async {
    return await impl.register( email, username,  password );
    // Response res = await impl.register(data);
    // int statusCode = res.statusCode ?? 000;
    // if (statusCode >= 200 && statusCode <= 300) {
    //   return res;
    // }
    // return res;
  }
}


// class AuthService {
//   final AuthRepositoryImplementation impl;

//   AuthService(this.impl);

//   Future login(String username, String password) async {
//     try {
//       // Delegating login operation to AuthRepositoryImplementation
//       Response? res = await impl.logIn(username, password); // Note the use of Response?

//       // Check if the response is not null before accessing its properties
//       if (res != null) {
//         // Checking status code of the response
//         int statusCode = res.statusCode ?? 000; // Default value if status code is null

//         // If status code indicates a successful request (between 200 and 300),
//         // return the response. Otherwise, return the response as is.
//         if (statusCode >= 200 && statusCode <= 300) {
//           return res;
//         }
//       }
//       // Handle the case where the response is null or status code is outside the range
//       // You might want to throw an exception, return an error message, or handle it differently based on your requirements.
//       // For now, let's return null.
//       return null;
//     } catch (e) {
//       print('Error during login: $e');
//       // Handle the error, e.g., show an error message to the user
//       // For now, let's return null.
//       return null;
//     }
//   }
// }
