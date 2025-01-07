import 'package:flutter/material.dart';
import 'question.dart';
import 'quizbrain.dart';

QuizBrain quizbrain=QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scorekeeper=[
  ];

  List<String> ques=[
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];





  int quesno=0;

  void check(bool userans){
    if(userans==quizbrain.getanstext(quesno)) {
      scorekeeper.add(
          Icon(Icons.check,
            color: Colors.green,)
      );

    }
    else {
      scorekeeper.add(
          Icon(Icons.close,
            color: Colors.red,)
      );
    }
  }

  void end() {
    int score= scorekeeper.where((Icon)=> Icon.color==Colors.green).length;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Complete!'),
          content: Text('Reached the end of the quiz.'
              '\n Your Score is: $score/${quizbrain.quesbank.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  quesno = 0;
                  scorekeeper.clear();
                });
              },
              child: Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //quizbrain.quesbank[quesno].ques,
                quizbrain.getquestext(quesno),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.green,
              child: TextButton(
                onPressed: () {
                  //the user picked true
                  bool userans=true;
                  setState(() {
                    check(userans);
                    if(quesno<quizbrain.quesbank.length-1){
                      quesno++;}
                    else {end();}
                  });

                },
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.red,
              child: TextButton(
                onPressed: () {
                  //the user picked false
                  bool userans=false;
                  setState(() {
                    check(userans);
                    if(quesno<quizbrain.quesbank.length-1){
                      quesno++;}
                    else {end();}
                  });
                },
                child: Text(
                  'False',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ),


        //TODO: add a row for score keeper

        Row(
          children: scorekeeper,
        )


      ],
    );
  }
}



/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/