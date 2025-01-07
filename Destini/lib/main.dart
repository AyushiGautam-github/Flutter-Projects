import 'package:flutter/material.dart';
import 'storybrain.dart';
Storybrain sb=Storybrain();

void main() {
  runApp(destini());
}

class destini extends StatelessWidget {
  const destini({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/fb/ef/2a/fbef2a406a75c37b931255c5b4e1b571.jpg'),
            fit: BoxFit.cover)
          ),
            child: storypage())
        ),
      ),
    );
  }
}

class storypage extends StatefulWidget {
  const storypage({super.key});

  @override
  State<storypage> createState() => _storypageState();
}

class _storypageState extends State<storypage> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex:4, child:
        Center(
          child: Padding(padding: EdgeInsets.all(20.0),
            child: Text(sb.getstory(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),),
          ),
        ),),
        Expanded(child:
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            color: Colors.white70,
            child: TextButton(onPressed: (){
              setState(() {
                sb.nextstory(1);
              });
            },
                child: Text(sb.getchoice1())),
              ),
        )
        ),
        //SizedBox( height: 10.0,),
        Expanded(child:
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Visibility(
            visible: sb.buttonShouldBeVisible(),
            child: Container(
              color: Colors.white70,
              child: TextButton(onPressed: (){
                setState(() {
                  sb.nextstory(2);
                });
              },
                  child: Text(sb.getchoice2())),
            ),
          ),
        )
        ),
      ],
    );
  }
}

