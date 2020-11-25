import 'package:Notes/Screens/NewNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FloatingActionButton buildFloatingActionButton(FirebaseUser _user, context) {
  return FloatingActionButton(
    heroTag: "newNote",
    elevation: 20,
    backgroundColor: Colors.white.withOpacity(0.4),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewNote(_user)));
    },
    child: Icon(
      Icons.add,
      color: Colors.black87,
      size: 50,
    ),
  );
}
