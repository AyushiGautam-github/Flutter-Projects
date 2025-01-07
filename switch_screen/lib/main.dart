import 'package:flutter/material.dart';
import 'Screen0.dart';
import 'Screen2.dart';
import 'Screen1.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes:{
        'home': (context)=> Screen0(),
        'first': (context)=> Screen1(),
        'second':(context)=> Screen2()
      } ,
    );
  }
}



