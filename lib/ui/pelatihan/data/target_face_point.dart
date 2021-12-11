import 'dart:convert';

class TargetFacePoint {
  final String id;
  final int color;
  final int value;
  TargetFacePoint({
    this.id = '',
    this.color = 0,
    this.value = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'value': value,
    };
  }

  factory TargetFacePoint.fromMap(Map<String, dynamic> map) {
    return TargetFacePoint(
      id: map['id'] ?? '',
      color: map['color']?.toInt() ?? 0,
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TargetFacePoint.fromJson(String source) => TargetFacePoint.fromMap(json.decode(source));

  static List<TargetFacePoint> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<TargetFacePoint>((e) => TargetFacePoint.fromMap(e)).toList();
  }
}
