import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final msgtextcontroller= TextEditingController();
User? loggedinuser;

class ChatScreen extends StatefulWidget {

  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;

  String msgtext = '';

  @override
  void initState() {
    super.initState();
    getcurruser();
  }

  void getcurruser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedinuser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messagesstream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgtextcontroller,
                      onChanged: (value) {
                        msgtext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      msgtextcontroller.clear();
                      _firestore.collection('messages').add({
                        'text': msgtext,
                        'sender': loggedinuser?.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class messagesstream extends StatelessWidget {
  const messagesstream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final msgs = snapshot.data!.docs.reversed;
        List<messagebubble> messageBubbles = [];
        for (var msg in msgs) {
          final msgData = msg.data() as Map<String, dynamic>;
          final msgtext = msgData['text'];
          final msgsender = msgData['sender'];

          final currentuser=loggedinuser?.email;

          final messageBubble = messagebubble(
              sender: msgsender,
              text: msgtext,
              isme:currentuser==msgsender);
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
            reverse: true,
          ),
        );
      },
    );
  }
}





class messagebubble extends StatelessWidget {

  messagebubble({required this.sender, required this.text, required this.isme});

  final String sender;
  final String text;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(
            fontSize: 12.0, color: Colors.black54,
          ),),
          Material(
          borderRadius: isme? BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0))
          : BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
          elevation: 5.0,
          color: isme? Colors.lightBlueAccent : Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
                '$text',
              style: TextStyle(
                  fontSize: 15.0,
                  color: isme? Colors.white: Colors.black54),
            ),
          ),
        ),
      ]),
    );
  }
}

