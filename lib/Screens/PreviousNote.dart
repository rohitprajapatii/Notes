import 'package:Notes/Widgets/newNoteBody.dart';
import 'package:Notes/Widgets/previousNoteAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreviousNote extends StatefulWidget {
  final String note, documentId;
  final FirebaseUser _user;
  PreviousNote(this._user, this.note, this.documentId);

  @override
  _PreviousNoteState createState() => _PreviousNoteState();
}

class _PreviousNoteState extends State<PreviousNote> {
  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      _textController.text = "${widget.note}";
    });
  }

  Future<bool> _onPop() async {
    Firestore.instance
        .collection("user")
        .document(widget._user.uid)
        .collection('notes')
        .document(widget.documentId)
        .updateData({"notes": "${_textController.text}"});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "previousNote${widget.documentId}",
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WillPopScope(
            onWillPop: _onPop,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: previousNoteAppBar(
                  context, _textController, widget._user, widget.documentId),
              body: newNoteBody(_textController),
            ),
          ),
        ),
      ),
    );
  }
}
