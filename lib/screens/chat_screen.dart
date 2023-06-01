import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firebasefirestore = FirebaseFirestore.instance; // for send message
  final _auth = FirebaseAuth.instance; //for log in
  late User loggedInUser;
  late String messageText; //for send msg

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // for retrive the data. and print data of our firebase collection  in console
  // void getMessages() async {
  //   final messages = await _firebasefirestore.collection('New_messages').get();
  //   for (var message  in messages.docs) {
  //     print(message.data());
  //   }
  // }
//print data of our firebase collection  in console //**********stream*********
  void messagesStream() async {
    await for (var snapshot
        in _firebasefirestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
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
                messagesStream();
                // _auth.signOut();
                // Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firebasefirestore.collection('messages').snapshots(),
                // below for print  type and store data on screen .
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];

                    for (var message in messages) {
                      final messageData =
                          message.data() as Map<String, dynamic>;
                      final messageText = messageData['text'];
                      final messageSender = messageData['sender'];

                      final messageWidget = Text(
                        '$messageText from $messageSender',
                      );
                      messageWidgets.add(messageWidget);
                    }

                    return Column(
                      children: messageWidgets,
                    );
                  }

                  // Add your desired fallback widget here in case there's no data
                  return CircularProgressIndicator();
                }

                // Handling case when snapshot does  // Example: showing a loading indicator
                //streambuilder use to display msg on screen from firebase collection.
                ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firebasefirestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      }); //from firebase.
                      //Implement send functionality.
                    },
                    child: const Text(
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
