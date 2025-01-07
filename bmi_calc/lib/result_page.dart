import 'package:bmi_calc/inputpage.dart';
import 'package:flutter/material.dart';
import 'reusablecard.dart';
import 'inputpage.dart';
class ResultPage extends StatelessWidget {

  int calc=0;
  final String bmiresult;
  final String resulttext;
  final String interpret;
  ResultPage({required this.interpret, required this.bmiresult, required this.resulttext});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR',style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: Color(0xFF0A0E21),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Expanded(
            child: Center(
              child: Container(
                  child: Text('Your Result',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize: 40.0),)),
            ),
          ),
            Expanded(
              flex: 8,
                child: resusablecard(colour: Color(0xFF1D1E33),
                cardchild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(resulttext.toUpperCase(), style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.w600),),
                    Text(bmiresult.toString(),style: TextStyle(
                        fontSize: 70.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
                    Text(interpret, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                  ],
                ) )
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputpage()),
                );
              },
              child: Container(
                child: Center(child: Text('Re-Calculate', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.w700),)),
                color: Color(0xFFEB1555),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: bottomContHeight,
              ),
            )
      ]),
    );
  }
}
