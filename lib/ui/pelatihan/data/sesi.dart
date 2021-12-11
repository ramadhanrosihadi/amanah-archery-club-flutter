import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sesi {
  String? id;
  String? tanggal;
  String? waktuMulai;
  String? waktuSelesai;
  String catatan;
  List<dynamic> kehadiran;
  List<dynamic> skoring;
  Sesi({
    this.id = '',
    this.tanggal,
    this.waktuMulai,
    this.waktuSelesai,
    this.catatan = '',
    this.kehadiran = const [],
    this.skoring = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal,
      'waktuMulai': waktuMulai,
      'waktuSelesai': waktuSelesai,
      'catatan': catatan,
      'kehadiran': kehadiran,
      'skoring': skoring,
    };
  }

  factory Sesi.fromMap(Map<String, dynamic> map) {
    return Sesi(
      id: map['id'] ?? '',
      tanggal: map['tanggal'],
      waktuMulai: map['waktuMulai'],
      waktuSelesai: map['waktuSelesai'],
      catatan: map['catatan'] ?? '',
      kehadiran: List<dynamic>.from(map['kehadiran'] ?? const []),
      skoring: List<dynamic>.from(map['skoring'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sesi.fromJson(String source) => Sesi.fromMap(json.decode(source));

  static List<Sesi> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<Sesi>((e) => Sesi.fromMap(e)).toList();
  }

  static Future<bool> insert(BuildContext context, Sesi data) async {
    List<Sesi> existingDatas = await Sesi.gets();
    for (Sesi item in existingDatas) {
      if (item.waktuSelesai == null) {
        return false;
      }
    }
    CollectionReference datas = FirebaseFirestore.instance.collection('sesis');
    DocumentReference<Object?>? result = await datas.add(data.toMap());
    data.id = result.id;
    await Sesi.update(context, data);
    return true;
  }

  Future<bool> delete() async {
    if (id == null) return false;
    await FirebaseFirestore.instance.collection('sesis').doc(id).delete();
    return true;
  }

  static Future<List<Sesi>> gets() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> datas = firestore.collection('sesis');
    QuerySnapshot<Map<String, dynamic>?>? results = await datas.get();
    List<Sesi> lists = [];
    for (DocumentSnapshot ds in results.docs) {
      ds.data();
      Sesi? data = Sesi.fromMap(ds.data() as Map<String, dynamic>);
      if (data != null) {
        data.id = ds.id;
        lists.add(data);
      }
    }
    return lists;
  }

  static Future<bool> update(BuildContext context, Sesi data) async {
    CollectionReference datas = FirebaseFirestore.instance.collection('sesis');
    await datas.doc(data.id).update(data.toMap());
    return true;
  }

  static List<Sesi> getDataFromSnapshot(QuerySnapshot<Object?>? snapshotData) {
    if (snapshotData == null) return [];
    List<Sesi> lists = [];
    for (DocumentSnapshot ds in snapshotData.docs) {
      Sesi? data = Sesi.fromMap(ds.data() as Map<String, dynamic>);
      if (data != null) {
        lists.add(data);
      }
    }
    return lists;
  }
}
