import 'package:flutter/material.dart';

class topcards extends StatelessWidget {
  String tx;
  IconData iconn;
  topcards({required this.iconn, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconn, size: 80.0, color: Colors.white,),
        SizedBox( height: 15.0,),
        Text(tx, style: TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98)),)
      ],
    );
  }
}