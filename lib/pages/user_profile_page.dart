import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/models/user_model.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage(this.user, {Key key}) : super(key: key);

  final UserModel user;

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

  Column buildBasicInfos() {
    return Column(
      children: [
        buildInfo('uid', user.user.providerData[0].uid),
        buildInfo('email', user.user.email),
        buildInfo('表示名', user.user.displayName),
        buildInfo('isAnonymous', user.user.isAnonymous.toString()),
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
