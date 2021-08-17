import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite/CovidHome.dart';
import 'package:infinite/bmi_result_screen.dart';
import 'package:infinite/bmi_screen.dart';
import 'package:infinite/cubit/bloc_observer.dart';
import 'package:infinite/home_screen.dart';
import 'package:infinite/layout/home_layout.dart';
import 'package:infinite/layout/news_app/news_layout.dart';
import 'package:infinite/login_screen.dart';
import 'package:infinite/messenger_screen.dart';
import 'package:infinite/network/remote/dio_helper.dart';
import 'package:infinite/users_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: HexColor('333739'),
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: HexColor('333739'),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey,
          elevation: 20.0,
          backgroundColor: HexColor('333739'),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

      ),
      themeMode: ThemeMode.light,

      home: NewsLayout(),
    );
  }
}
