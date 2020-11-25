import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar newNoteAppBar(context, _textController, FirebaseUser user) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: Colors.white12,
    leading: IconButton(
      onPressed: () {
        if (_textController.text != '') {
          Firestore.instance
              .collection("user")
              .document(user.uid)
              .collection('notes')
              .add({"notes": "${_textController.text}"}).then((value) {
            print(value.documentID);
          });
        }
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white.withOpacity(0.5),
      ),
    ),
//    actions: <Widget>[
//      Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: ClipRRect(
//          borderRadius: BorderRadius.circular(50),
//          child: Image.network(
//            user.photoUrl,
//            fit: BoxFit.cover,
//          ),
//        ),
//      )
//    ],
    elevation: 0,
  );
}
