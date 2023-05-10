// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class EpisodeModel {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime? created;
  EpisodeModel({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  EpisodeModel copyWith({
    int? id,
    String? name,
    String? air_date,
    String? episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) {
    return EpisodeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      air_date: air_date ?? this.air_date,
      episode: episode ?? this.episode,
      characters: characters ?? this.characters,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'air_date': air_date,
      'episode': episode,
      'characters': characters,
      'url': url,
      'created': created?.millisecondsSinceEpoch,
    };
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map) {
    return EpisodeModel(
      id: map['id'] as int,
      name: map['name'] ?? '',
      air_date: map['air_date'] ?? '',
      episode: map['episode'] ?? '',
      characters: List<String>.from((map['characters'] ?? [])),
      url: map['url'] ?? '',
      created: map['created'] == null ? null :DateTime.parse(map['created']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeModel.fromJson(String source) => EpisodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EpisodeModel(id: $id, name: $name, air_date: $air_date, episode: $episode, characters: $characters, url: $url, created: $created)';
  }

  @override
  bool operator ==(covariant EpisodeModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.id == id &&
      other.name == name &&
      other.air_date == air_date &&
      other.episode == episode &&
      listEquals(other.characters, characters) &&
      other.url == url &&
      other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      air_date.hashCode ^
      episode.hashCode ^
      characters.hashCode ^
      url.hashCode ^
      created.hashCode;
  }
}
