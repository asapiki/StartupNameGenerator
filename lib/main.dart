// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:startup_namer/pages/random_words_page.dart';

void main() {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  runApp(MyApp(googleSignIn: _googleSignIn, auth: _auth));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.googleSignIn, this.auth}) : super(key: key);
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      home: user == null ? buildLoginPage() : RandomWordsPage(),
    );
  }

  Scaffold buildLoginPage() {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: () {
            _handleSignIn().then((FirebaseUser user) {
              setState(() {
                this.user = user;
              });
            }).catchError((e) => print(e));
          },
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await widget.googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await widget.auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
}
