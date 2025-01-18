// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:recipe_app/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<User?> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-in cancelled by user.")),
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      setState(() {
        _isLoading = false;
      });

      return userCredential.user;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during sign-in: $e")),
      );

      return null;
    }
  }

  Future<User?> _signInWithEmailPassword(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      setState(() {
        _isLoading = false;
      });

      return userCredential.user;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during email sign-in: $e")),
      );

      return null;
    }
  }

  Future<void> _registerWithEmailPassword(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during registration: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              User? user = await _signInWithEmailPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                          
                              if (user != null) {
                                print('Signed in as ${user.email}');
                                if (mounted) {
                                  Navigator.pushReplacement(
                                    
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Homepage(),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Sign In'),
                          ),
                          const SizedBox(width: 20,),
                          ElevatedButton(
                        onPressed: () async {
                          await _registerWithEmailPassword(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        },
                        child: const Text('Register '),
                      ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          User? user = await _signInWithGoogle();
                          if (user != null) {
                            print('Signed in as ${user.displayName}');
                            if (mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Homepage(),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Sign In with Google'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

