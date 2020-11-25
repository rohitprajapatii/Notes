import 'package:Notes/Constants/TextStyles.dart';
import 'package:Notes/Providers/MainProvider.dart';
import 'package:Notes/Screens/PreviousNote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

StreamBuilder<QuerySnapshot> buildStreamBuilder(
    MainProvider mainProvider, FirebaseUser _user) {
  return StreamBuilder(
    stream: Firestore.instance
        .collection('user')
        .document(_user.uid)
        .collection('notes')
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        return new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            return Hero(
              tag: "previousNote${ds.documentID}",
              child: Stack(fit: StackFit.passthrough, children: <Widget>[
                GestureDetector(
                  onLongPress: () => {
                    mainProvider.makeSelectedDocumentsList(
                        ds.documentID, snapshot.data.documents.length)
                  },
                  onTap: () => mainProvider.selectedDocumentsList.length != 0
                      ? mainProvider.makeSelectedDocumentsList(
                          ds.documentID, snapshot.data.documents.length)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviousNote(
                                  _user, ds['notes'], ds.documentID))),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical:
                              mainProvider.selectedDocumentsList.length == 0
                                  ? 2.0
                                  : 4.0,
                          horizontal:
                              mainProvider.selectedDocumentsList.length == 0
                                  ? 3.0
                                  : 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                              color: Colors.white12,
                              width: 2,
                              style: BorderStyle.solid)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Text(
                          ds['notes'],
                          style: homePageNotesTextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
                mainProvider.checkIfPresent(ds.documentID)
              ]),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
