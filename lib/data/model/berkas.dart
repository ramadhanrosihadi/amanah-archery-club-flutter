import 'dart:convert';

class Berkas {
  final int id;
  final String full_path;
  final String full_path_thumbnail;
  Berkas({
    this.id = 0,
    this.full_path = '',
    this.full_path_thumbnail = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_path': full_path,
      'full_path_thumbnail': full_path_thumbnail,
    };
  }

  static Berkas? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Berkas(
      id: map['id']?.toInt() ?? 0,
      full_path: map['full_path'] ?? '',
      full_path_thumbnail: map['full_path_thumbnail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static Berkas? fromJson(String source) => Berkas.fromMap(json.decode(source));
}
