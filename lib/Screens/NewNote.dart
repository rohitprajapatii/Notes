import 'package:Notes/Widgets/newNoteAppBar.dart';
import 'package:Notes/Widgets/newNoteBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  final FirebaseUser _user;
  NewNote(this._user);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  TextEditingController _textController = TextEditingController();

  Future<bool> _onPop() async {
    if (_textController.text != '') {
      Firestore.instance
          .collection("user")
          .document(widget._user.uid)
          .collection('notes')
          .add({"notes": "${_textController.text}"}).then((value) {
        print(value.documentID);
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "newNote",
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WillPopScope(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: newNoteAppBar(context, _textController, widget._user),
              body: newNoteBody(_textController),
            ),
            onWillPop: _onPop,
          ),
        ),
      ),
    );
  }
}
