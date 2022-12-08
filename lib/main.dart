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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IntelliApp Name Generator'),
        ),
        body: const Center(
          // child: Text('Hello World'),
          child: RandomWords(),
        ),
      ),
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
  final _enlargeFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _wordList.length) {
          _wordList.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(
            _wordList[index].asPascalCase,
            style: _enlargeFont,
          ),
        );
      },
    );
  }
}