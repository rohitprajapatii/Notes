import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar previousNoteAppBar(context, TextEditingController _textController,
    FirebaseUser user, String id) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: Colors.white12,
    leading: IconButton(
      onPressed: () {
        Firestore.instance
            .collection("user")
            .document(user.uid)
            .collection('notes')
            .document(id)
            .updateData({"notes": "${_textController.text}"});
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
