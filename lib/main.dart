import 'package:first_app/screens/home_page.dart';
import 'package:first_app/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // String name = "Raghuram";
    //double, bool, num, var, let, const, final

    return MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // initialRoute: "/home",
      routes: {
        // '/' is home
        "/": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage()
      },
    );
  }
}
