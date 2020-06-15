import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_firebase/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final String chatId;

  Messages(this.chatId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chats/$chatId/messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final documents = snapshot.data.documents;

                return ListView.builder(
                  reverse: true,
                  itemCount: documents.length,
                  itemBuilder: (ctx, i) => MessageBubble(
                    documents[i],
                    documents[i]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(documents[i].documentID),
                  ),
                );
              });
        });
  }
}
