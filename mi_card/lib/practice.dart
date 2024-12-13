import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.brown,
            body: SafeArea(
              child: Column(
                //verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    //margin: EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 50.0),
                    padding: EdgeInsets.all(10.0),
                    child: Text('Container-1'),
                    color: Colors.white,
                  ),
                  SizedBox(height: 20.0,
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Container-2'),
                  ),
                  SizedBox(height: 20.0,
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.red,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Container-2'),
                  ),
                ],
              ),
            )));
  }
}
