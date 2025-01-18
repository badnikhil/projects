import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool loading=true;
  
  @override
  Widget build(BuildContext context) {
    return Container(height: 100,width: 100,
      child: ListView.builder(scrollDirection: Axis.vertical,
        itemCount: 10,padding: EdgeInsets.all(5),
        itemBuilder: (context,index,){
          
          
          return Text('heyy');
      
          
        }),
    );
  }
}