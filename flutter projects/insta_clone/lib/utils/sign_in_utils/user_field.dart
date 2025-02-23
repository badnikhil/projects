import 'package:flutter/material.dart';

class UserField extends StatelessWidget {
  const UserField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
                        decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                          labelText: "Username or email address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.green), 
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 224, 223, 223),width: 1.5), 
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 175, 174, 174), width: 2.5), 
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.green, width: 2.0), 
                    ),
                  ),
                ),
    );
  }
}