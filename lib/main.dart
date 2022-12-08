import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliApp Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyanAccent,
          foregroundColor: Colors.blueGrey,
        ),
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _wordList = <WordPair>[];
  final _favorites = <WordPair>{};
  final _enlargeFont = const TextStyle(fontSize: 18);
  void _pushFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _favorites.map(
              (pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _enlargeFont,
                  ),
                );
              },
          );
          final divided = tiles.isNotEmpty ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
              ).toList() : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: ListView(children: divided,),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntelliApp Name Generator'),
        actions: [
          IconButton(
              onPressed: _pushFavorites,
              icon: const Icon(Icons.list),
            tooltip: 'Favorites',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _wordList.length) {
            _wordList.addAll(generateWordPairs().take(10));
          }

          final favorited = _favorites.contains(_wordList[index]);
          return ListTile(
            title: Text(
              _wordList[index].asPascalCase,
              style: _enlargeFont,
            ),
            trailing: Icon(
              favorited ? Icons.favorite : Icons.favorite_border,
              color: favorited ? Colors.pink : null,
              semanticLabel: favorited ? 'Remove from favorites' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (favorited) {
                  _favorites.remove(_wordList[index]);
                } else {
                  _favorites.add(_wordList[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}