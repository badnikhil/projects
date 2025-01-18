// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/signin_page.dart';
bool isLoading=false;
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If user is logged in, navigate to the HomePage.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const Homepage(); // Your custom HomePage
          } else {
            return const SignInPage(); // Sign-in page for new users or logged-out users
          }
        },
      ),

    );
  }
}



