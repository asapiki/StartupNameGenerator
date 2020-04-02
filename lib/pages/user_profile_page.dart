import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('基本情報', style: Theme.of(context).textTheme.headline6),
              buildBasicInfos(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBasicInfos() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final user = snapshot.data;
        return Column(
          children: [
            buildInfo('uid', user.providerData[0].uid),
            buildInfo('email', user.email),
            buildInfo('表示名', user.displayName),
            buildInfo('isAnonymous', user.isAnonymous.toString()),
          ],
        );
      },
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
