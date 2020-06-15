import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final DocumentSnapshot message;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        message['createdAt'].seconds * 1000);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromRGBO(39, 60, 117, 0.7)
                : Color.fromRGBO(251, 197, 49, 0.8),
            borderRadius: BorderRadius.only(
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(8),
              bottomLeft: isMe ? Radius.circular(8) : Radius.circular(0),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          width: (2 * MediaQuery.of(context).size.width) / 3,
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message['text'],
                style: TextStyle(fontSize: 20),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
              Text(
                DateFormat.Hm().format(date),
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
