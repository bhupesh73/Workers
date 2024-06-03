import 'package:flutter/material.dart';
import 'package:loginuicolors/addtask.dart';
import 'package:loginuicolors/dashboard.dart';
import 'package:loginuicolors/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login', 
    routes: {
      '/': (context) => Dashboard(), 
      'login': (context) => MyLogin(),
      'add_task': (context) => AddTask(), 
    },
  ));
}
