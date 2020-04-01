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
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    const _showPassword = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'xxx@yyy.com',
                        labelText: 'email',
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.https),
                        hintText: 'abcd1234',
                        labelText: 'password',
//                          suffixIcon: IconButton(
//                            icon: Icon(_showPassword
//                                ? Icons.remove_red_eye
//                                : Icons.panorama_fish_eye),
//                          ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('email/password'),
                    onPressed: () {
                      user.signInWithEmail(
                        emailController.value.text,
                        passwordController.value.text,
                      );
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('google'),
              onPressed: () {
                user.signInWithGoogle();
              },
            ),
            RaisedButton(
              child: Text('github'),
              onPressed: () {
                user.signInWithGithub();
              },
            ),
          ],
        ),
      ),
    );
  }
}
