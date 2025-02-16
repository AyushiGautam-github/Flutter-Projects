import 'package:flutter/material.dart';


class btn extends StatelessWidget {
  String text='';
  Color col;
  VoidCallback onpressed;
  btn({required this.col, required this.onpressed, required this.text});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: col,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white ),
          ),
        ),
      ),
    );
  }
}