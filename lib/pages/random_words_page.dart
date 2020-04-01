import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/models/user_model.dart';
import 'package:startup_namer/pages/user_profile_page.dart';

class RandomWordsPage extends StatefulWidget {
  @override
  _RandomWordsPageState createState() => _RandomWordsPageState();
}

class _RandomWordsPageState extends State<RandomWordsPage> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  ThemeData get theme => Theme.of(context);

  final List<Map<String, dynamic>> userMenuItems = [
    {
      'title': 'logout',
      'function': (BuildContext context) {
        Provider.of<UserModel>(context, listen: false).logout();
      },
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          _buildUserMenuButton(),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildUserMenuButton() {
    return PopupMenuButton<Function>(
      icon: Icon(Icons.account_circle),
      onSelected: (Function f) {
        f(context);
      },
      itemBuilder: (context) {
        final userModel = Provider.of<UserModel>(context, listen: false);
        return [
              PopupMenuItem<Function>(
<<<<<<< ours
                child: Text(userModel.user.displayName),
=======
                child: Text(userModel.user.displayName ?? '名無し'),
>>>>>>> theirs
                value: (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(userModel)),
                  );
                },
              ),
            ] +
            userMenuItems
                .map(
                  (e) => PopupMenuItem<Function>(
                    child: Text(e['title']),
                    value: e['function'],
                  ),
                )
                .toList();
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: theme.textTheme.headline1,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: theme.textTheme.headline1,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }
}
