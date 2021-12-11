import 'dart:convert';

import 'package:starter_d/ui/pelatihan/data/target_face.dart';

class Skoring {
  final String id;
  final int jarak;
  final String jenisBusur;
  final int jumlahAnakPanah;
  final int totalRonde;
  final TargetFace targetFace;
  final List<dynamic> nilai;
  Skoring({
    this.id = '',
    this.jarak = 0,
    this.jenisBusur = '',
    this.jumlahAnakPanah = 0,
    this.totalRonde = 0,
    required this.targetFace,
    this.nilai = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jarak': jarak,
      'jenisBusur': jenisBusur,
      'jumlahAnakPanah': jumlahAnakPanah,
      'totalRonde': totalRonde,
      'targetFace': targetFace,
      'nilai': nilai,
    };
  }

  factory Skoring.fromMap(Map<String, dynamic> map) {
    return Skoring(
      id: map['id'] ?? '',
      jarak: map['jarak']?.toInt() ?? 0,
      jenisBusur: map['jenisBusur'] ?? '',
      jumlahAnakPanah: map['jumlahAnakPanah']?.toInt() ?? 0,
      totalRonde: map['totalRonde']?.toInt() ?? 0,
      targetFace: TargetFace.fromMap(map['targetFace']),
      nilai: List<dynamic>.from(map['nilai'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skoring.fromJson(String source) => Skoring.fromMap(json.decode(source));

  static List<Skoring> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<Skoring>((e) => Skoring.fromMap(e)).toList();
  }
}
