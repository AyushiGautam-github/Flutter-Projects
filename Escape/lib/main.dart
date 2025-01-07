import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Center(child: Text('Ask Me Anything!')),
        backgroundColor: Colors.blue,
      ),
      body: capepage(),
    ),
  ));
}


class capepage extends StatefulWidget {

  @override
  State<capepage> createState() => _capepageState();
}

class _capepageState extends State<capepage> {

  int ballno=1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          child: Image.asset('images/ball$ballno.png'),
      onPressed: (){
            setState(() {
              ballno=Random().nextInt(5)+1;
            });
    }
          ),
    );
  }
}


