import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  String name = '';
  String contact = '';
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Grabie Friend Forever...",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFFBF592B),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
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
                    "Hey! Welcome",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
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
                          "Sign Up",
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
                            'Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Type your name...",
                            hintStyle: TextStyle(
                              color: Color(0xFFBF592B).withOpacity(0.5),
                              fontSize: 15.0,
                            ),
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
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Type your email...",
                            hintStyle: TextStyle(
                              color: Color(0xFFBF592B).withOpacity(0.5),
                              fontSize: 15.0,
                            ),
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
                            'Contact Number',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            contact = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Type your contact number...",
                            hintStyle: TextStyle(
                              color: Color(0xFFBF592B).withOpacity(0.5),
                              fontSize: 15.0,
                            ),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          onChanged: (value) {
                            pass = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Type your password...",
                            hintStyle: TextStyle(
                              color: Color(0xFFBF592B).withOpacity(0.5),
                              fontSize: 15.0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: pass,
                                );
                                if (newUser != null) {
                                  // Store user details in Firestore
                                  await firestore.collection('profile').add({
                                    'name': name,
                                    'contact': contact,
                                    'email': email,
                                  });
                                  Navigator.pushNamed(context, 'landing_page');
                                }
                              } catch (e) {
                                print(e);
                              } finally {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Color(0xFFFE854F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color: Color(0xFFFE854F),
                                  width: 4,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: Text(
                              "Already have an account? Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
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
