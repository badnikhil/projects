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
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/signin_bg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  
                  Column(
                    children: [
                       Text(
                        'RECIPE APP',
                        style: TextStyle(color: Colors.grey[50],
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/signinpage_logo.jpg',
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50), 

                  TextField(cursorColor: Colors.black26,
                    controller: _emailController,
                    decoration: const InputDecoration(fillColor: Color.fromARGB(224,239,245,255),filled: true,
                      hintText: 'Email',contentPadding: EdgeInsets.only(left: 25,right: 10),suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.email_outlined,),
                      ),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),borderSide: BorderSide(
                        color: Colors.transparent
                      ))
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(cursorColor: Colors.black26,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.lock_outline),
                    ),contentPadding: EdgeInsets.only(left: 25),
                      hintText: 'Password',fillColor:Color.fromARGB(224,239,245,255),filled: true,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)),borderSide: BorderSide(
                        color: Colors.transparent
                      )),
                      

                    ),
                  ),
                  const SizedBox(height: 20),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
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
                        child: Text('Sign In',style: TextStyle(color: Colors.grey[100]),),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                        onPressed: () async {
                          await _registerWithEmailPassword(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        },
                        child:  Text('Register',style: TextStyle(color: Colors.grey[100]),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(children: [Expanded(child: Divider(indent: 0,)),Padding(padding: EdgeInsets.all(5),child: Text('OR',style: TextStyle(fontSize: 20,color: Colors.white),),),Expanded(child: Divider())]),
                  const SizedBox(height: 20),
     
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
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
                    child:  Text('Sign In with Google',style: TextStyle(color: Colors.grey[100]),),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
      
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
