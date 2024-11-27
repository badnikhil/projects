import 'package:flutter/material.dart';
import 'package:Weather/weather_app_page.dart';

void main(){
  runApp(const MyApp());
   
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
        
      home: const WeatherScreen());
  }
 

  }
  