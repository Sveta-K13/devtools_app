import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/pairs.dart';
import 'models/utils.dart';

part 'pair_tile.dart';

const _sharedPrefsKey = 'pairs_key';

final _stopwatch = Stopwatch();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool useFirstCalculateVariant = true;
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

  Future<void> _setupPairs({bool useSharedPrefs = true}) async {
    if (useSharedPrefs) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final savedPairsData = prefs.getString(_sharedPrefsKey);
      if (savedPairsData != null) {
        pairs = pairsFromJsonString(savedPairsData);
      } else {
        pairs = generatePairs();
        prefs.setString(
          _sharedPrefsKey,
          pairsToJsonString(pairs),
        );
      }
    } else {
      pairs = generatePairs();
    }
    setState(() {});
  }

  List<Pair<List<int>>> generatePairs() {
    return List.generate(
      24,
      (i) => _createPair(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Text(
              'setup random pairs',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _setupPairs(useSharedPrefs: false);
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            child: Text(
              useFirstCalculateVariant ? 'do by set' : 'do by index',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _stopwatch.reset();
              setState(() {
                useFirstCalculateVariant = !useFirstCalculateVariant;
              });
            },
          ),
        ],
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
              useFirstVariant: useFirstCalculateVariant,
            );
          },
        ),
      ),
    );
  }

  Pair<List<int>> _createPair() => Pair(
        first: _generateData(60),
        second: _generateData(6),
      );

  List<int> _generateData(int maxLength) {
    Random random = Random(
      DateTime.now().microsecond,
    );

    int max = 80;

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
