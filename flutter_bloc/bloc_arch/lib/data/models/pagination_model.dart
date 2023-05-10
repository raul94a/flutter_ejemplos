// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaginationModel {
  
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  PaginationModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  PaginationModel copyWith({
    int? count,
    int? pages,
    String? next,
    String? prev,
  }) {
    return PaginationModel(
      count: count ?? this.count,
      pages: pages ?? this.pages,
      next: next ?? this.next,
      prev: prev ?? this.prev,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  int get pageNumberCharacters {
    if(next == null) return pages;
    final results = next!.split('https://rickandmortyapi.com/api/character?page=');
    return int.parse(results.last) - 1;
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) => PaginationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaginationModel(count: $count, pages: $pages, next: $next, prev: $prev)';
  }

  @override
  bool operator ==(covariant PaginationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.count == count &&
      other.pages == pages &&
      other.next == next &&
      other.prev == prev;
  }

  @override
  int get hashCode {
    return count.hashCode ^
      pages.hashCode ^
      next.hashCode ^
      prev.hashCode;
  }
}
