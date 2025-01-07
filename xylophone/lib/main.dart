import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {

  void playSound(int play){
    final player = AudioPlayer();
    player.play(AssetSource('note$play.wav'));
  }


  Container buildkey({required Color color, required int sno}){
    return Container(
      color: color,
      height: 100.0,
      child: TextButton(
          onPressed: () {
            playSound(sno);
          },
          child: Text('')
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildkey(color:Colors.blue, sno:1 ),
                buildkey(color:Colors.red, sno:2),
                buildkey(color:Colors.lightGreen, sno:3),
                buildkey(color:Colors.orange, sno:4),
                buildkey(color:Colors.yellow, sno:5),
                buildkey(color:Colors.purple, sno:6),
                buildkey(color:Colors.pink, sno:7),
              ],
            )),
      ),
    );
  }
}

