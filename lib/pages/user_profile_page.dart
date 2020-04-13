import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/services/auth_service.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.currentUser().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final user = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('基本情報', style: Theme.of(context).textTheme.headline6),
                  buildBasicInfos(user),
                  RaisedButton(
                    child: Text('googleアカウントに紐付け'),
                    onPressed: () {
                      // 匿名ユーザをgoogle認証に紐付けする処理
                      AuthService.linkWithGoogle();
                    },
                  ),
                  RaisedButton(
                    child: Text('githubアカウントに紐付け'),
                    onPressed: () {
                      // 匿名ユーザをgoogle認証に紐付けする処理
                      AuthService.linkWithGithub();
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildBasicInfos(FirebaseUser user) {
    return Column(
      children: [
        buildInfo('uid', user.providerData[0].uid),
        buildInfo('email', user.email),
        buildInfo('表示名', user.displayName),
        buildInfo('isAnonymous', user.isAnonymous.toString()),
      ],
    );
  }

  Row buildInfo(String title, String value) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title)),
        Expanded(child: Text(value ?? '登録なし')),
      ],
    );
  }
}
