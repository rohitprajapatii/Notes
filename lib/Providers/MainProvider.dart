import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainProvider with ChangeNotifier {
  List<bool> selectedDocumentIcon = [];
  List<String> selectedDocumentsList = [];
  bool itemSelected = false;
  bool isGoogleLogged, isLoggedIn;
  FirebaseUser user;
  MainProvider() {
    checkLog();
  }

  Future<void> logOutUser(context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
    checkLog();
    notifyListeners();
  }

  checkLog() async {
    bool value = await GoogleSignIn().isSignedIn();
    await FirebaseAuth.instance.currentUser().then((val) {
      if (val == null) {
        isGoogleLogged = false;
      } else {
        isGoogleLogged = true;
      }
      user = val;
    });
    isLoggedIn = value;
    notifyListeners();
  }

  void makeSelectedDocumentsList(String documentId, int length) {
    bool present = false;
    for (int i = 0; i < selectedDocumentsList.length; i++) {
      if (selectedDocumentsList[i] == documentId) {
        selectedDocumentsList.removeAt(i);
        present = true;
        notifyListeners();
      }
    }
    if (present == false) selectedDocumentsList.add(documentId);
    print(selectedDocumentsList.length);
    notifyListeners();
  }

  Widget checkIfPresent(String documentId) {
    for (int i = 0; i < selectedDocumentsList.length; i++) {
      if (selectedDocumentsList[i] == documentId) {
        return Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.check_circle,
            color: Color(0xffffab91),
          ),
        );
      }
    }
    if (selectedDocumentsList.length == 0) {
      return Text('');
    } else {
      return Positioned(
        top: 0,
        right: 0,
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.white.withOpacity(0.3),
        ),
      );
    }
  }

  void clearSelections() {
    selectedDocumentsList.clear();
    notifyListeners();
  }

  void deleteNotes(FirebaseUser user) {
    for (var i = 0; i < selectedDocumentsList.length; ++i) {
      Firestore.instance
          .collection('user')
          .document(user.uid)
          .collection('notes')
          .document(selectedDocumentsList[i])
          .delete()
          .catchError((e) => {print(e)});
    }
    clearSelections();
    notifyListeners();
  }

  Future<bool> onPop() async {
    if (selectedDocumentsList.length != 0) {
      clearSelections();
    }
    return true;
  }
}
