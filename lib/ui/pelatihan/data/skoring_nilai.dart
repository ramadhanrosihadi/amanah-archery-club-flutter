import 'dart:convert';

import 'package:starter_d/ui/pelatihan/data/target_face_point.dart';

class SkoringNilai {
  final String id;
  final String anggotaId;
  final String anggotaNama;
  final List<TargetFacePoint> points;
  SkoringNilai({
    this.id = '',
    this.anggotaId = '',
    this.anggotaNama = '',
    this.points = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'anggotaId': anggotaId,
      'anggotaNama': anggotaNama,
      'points': points,
    };
  }

  factory SkoringNilai.fromMap(Map<String, dynamic> map) {
    return SkoringNilai(
      id: map['id'] ?? '',
      anggotaId: map['anggotaId'] ?? '',
      anggotaNama: map['anggotaNama'] ?? '',
      points: TargetFacePoint.fromListDynamic(map['points'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkoringNilai.fromJson(String source) => SkoringNilai.fromMap(json.decode(source));

  static List<SkoringNilai> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<SkoringNilai>((e) => SkoringNilai.fromMap(e)).toList();
  }
}
