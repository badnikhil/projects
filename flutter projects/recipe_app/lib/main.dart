import 'package:flutter/material.dart';
import 'package:recipe_app/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(246, 252, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(246, 252, 255, 255),
        ),
      ),
      home: const Homepage(),

    );
  }
}
