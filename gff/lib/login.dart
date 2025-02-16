import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _auth=FirebaseAuth.instance;
  bool showspinner=false;
  String email='';
  String pass='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Grabie Friend Forever...", style: TextStyle(color: Colors.white),)),
        backgroundColor: Color(0xFFBF592B),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SafeArea(
          child: SingleChildScrollView(  // Wrap the content with SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0.0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image(
                    image: AssetImage('lib/images/logo.png'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Sign in to Continue",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // First Container (the one with the form fields)
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFBF592B),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Email',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18.0),
                              ),
                            ),
                            TextField(
                              onChanged: (value){
                                email=value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "type email here...",
                                hintStyle: TextStyle(color: Color(0xFFBF592B).withOpacity(0.5), fontSize: 15.0),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Password',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18.0),
                              ),
                            ),
                            TextField(
                              onChanged: (value){
                                pass=value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "type password here...",
                                hintStyle: TextStyle(color: Color(0xFFBF592B).withOpacity(0.5), fontSize: 15.0),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),

                      // Second Container (the button) with overlap
                      Positioned(
                        bottom: -30, // Adjusted value for overlap
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              setState(() {
                                showspinner=true;
                              });
                              try{
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: pass);
                                if (user != null) {
                                  Navigator.pushNamed(context, 'landing_page');
                                }
                                setState(() {
                                  showspinner=false;
                                });
                              } catch(e){print(e);}
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Color(0xFFFE854F),
                              padding: EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 50),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                      child: Text(
                        "Go back to Sign Up!",
                        style: TextStyle(
                          color: Color(0xFFBF592B),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

