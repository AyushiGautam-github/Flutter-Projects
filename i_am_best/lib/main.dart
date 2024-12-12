import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Center(child: Text('I Am The Best', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Center(child: Image(image: NetworkImage('https://i.pinimg.com/236x/02/6a/cc/026acca08fb7beea6bd4ecd430e312bd.jpg'))),
    ),
  ),
  );
}


