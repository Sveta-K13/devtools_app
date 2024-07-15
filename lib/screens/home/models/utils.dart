import 'dart:convert';

import 'pairs.dart';

List<Pair<List<int>>> pairsFromJsonString(String savedPairsData) {
  final decoded = jsonDecode(savedPairsData) as List;
  return decoded
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
}

String pairsToJsonString(List<Pair<List<int>>> pairs) {
  return jsonEncode(
    pairs,
    toEncodable: (obj) => (obj as Pair).toJson(
      jsonEncode,
    ),
  );
}
