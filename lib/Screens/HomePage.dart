import 'package:Notes/Providers/MainProvider.dart';
import 'package:Notes/Widgets/AppBar.dart';
import 'package:Notes/Widgets/floatingActionButton.dart';
import 'package:Notes/Widgets/homePageStreamBuilder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser user;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((val) {
      if (val == null) {
        setState(() {
          user = null;
        });
      } else {
        setState(() {
          user = val;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: WillPopScope(
            onWillPop: () => mainProvider.onPop(),
            child: Scaffold(
                floatingActionButton: buildFloatingActionButton(user, context),
                backgroundColor: Colors.black,
                appBar: mainProvider.selectedDocumentsList.length == 0
                    ? buildAppBar(context, user == null ? '' : user.photoUrl,
                        mainProvider)
                    : onSelectAppBar(mainProvider, user),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: user == null
                      ? Center(child: CircularProgressIndicator())
                      : buildStreamBuilder(mainProvider, user),
                )),
          ),
        ),
      ),
    );
  }
}
