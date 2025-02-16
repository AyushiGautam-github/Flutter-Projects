import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gff/accepted_request.dart';
import 'package:gff/landing_page.dart';
import 'package:gff/login.dart';
import 'package:gff/place_request.dart';
import 'package:gff/profile.dart';
import 'package:gff/service_request.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are initialized.
  await Firebase.initializeApp();
  runApp(const GFF());
}

class GFF extends StatelessWidget {
  const GFF({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthCheck(),
      routes: {
        'signup': (context) => Signup(),
        'login': (context) => Login(),
        'place_request': (context) => PlaceRequestPage(),
        'accepted_request': (context) => AcceptedRequestPage(),
        'service_request': (context) => ServiceRequestPage(),
        'landing_page': (context) => LandingPage(),
        'profile': (context) => ProfilePage(),
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return LandingPage();
    } else {
      return Signup();
    }
  }
}
