import 'dart:convert';

class Kehadiran {
  final String id;
  final DateTime waktu;
  final String anggotaId;
  final String anggotaNama;
  Kehadiran({
    this.id = '',
    required this.waktu,
    this.anggotaId = '',
    this.anggotaNama = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'waktu': waktu,
      'anggotaId': anggotaId,
      'anggotaNama': anggotaNama,
    };
  }

  factory Kehadiran.fromMap(Map<String, dynamic> map) {
    return Kehadiran(
      id: map['id'] ?? '',
      waktu: map['waktu'],
      anggotaId: map['anggotaId'] ?? '',
      anggotaNama: map['anggotaNama'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Kehadiran.fromJson(String source) => Kehadiran.fromMap(json.decode(source));

  static List<Kehadiran> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<Kehadiran>((e) => Kehadiran.fromMap(e)).toList();
  }
}
