import 'package:first_app/home_page.dart';
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

    return MaterialApp(home: HomePage());
  }
}
