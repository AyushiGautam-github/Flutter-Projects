import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AcceptedRequestPage extends StatefulWidget {
  @override
  _AcceptedRequestPageState createState() => _AcceptedRequestPageState();
}

class _AcceptedRequestPageState extends State<AcceptedRequestPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accepted Requests",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFBF592B),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'lib/images/logo.png',
                      height: 60,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Accepted Requests',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: 8),
                  Text('Click on Request box for more detail!',style: TextStyle(color: Color(0xFFBF592B)),)
              ]),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('request')
                    .where('acceptedBy.email', isEqualTo: currentUser?.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No accepted requests found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  final requests = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final requestDoc = requests[index];
                      final request = requestDoc.data() as Map<String, dynamic>;
                      final requestId = requestDoc.id;
                      final requestStatus = request['status'] ?? 'pending';

                      return GestureDetector(
                        onTap: () => _showRequestDetails(context, requestId),
                        child: Card(
                          color: Color(0xFFBF592B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User: ${request['user'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Pickup Info: ${request['pickupinfo'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Delivery: ${request['deliveryloc'] ?? 'N/A'}',
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Amount: ₹${request['amount'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.lightGreenAccent,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Time: ${request['time'] ?? 'N/A'}',
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Status: ${requestStatus}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: requestStatus == 'accepted'
                                        ? Colors.greenAccent
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays request details along with accepted user info
  void _showRequestDetails(BuildContext context, String requestId) async {
    final requestSnapshot = await firestore.collection('request')
        .doc(requestId)
        .get();

    if (!requestSnapshot.exists) return;

    final request = requestSnapshot.data() as Map<String, dynamic>;
    final acceptedBy = request['acceptedBy'] as Map<String, dynamic>?;

    // Fetch requester's profile details
    final profileSnapshot = await firestore
        .collection('profile')
        .where('email', isEqualTo: request['user'])
        .limit(1)
        .get();

    String requesterName = 'N/A';
    String requesterContact = 'N/A';

    if (profileSnapshot.docs.isNotEmpty) {
      final profileData = profileSnapshot.docs.first.data();
      requesterName = profileData['name'] ?? 'N/A';
      requesterContact = profileData['contact'] ?? 'N/A';
    }

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Request Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User: ${request['user'] ?? 'N/A'}'),
                Text('Name: $requesterName'),
                Text('Contact: $requesterContact'),
                Text('Pickup Info: ${request['pickupinfo'] ?? 'N/A'}'),
                Text('Delivery Location: ${request['deliveryloc'] ?? 'N/A'}'),
                Text('Amount: ₹${request['amount'] ?? 'N/A'}'),
                Text('Time: ${request['time'] ?? 'N/A'}'),
                SizedBox(height: 10),
                Text(
                  'Status: ${request['status']}',
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                if (acceptedBy != null) ...[
                  SizedBox(height: 10),
                  Text(
                    'Accepted By:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Name: ${acceptedBy['name'] ?? 'N/A'}'),
                  Text('Email: ${acceptedBy['email'] ?? 'N/A'}'),
                  Text('Contact: ${acceptedBy['contact'] ?? 'N/A'}'),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }
}