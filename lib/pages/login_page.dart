import 'package:flutter/material.dart';
import 'package:startup_namer/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmailAuth(),
            _buildGoogleAuth(),
            _buildGithubAuth(),
            _buildAnonymousAuth(),
          ],
        ),
      ),
    );
  }

  RaisedButton _buildAnonymousAuth() {
    return RaisedButton(
      child: Text('anonymous'),
      onPressed: () {
        AuthService.signInAsAnonymous();
      },
    );
  }

  RaisedButton _buildGithubAuth() {
    return RaisedButton(
      child: Text('github'),
      onPressed: () {
        AuthService.signInWithGithub();
      },
    );
  }

  RaisedButton _buildGoogleAuth() {
    return RaisedButton(
      child: Text('google'),
      onPressed: () {
        AuthService.signInWithGoogle();
      },
    );
  }

  Column _buildEmailAuth() {
    return Column(
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
            obscureText: _hidePassword,
            decoration: InputDecoration(
              icon: Icon(Icons.https),
              hintText: 'abcd1234',
              labelText: 'password',
              suffixIcon: IconButton(
                icon: Icon(_hidePassword
                    ? Icons.remove_red_eye
                    : Icons.panorama_fish_eye),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              ),
            ),
          ),
        ),
        RaisedButton(
          child: Text('email/password'),
          onPressed: () {
            AuthService.signInWithEmail(
              emailController.value.text,
              passwordController.value.text,
            );
          },
        ),
      ],
    );
  }
}
