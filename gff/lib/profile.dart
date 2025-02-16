import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
User? loggedinuser;
final _auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String contactNumber = '';
  String? documentId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
        fetchUserData(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchUserData(String? userEmail) async {
    if (userEmail != null) {
      final snapshot = await firestore
          .collection('profile')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userDoc = snapshot.docs.first;
        setState(() {
          name = userDoc['name'] ?? '';
          contactNumber = userDoc['contact'] ?? '';
          documentId = userDoc.id; // Save document ID for updates
        });
      }
    }
  }

  Future<void> updateOrCreateProfile() async {
    if (loggedinuser == null) return;
    final userEmail = loggedinuser!.email;

    if (documentId != null) {
      // Update existing document
      await firestore.collection('profile').doc(documentId).update({
        'name': name,
        'contact': contactNumber,
        'email': userEmail,
      });
    } else {
      // Create new document
      final newDoc = await firestore.collection('profile').add({
        'name': name,
        'contact': contactNumber,
        'email': userEmail,
      });
      setState(() {
        documentId = newDoc.id; // Save document ID for future updates
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFFBF592B),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/images/logo.png',
                      height: 60,
                    ),
                    Text(
                      "Update Your Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFBF592B),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Details",
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
                          hintText: name.isEmpty ? 'Enter your name' : name,
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
                          contactNumber = value;
                        },
                        decoration: InputDecoration(
                          hintText: contactNumber.isEmpty
                              ? 'Enter your contact number'
                              : contactNumber,
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
                          onPressed: updateOrCreateProfile,
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
                            "Update Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
