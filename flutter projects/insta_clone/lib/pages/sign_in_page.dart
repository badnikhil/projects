import 'package:flutter/material.dart';
import 'package:insta_clone/utils/sign_in_utils/buttons/buttons.dart';
import 'package:insta_clone/utils/sign_in_utils/buttons/create_account.dart';
import 'package:insta_clone/utils/sign_in_utils/logo.dart';
import 'package:insta_clone/utils/sign_in_utils/pass_field.dart';
import 'package:insta_clone/utils/sign_in_utils/pass_forget.dart';
import 'package:insta_clone/utils/sign_in_utils/user_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool toHide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/5,),
            Center(child: logo()),
            SizedBox(height: MediaQuery.of(context).size.height/8),
            const UserField(),
            const SizedBox(height: 15),
            PassField(),
            const SizedBox(height: 15),
            loginButton(context),
            passforget(),
            const Spacer(),
            createAccountButton(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Made by NIKHIL'),
            )
            
          ],
        ),
      );
  }
}