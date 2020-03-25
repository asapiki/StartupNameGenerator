// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/models/user_model.dart';
import 'package:startup_namer/pages/random_words_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: ListenableProvider<UserModel>(
        create: (_) => UserModel(),
        child: Consumer<UserModel>(
          builder: (context, value, child) {
            return value.isLoggedIn ? RandomWordsPage() : buildLoginPage(value);
          },
        ),
      ),
    );
  }

  Scaffold buildLoginPage(UserModel user) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: () {
            user.login();
          },
        ),
      ),
    );
  }
}
