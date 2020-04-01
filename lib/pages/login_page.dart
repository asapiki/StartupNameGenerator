import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final userModel;

  const LoginPage({Key key, this.userModel}) : super(key: key);

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
            _biuldEmailAuth(),
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
        widget.userModel.signInAsAnonymous();
      },
    );
  }

  RaisedButton _buildGithubAuth() {
    return RaisedButton(
      child: Text('github'),
      onPressed: () {
        widget.userModel.signInWithGithub();
      },
    );
  }

  RaisedButton _buildGoogleAuth() {
    return RaisedButton(
      child: Text('google'),
      onPressed: () {
        widget.userModel.signInWithGoogle();
      },
    );
  }

  Column _biuldEmailAuth() {
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
            widget.userModel.signInWithEmail(
              emailController.value.text,
              passwordController.value.text,
            );
          },
        ),
      ],
    );
  }
}
