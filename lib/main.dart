import 'package:Notes/Providers/MainProvider.dart';
import 'package:Notes/Screens/HomePage.dart';
import 'package:Notes/Screens/LogInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home:
//          mainProvider.isLoggedIn == true && mainProvider.isGoogleLogged == true
//              ? HomePage(mainProvider.user)
//              : LogInScreen(),
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data != null) {
            return HomePage();
          } else {
            return LogInScreen();
          }
        },
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => LogInScreen(),
      },
    );
  }
}
