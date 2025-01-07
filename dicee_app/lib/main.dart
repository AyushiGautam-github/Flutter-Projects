import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Dicee'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: DicePage(),
    ),
  ));
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rytDiceNumber = 1;
  void change(){
    setState(() {
      leftDiceNumber = Random().nextInt(6)+1;
      rytDiceNumber=Random().nextInt(6)+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            //flex: 2, twice the width of other
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                child: Image.asset('images/dice$leftDiceNumber.png'),
                onPressed: () {
                  change();
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                child: Image.asset('images/dice$rytDiceNumber.png'),
                onPressed: () {
                  change();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
