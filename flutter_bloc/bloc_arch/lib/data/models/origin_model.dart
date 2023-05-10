// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OriginModel {
  final String name;
  final String url;
  OriginModel({
    required this.name,
    required this.url,
  });

  OriginModel copyWith({
    String? name,
    String? url,
  }) {
    return OriginModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory OriginModel.fromMap(Map<String, dynamic> map) {
    return OriginModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OriginModel.fromJson(String source) => OriginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OriginModel(name: $name, url: $url)';

  @override
  bool operator ==(covariant OriginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
