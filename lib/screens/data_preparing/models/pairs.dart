import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pairs.g.dart';

@JsonSerializable(genericArgumentFactories: true)
@immutable
class Pair<T> {
  final T first;
  final T second;

  const Pair({
    required this.first,
    required this.second,
  });

  /// Connect the generated [_$PairFromJson] function to the `fromJson`
  /// factory.
  factory Pair.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PairFromJson(
        json,
        fromJsonT,
      );

  /// Connect the generated [_$PairToJson] function to the `toJson` method.
  Map<String, dynamic> toJson(
    Object Function(T) toJsonT,
  ) =>
      _$PairToJson(
        this,
        toJsonT,
      );
}
