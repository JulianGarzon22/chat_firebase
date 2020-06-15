import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String chatId;

  NewMessage(this.chatId);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _controller = TextEditingController();
  String _enteredValue = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection('chats/${widget.chatId}/messages').add({
      'text': _enteredValue,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });

    setState(() {
      _controller.clear();
      _enteredValue = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).primaryColor,
      padding: Platform.isIOS
          ? EdgeInsets.only(left: 15, right: 15, bottom: 40, top: 15)
          : EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
                labelStyle: TextStyle(color: Colors.black87),
                labelText: 'Send a message...',
              ),
              style: TextStyle(color: Colors.black87),
              onChanged: (value) {
                setState(() {
                  _enteredValue = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredValue.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
