import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController loginemailcontroller = TextEditingController();
  final TextEditingController loginpasswordcontroller = TextEditingController();
  final TextEditingController sitecontroller = TextEditingController();

  Future<void> login() async {
    String email = loginemailcontroller.text;
    String password = loginpasswordcontroller.text;
    String site = sitecontroller.text;

    if (email.isEmpty || password.isEmpty) {
      print('Email: $email, Password: $password');

      Get.snackbar(
        'Error',
        'Please enter both email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    var logindata = {
      'email': email,
      'password': password,
      'site': site,
    };

    String requestBody = json.encode(logindata);

    _setHeaders() => {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
    print('Request Body: $logindata');

    try {
      var response = await http.post(
        Uri.parse('https://www.homs.com.np/api/login'),
        body: requestBody,
        headers: _setHeaders(),
      );

      if (response.statusCode == 200) {
        var jsonString = response.body.substring(response.body.indexOf('{'));
        var responseData = json.decode(jsonString);

        print('login successful!');
        print(responseData);

        await saveLoginStatus(true);

        Get.to(
          () => Dashboard(),
        );
      } else {
        handleErrorResponse(response);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void handleErrorResponse(http.Response response) {
    if (response.statusCode == 404) {
      print('Error 404: Not Found');
    } else if (response.statusCode == 500) {
      print('Error 500: Internal Server Error');
    } else {
      print('Error ${response.statusCode}: ${response.body}');
    }
  }
}
