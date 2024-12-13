import 'package:flutter/material.dart';
import 'package:mi_card/practice.dart';

void main() {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              foregroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS77ZH_7hleyEZcx7Wc6LhliNjp_a0l0WnO8A&s'),
              backgroundColor: Colors.red,
            ),
            Text('Ayushi Gautam',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico')),
            SizedBox(
              height: 10.0,
            ),
            Text('FLUTTER DEVELOPER',
                style: TextStyle(
                    fontSize: 20.0,
                    //fontWeight:FontWeight.bold,
                    fontFamily: 'Lato',
                    letterSpacing: 1.5)),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.green,
              ),
            ),
            Card(
              color: Colors.white54,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.call,
                  size: 20.0,
                  color: Colors.green,),
                title: Text('+91 7455053298',
                  style: TextStyle(fontFamily: 'Lato',
                      fontSize: 15.0),
                ),
              )
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.white54,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.mail,
                  size: 20.0,
                  color: Colors.green,),
                title: Text(' ag29.workspace@gmail.com',
                  style: TextStyle(fontFamily: 'Lato',
                      fontSize: 15.0),
                ),
              )
            )
          ],
        )),
      ),
    );
  }
}
