// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/data/models/pagination_model.dart';
import 'package:collection/collection.dart';

class CharactersApiModel {
  final PaginationModel info;
  final List<CharacterModel> results;
  CharactersApiModel({
    required this.info,
    required this.results,
  });

  CharactersApiModel copyWith({
    PaginationModel? info,
    List<CharacterModel>? results,
  }) {
    return CharactersApiModel(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory CharactersApiModel.fromMap(Map<String, dynamic> map) {
    return CharactersApiModel(
      info: PaginationModel.fromMap(map['info'] as Map<String, dynamic>),
      results: List<CharacterModel>.from(
        (map['results'] as List<dynamic>).map<CharacterModel>(
          (x) => CharacterModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharactersApiModel.fromJson(String source) =>
      CharactersApiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CharactersApiModel(info: $info, results: $results)';

  @override
  bool operator ==(covariant CharactersApiModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.info == info && listEquals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}
