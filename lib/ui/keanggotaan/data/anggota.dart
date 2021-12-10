import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vtime.dart';

class Anggota {
  String? id;
  String nama;
  String nomorHp;
  String alamat;
  DateTime? tanggalLahir;
  DateTime? tanggalBergabung;
  String jenisKelamin;
  String nik;
  String pekerjaan;
  int? totalLatihan;

  Anggota({
    this.id = '',
    this.nama = '',
    this.nomorHp = '',
    this.alamat = '',
    this.tanggalLahir,
    this.tanggalBergabung,
    this.jenisKelamin = '',
    this.nik = '',
    this.pekerjaan = '',
    this.totalLatihan = 0,
  });

  static Anggota? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Anggota(
      id: map['id'],
      nama: map['nama'],
      nomorHp: map['nomorHp'],
      alamat: map['alamat'],
      tanggalLahir: map['tanggalLahir']?.toDate(),
      tanggalBergabung: map['tanggalBergabung']?.toDate(),
      jenisKelamin: map['jenisKelamin'],
      nik: map['nik'],
      pekerjaan: map['pekerjaan'],
      totalLatihan: map['totalLatihan'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nomorHp': nomorHp,
      'alamat': alamat,
      'tanggalLahir': tanggalLahir,
      'tanggalBergabung': tanggalBergabung,
      'jenisKelamin': jenisKelamin,
      'nik': nik,
      'pekerjaan': pekerjaan,
      'totalLatihan': totalLatihan,
    };
  }

  String tanggalBergabungString() {
    if (tanggalBergabung == null) return '-';
    return VTime.defaultFormat(tanggalBergabung!.toIso8601String());
  }

  String tanggalLahirString() {
    if (tanggalLahir == null) return '-';
    return VTime.defaultFormat(tanggalLahir!.toIso8601String());
  }

  static Future<bool> insert(BuildContext context, Anggota anggota) async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    DocumentReference<Object?>? result = await datas.add(anggota.toMap());
    anggota.id = result.id;
    await Anggota.update(context, anggota);
    return true;
  }

  Future<bool> delete() async {
    if (id == null) return false;
    Fun.showLog('id: $id');
    await FirebaseFirestore.instance.collection('anggotas').doc(id).delete();
    return true;
  }

  static Future<List<Anggota>> gets() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> datas = firestore.collection('anggotas');
    QuerySnapshot<Map<String, dynamic>?>? results = await datas.get();
    List<Anggota> lists = [];
    for (DocumentSnapshot ds in results.docs) {
      ds.data();
      Anggota? data = Anggota.fromMap(ds.data() as Map<String, dynamic>);
      if (data != null) {
        data.id = ds.id;
        lists.add(data);
      }
    }
    return lists;
  }

  static Future<bool> update(BuildContext context, Anggota anggota) async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    await datas.doc(anggota.id).update(anggota.toMap());
    return true;
  }

  static List<Anggota> getDataFromSnapshot(QuerySnapshot<Object?>? snapshotData) {
    if (snapshotData == null) return [];
    List<Anggota> lists = [];
    for (DocumentSnapshot ds in snapshotData.docs) {
      Anggota? data = Anggota.fromMap(ds.data() as Map<String, dynamic>);
      if (data != null) {
        lists.add(data);
      }
    }
    return lists;
  }
}
