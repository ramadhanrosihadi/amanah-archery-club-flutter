import 'dart:convert';

import 'package:starter_d/ui/pelatihan/data/target_face_point.dart';

class TargetFace {
  final String id;
  final String name;
  final String imageUrl;
  final int heightInCm;
  final int widthInCm;
  final List<TargetFacePoint> point;
  TargetFace({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
    this.heightInCm = 0,
    this.widthInCm = 0,
    this.point = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'heightInCm': heightInCm,
      'widthInCm': widthInCm,
      'point': point,
    };
  }

  factory TargetFace.fromMap(Map<String, dynamic> map) {
    return TargetFace(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      heightInCm: map['heightInCm']?.toInt() ?? 0,
      widthInCm: map['widthInCm']?.toInt() ?? 0,
      point: TargetFacePoint.fromListDynamic(map['point'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory TargetFace.fromJson(String source) => TargetFace.fromMap(json.decode(source));
}
