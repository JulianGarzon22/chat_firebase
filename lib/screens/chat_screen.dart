import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:chat_firebase/widgets/chats/new_message.dart';
import 'package:chat_firebase/widgets/chats/messages.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String chatId = '3vjTH46uM1UJMPcdaBVB';

  String userName = '';
  String userImage = '';

  @override
  void initState() {
    super.initState();

    this.getUserName();

    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });

    fbm.subscribeToTopic('chat');
  }

  void getUserName() async {
    String userKey = '';

    final currentUser = await FirebaseAuth.instance.currentUser();
    final currentChatCollection =
        await Firestore.instance.collection('chats').document(chatId).get();
    final currentChat = currentChatCollection.data;

    if (currentChat['user_1'] == currentUser.uid) {
      userKey = 'user_2';
    } else {
      userKey = 'user_1';
    }

    final userDocumentData = await Firestore.instance
        .collection('users')
        .document(currentChat[userKey])
        .get();

    setState(() {
      userName = userDocumentData.data['username'];
      userImage = userDocumentData.data['image_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(userName),
            ),
          ],
        ),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onChanged: (itemId) {
              if (itemId == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).accentColor,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(chatId),
            ),
            NewMessage(chatId),
          ],
        ),
      ),
    );
  }
}
