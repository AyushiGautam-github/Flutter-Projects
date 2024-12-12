import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              'I Am Rich',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Center(child: Image(
            image: NetworkImage(
                'https://gratisography.com/wp-content/uploads/2024/03/gratisography-funflower-800x525.jpg')),
        ),
      ),
    ),
  );
}
