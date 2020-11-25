import 'package:Notes/Constants/TextStyles.dart';
import 'package:Notes/Providers/MainProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

_showDialog(context, MainProvider mainProvider) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      titlePadding: EdgeInsets.all(10),
      backgroundColor: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Logout ?',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      content: Text("Log out from the current account ?",
          style: TextStyle(color: Colors.grey, fontSize: 15)),
      actions: <Widget>[
        FlatButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'LOGOUT',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          onPressed: () async {
            mainProvider.logOutUser(context);
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

AppBar buildAppBar(context, String url, MainProvider mainProvider) {
  return AppBar(
    automaticallyImplyLeading: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: Colors.white12,
    title: Text(
      "Notes",
      style: appBarTitleTextStyle(),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            _showDialog(context, mainProvider);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: url == ''
                ? Container()
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      )
    ],
    elevation: 0,
  );
}

AppBar onSelectAppBar(MainProvider mainProvider, FirebaseUser _user) {
  return AppBar(
    automaticallyImplyLeading: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: Colors.white12,
    leading: IconButton(
      onPressed: () {
        mainProvider.clearSelections();
      },
      icon: Icon(
        Icons.clear,
        color: Colors.white,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            mainProvider.deleteNotes(_user);
          },
          icon: Icon(
            Icons.delete_outline,
            color: Colors.white,
          ),
        ),
      )
    ],
    elevation: 0,
  );
}
