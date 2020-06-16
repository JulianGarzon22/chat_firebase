import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const myFunction = functions.firestore
  .document("chats/{docId}/messages/{messageId}")
  .onCreate((snap, context) => {
    console.log(snap.data());
    admin.messaging().sendToTopic(
      "chat",
      {
        notification: {
          title: snap.data().userId,
          body: snap.data().text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      },
    ).then().catch((err) => {
      console.log(err);
    });
  });
