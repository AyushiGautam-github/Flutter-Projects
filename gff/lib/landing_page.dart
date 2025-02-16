import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? loggedinuser;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        loggedinuser = user;
        userEmail = user.email ?? ''; // Store user's email for querying profile
      });
      fetchUserProfile(); // Fetch profile from Firestore
    }
  }

  // Fetch the user profile from the "profile" collection
  void fetchUserProfile() async {
    if (loggedinuser != null && loggedinuser!.email != null) {
      final userDoc = await firestore
          .collection('profile')
          .where('email', isEqualTo: loggedinuser!.email)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        setState(() {
          userName = userDoc.docs.first['name'] ?? 'No Name';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grabie Friend Forever...", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFBF592B),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFBF592B),
              ),
              accountName: Text(
                userName.isEmpty ? 'User Name' : userName,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(userEmail.isEmpty ? 'user@example.com' : userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userName.isNotEmpty ? userName[0] : 'U',
                  style: TextStyle(fontSize: 24, color: Color(0xFFBF592B)),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFFBF592B)),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFFBF592B)),
              title: Text('Logout'),
              onTap: () {
                _auth.signOut();
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('lib/images/logo.png'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  "What would you like to do?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'place_request');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Color(0xFFFE854F),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Place a Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'service_request');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Color(0xFFFE854F),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Service a Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'accepted_request');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Color(0xFFFE854F),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Accepted Requests",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
