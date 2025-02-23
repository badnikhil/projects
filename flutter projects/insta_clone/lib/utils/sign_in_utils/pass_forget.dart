import 'package:flutter/material.dart';

Widget passforget(){
  return GestureDetector(
  onTap: () {
  
  },
  child: const Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      'Forgotten password?',
      style: TextStyle(
       
      
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
);
}