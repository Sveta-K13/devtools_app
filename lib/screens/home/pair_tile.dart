part of 'home_page.dart';

final meImg = Image.network(
  'https://raw.githubusercontent.com/Sveta-K13/flutter_colors_demo/master/images/me.jpg',
  height: 80,
);

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

  Color calcColor({bool containsAll = false}) {
    final containsColor = useFirstVariant ? Colors.green : Colors.lightBlue;
    final notContainsColor = useFirstVariant ? Colors.red : Colors.deepPurple;
    return containsAll ? containsColor : notContainsColor;
  }

  @override
  Widget build(BuildContext context) {
    final containsAll = calcContains();

    return SizedBox(
      width: 50,
      height: 50,
      child: Placeholder(
        color: calcColor(containsAll: containsAll),
        child: containsAll ? null : meImg,
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
