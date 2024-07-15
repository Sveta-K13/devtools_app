// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pair<T> _$PairFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pair<T>(
      first: fromJsonT(json['first']),
      second: fromJsonT(json['second']),
    );

Map<String, dynamic> _$PairToJson<T>(
  Pair<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'first': toJsonT(instance.first),
      'second': toJsonT(instance.second),
    };
