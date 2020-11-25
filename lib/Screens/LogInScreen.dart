import 'package:Notes/Services/GoogleAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              'lib/assets/notesLogo.png',
              scale: 1.2,
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () async {
//                GoogleSignIn _googleSignIn = GoogleSignIn();
//                await FirebaseAuth.instance.signOut();
//                _googleSignIn.signOut();
                user = await handleSignIn();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: Text(
                    "Login with Google",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
