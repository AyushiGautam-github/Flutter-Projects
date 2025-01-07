import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusablecard.dart';
import 'topcards.dart';
import 'result_page.dart';
import 'brain.dart';

enum Gender { male, female }

const bottomContHeight = 80.0;
const activeCardCol = Color(0xFF1D1E33);
const inactivecardcol = Color(0xFF0A0E21);

class inputpage extends StatefulWidget {
  const inputpage({super.key});

  @override
  State<inputpage> createState() => _inputpageState();
}

class _inputpageState extends State<inputpage> {
  int height = 180;
  int weight = 60;
  int age = 20;

  Color malecardcol = inactivecardcol;
  Color femalecardcol = inactivecardcol;

  void updatecol(Gender gender) {
    if (gender == Gender.male) {
      malecardcol =
          (malecardcol == inactivecardcol) ? activeCardCol : inactivecardcol;
      femalecardcol =
          (malecardcol == activeCardCol) ? inactivecardcol : femalecardcol;
    } else if (gender == Gender.female) {
      femalecardcol =
          (femalecardcol == inactivecardcol) ? activeCardCol : inactivecardcol;
      malecardcol =
          (femalecardcol == activeCardCol) ? inactivecardcol : malecardcol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
                      'BMI CALCULATOR',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
          backgroundColor: Color(0xFF0A0E21),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updatecol(Gender.male);
                    });
                  },
                  child: resusablecard(
                    colour: malecardcol,
                    cardchild:
                        topcards(iconn: FontAwesomeIcons.mars, tx: 'MALE'),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updatecol(Gender.female);
                    });
                  },
                  child: resusablecard(
                    colour: femalecardcol,
                    cardchild:
                        topcards(iconn: FontAwesomeIcons.venus, tx: 'FEMALE'),
                  ),
                ))
              ],
            )),
            Expanded(
              child: resusablecard(
                colour: activeCardCol,
                cardchild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Height', style: TextStyle(color: Color(0xFF8D8E98))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        Text('cm', style: TextStyle(color: Color(0xFF8D8E98)))
                      ],
                    ),
                    Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        activeColor: Color(0xFFEB1555),
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double newval) {
                          setState(() {
                            height = newval.toInt();
                          });
                        })
                  ],
                ),
              ),
              flex: 1,
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: resusablecard(
                  colour: activeCardCol,
                  cardchild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(color: Color(0xFF8D8E98)),
                      ),
                      Text(
                        weight.toString(),
                        style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconbtn(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconbtn(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                          ])
                    ],
                  ),
                )),
                Expanded(
                    child: resusablecard(
                  colour: activeCardCol,
                  cardchild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(color: Color(0xFF8D8E98)),
                      ),
                      Text(
                        age.toString(),
                        style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconbtn(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconbtn(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ])
                    ],
                  ),
                ))
              ],
            )),
            GestureDetector(
              onTap: (){

                Brain calc= Brain(height: height, weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultPage(
                    bmiresult: calc.calculatebmi(),
                    resulttext: calc.getresult(),
                    interpret: calc.getinterpretation(),
                  )),
                );
              },
              child: Container(
                child: Center(child: Text('Calculate', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.w700),)),
                color: Color(0xFFEB1555),
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: bottomContHeight,
              ),
            )
          ],
        ));
  }
}

class RoundIconbtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  RoundIconbtn({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      elevation: 6.0,
      disabledElevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      onPressed: onPressed,
    );
  }
}
