import 'package:flutter/material.dart';

Widget createAccountButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
         // White background
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue, width: 2), // Blue border
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          foregroundColor: Colors.blue, // Text color blue
        ),
        child: const Text(
          'CREATE NEW ACCOUNT',
          style: TextStyle(
            color: Colors.blue, // Text color blue
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
