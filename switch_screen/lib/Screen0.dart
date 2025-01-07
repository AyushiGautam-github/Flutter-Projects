import 'package:flutter/material.dart';
import 'Screen1.dart';
import 'Screen2.dart';

class Screen0 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[ ElevatedButton(
            child: Text('Open route-1'),
            onPressed: () {
              Navigator.pushNamed(context, 'first');
            },
          ),
            ElevatedButton(
              child: Text('Open route-2'),
              onPressed: () {
                Navigator.pushNamed(context, 'second');
              },
            ),
        ]),
      ),
    );
  }
}