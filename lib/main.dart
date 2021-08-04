import 'package:flutter/material.dart';
import 'package:infinite/CovidHome.dart';
import 'package:infinite/bmi_result_screen.dart';
import 'package:infinite/bmi_screen.dart';
import 'package:infinite/home_screen.dart';
import 'package:infinite/layout/home_layout.dart';
import 'package:infinite/login_screen.dart';
import 'package:infinite/messenger_screen.dart';
import 'package:infinite/users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
