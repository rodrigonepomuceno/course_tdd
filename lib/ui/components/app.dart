import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryAppColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryAppColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryAppColorLight = Color.fromRGBO(188, 71, 123, 1);
    return MaterialApp(
      title: 'ForDev Course TDD',
      theme: ThemeData(
        primaryColor: primaryAppColor,
        primaryColorDark: primaryAppColorDark,
        primaryColorLight: primaryAppColorLight,
        accentColor: primaryAppColor,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryAppColorDark),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryAppColorLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryAppColor),
          ),
          alignLabelWithHint: true,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryAppColor),
          buttonColor: primaryAppColor,
          splashColor: primaryAppColorLight,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
