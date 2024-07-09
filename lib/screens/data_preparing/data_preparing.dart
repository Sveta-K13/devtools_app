import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/pairs.dart';

const _sharedPrefsKey = 'pairs_key';

class DataPreparing extends StatefulWidget {
  const DataPreparing({super.key});

  @override
  State<DataPreparing> createState() => _DataPreparingState();
}

class _DataPreparingState extends State<DataPreparing> {
  bool useFirstVariant = true;
  List<Pair<List<int>>> pairs = [];

  @override
  void initState() {
    super.initState();
    _setupPairs();
  }

  Future<void> _setupPairs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedPairsData = prefs.getString(_sharedPrefsKey);
    if (savedPairsData != null) {
      final decoded = jsonDecode(savedPairsData) as List;
      pairs = decoded
          .map(
            (i) => Pair.fromJson(
                i as Map<String, dynamic>,
                (jsonString) => (jsonDecode(jsonString as String) as List)
                    .map((e) => e as int)
                    .toList(growable: false)),
          )
          .toList(
            growable: false,
          );
    } else {
      pairs = List.generate(
        24,
        (i) => _createPair(),
      );
      prefs.setString(
        _sharedPrefsKey,
        jsonEncode(
          pairs,
          toEncodable: (obj) => (obj as Pair).toJson(
            jsonEncode,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(useFirstVariant ? 'index' : 'set'),
        onPressed: () {
          setState(() {
            useFirstVariant = !useFirstVariant;
          });
        },
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: pairs.length,
          itemBuilder: (BuildContext ctx, index) {
            final pair = pairs[index];
            return PairTile(
              pair: pair,
              useFirstVariant: useFirstVariant,
            );
          },
        ),
        // ],
        // ),
      ),
    );
  }

  Pair<List<int>> _createPair() => Pair(
        first: _generateData(20),
        second: _generateData(4),
      );

  List<int> _generateData(int maxLength) {
    Random random = Random(
      DateTime.now().millisecond,
    );

    int max = 50;

    int randomLength = random.nextInt(maxLength) + 1;

    return List<int>.generate(
      randomLength,
      (int index) => random.nextInt(max),
    );
  }
}

class PairTile extends StatelessWidget {
  final Pair<List<int>> pair;
  final bool useFirstVariant;

  const PairTile({
    super.key,
    required this.pair,
    required this.useFirstVariant,
  });

  @override
  Widget build(BuildContext context) {
    final containsAll = useFirstVariant
        ? pair.first.containsAll(pair.second)
        : pair.first.containsAllV2(pair.second);
    return SizedBox(
      width: 50,
      height: 50,
      child: Placeholder(
        color: containsAll ? Colors.green : Colors.red,
      ),
    );
  }
}

extension ListExtension<T> on List<T> {
  bool containsAll(Iterable<T> collection) {
    if (collection.isEmpty) {
      return true;
    }
    for (final item in collection) {
      if (!contains(item)) {
        return false;
      }
    }

    return true;
  }

  bool containsAllV2(Iterable<T> collection) => toSet().containsAll(collection);
}
