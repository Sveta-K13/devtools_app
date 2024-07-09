import 'dart:math';
import 'package:flutter/material.dart';

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
    pairs = List.generate(
      24,
      (i) => _createPair(),
    );
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
            final containsAll = useFirstVariant
                ? pair.first.containsAll(pair.second)
                : pair.first.containsAllV2(pair.second);
            return PairTile(
              pair: pair,
              containsAll: containsAll,
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
  final bool containsAll;

  const PairTile({
    super.key,
    required this.pair,
    required this.containsAll,
  });

  @override
  Widget build(BuildContext context) {
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

@immutable
class Pair<T> {
  final T first;
  final T second;

  const Pair({
    required this.first,
    required this.second,
  });
}
