import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/pairs.dart';

const _sharedPrefsKey = 'pairs_key';

final _stopwatch = Stopwatch();

class DataPreparing extends StatefulWidget {
  const DataPreparing({super.key});

  @override
  State<DataPreparing> createState() => _DataPreparingState();
}

class _DataPreparingState extends State<DataPreparing> {
  bool useFirstVariant = true;
  List<Pair<List<int>>> pairs = [];

  late UserTag previous;

  @override
  void initState() {
    super.initState();
    previous = UserTag('DataPreparing').makeCurrent();
    _setupPairs();
  }

  @override
  dispose() {
    previous.makeCurrent();
    super.dispose();
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
        child: Text(
          useFirstVariant ? 'do by set' : 'do by index',
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          _stopwatch.reset();
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      IntProperty('stopwatchCalc', _stopwatch.elapsedMicroseconds, unit: 'mcs'),
    );
    properties.add(
      FlagProperty(
        'stopwatchIsRunning',
        value: _stopwatch.isRunning,
        ifTrue: 'active',
        ifFalse: 'inactive',
      ),
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

  bool calcContains() {
    _stopwatch.start();
    final result = useFirstVariant
        ? pair.first.containsAllV1(pair.second)
        : pair.first.containsAllV2(pair.second);
    _stopwatch.stop();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final containsAll = calcContains();
    final containsColor = useFirstVariant ? Colors.green : Colors.lightBlue;
    final notContainsColor = useFirstVariant ? Colors.red : Colors.deepPurple;
    return SizedBox(
      width: 50,
      height: 50,
      child: Placeholder(
        color: containsAll ? containsColor : notContainsColor,
      ),
    );
  }
}

extension ListExtension<T> on List<T> {
  bool containsAllV1(Iterable<T> collection) {
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
