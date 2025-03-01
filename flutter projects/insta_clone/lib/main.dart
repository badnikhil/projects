import 'package:flutter/material.dart';
import 'package:insta_clone/pages/homepage.dart';
import 'package:insta_clone/pages/sign_in_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(themeMode: ThemeMode.system,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
      home: const Homepage());
  }
}

