import 'package:flutter/material.dart';

Widget loginButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20), 
    child: Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15), 
        ),
        child: const Text(
          'LOG IN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );
}
