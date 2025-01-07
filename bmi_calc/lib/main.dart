import 'package:flutter/material.dart';
import 'inputpage.dart';


void main() {
  runApp(bmicalc());
}

class bmicalc extends StatelessWidget {
  const bmicalc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.white)
        )
      ),
      home: inputpage(),
    );
  }
}








