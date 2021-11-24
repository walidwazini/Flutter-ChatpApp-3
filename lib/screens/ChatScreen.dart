import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  //final FirebaseAuth?  _auth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String?  messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null ){
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //  final messages = await  _firestore.collection('messages').get();
  //  for ( var message in  messages.docs) {
  //    print(message.data());
  //  }
  // }

  void messagesStream() async {
    await for (var firebaseSnapshot in  _firestore.collection('messages').snapshots()) {
      for (var message in firebaseSnapshot.docs) {
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
            onPressed: (){
              messagesStream();
            }, icon: Icon(Icons.account_balance_outlined),
          ),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //messagesStream();
                //print(DateTime.now().toString());
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      messageController.clear();
                      // messageText + loggedInUser.email
                      _firestore.collection('messages').add({
                        'text' : messageText,
                        'sender' : loggedInUser!.email,
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

class MessagesStream extends StatelessWidget {
  //const MessagesStream({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots() ,
      // Snapshot docs from Firestore into the async snapshot of Flutter
      builder: ( context, asyncSnapshot ) {
        List<MessageBubble> messageWidgets = [];
        if (!asyncSnapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ),
          );
        } else if (asyncSnapshot.hasData) {
          final messages = asyncSnapshot.data!.docs;
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            //final timing = message['time'];
            final messageWidget = MessageBubble(text: messageText, sender: messageSender);
            messageWidgets.add(messageWidget);
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.text, required this.sender}) : super(key: key);
  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender, style: TextStyle(
            fontSize: 10, color: Colors.black54
          ),),
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 7.0,
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text ',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
