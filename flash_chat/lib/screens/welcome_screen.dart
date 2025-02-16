import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/btn.dart';


class WelcomeScreen extends StatefulWidget {
  static String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1
    );

    // animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    
    controller.forward();
    // animation.addStatusListener((status){
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1);
    //   } else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });

    animation=ColorTween(begin: Colors.yellow[50], end: Colors.white).animate(controller);
    controller.addListener((){
      setState(() {
      });
      //print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('lib/images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  onTap: (){},
                 text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            btn(col: Colors.lightBlueAccent, onpressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            } , text: 'Log in'),
            btn(col: Colors.blueAccent, onpressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }, text: 'Register')
          ],
        ),
      ),
    );
  }
}



