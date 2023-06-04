import 'package:flash_chat/components/MessageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final _firebasefirestore = FirebaseFirestore.instance;
late User loggedInUser;

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  // for send message
  final _auth = FirebaseAuth.instance; //for log in

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
            MessagesStream(),
            //below for typing pad above texts which text will after show in display.
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
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

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebasefirestore.collection('messages').snapshots(),
        // below for print  type and store data on screen .
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs
                .reversed; // by the reverse , msg show in bottom as type.
            List<MessageBubble> messageBubbles = [];

            for (var message in messages) {
              final messageData = message.data() as Map<String, dynamic>;
              final messageText = messageData['text'];
              final messageSender = messageData['sender'];

              final currentUser = loggedInUser.email;
              if (currentUser == messageSender) {
                //the message from the logged in user.
              }

              final messageBubble = MessageBubble(
                  sender: messageSender,
                  text: messageText,
                  isMe: currentUser == messageSender);
              messageBubbles.add(messageBubble);
            }

            return Expanded(
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                children: messageBubbles,
              ),
            );
          }

          // Add your desired fallback widget here in case there's no data
          return CircularProgressIndicator(
            backgroundColor: Colors.amber,
          );
        }

        // Handling case when snapshot does  // Example: showing a loading indicator
        //streambuilder use to display msg on screen from firebase collection.
        );
  }
}
