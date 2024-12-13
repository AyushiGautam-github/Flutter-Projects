import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.red,
                  width: 100.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.yellow,
                        width: 100.0,
                        height: 100.0,
                      ),
                      Container(
                        color: Colors.green,
                        width: 100.0,
                        height: 100.0,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue,
                  width: 100.0,
                )
              ],
            )),
      ),
    );
  }
}

