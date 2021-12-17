import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vtime.dart';

class Anggota {
  String? id;
  String? nama;
  String? nomorHp;
  String? email;
  String? alamat;
  DateTime? tanggalLahir;
  DateTime? tanggalBergabung;
  String? jenisKelamin;
  String? nik;
  String? pekerjaan;
  int? totalLatihan;
  String? kategori;
  String? fotoProfilUrl;
  Anggota({
    this.id = '',
    this.nama = '',
    this.nomorHp = '',
    this.email = '',
    this.alamat = '',
    this.tanggalLahir,
    this.tanggalBergabung,
    this.jenisKelamin = '',
    this.nik = '',
    this.pekerjaan = '',
    this.totalLatihan = 0,
    this.kategori = '',
    this.fotoProfilUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nomorHp': nomorHp,
      'email': email,
      'alamat': alamat,
      'tanggalLahir': tanggalLahir,
      'tanggalBergabung': tanggalBergabung,
      'jenisKelamin': jenisKelamin,
      'nik': nik,
      'pekerjaan': pekerjaan,
      'totalLatihan': totalLatihan,
      'kategori': kategori,
      'fotoProfilUrl': fotoProfilUrl,
    };
  }

  factory Anggota.fromMap(Map<String, dynamic> map) {
    return Anggota(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      nomorHp: map['nomorHp'] ?? '',
      email: map['email'] ?? '',
      alamat: map['alamat'] ?? '',
      tanggalLahir: map['alamat'],
      tanggalBergabung: map['alamat'],
      jenisKelamin: map['jenisKelamin'] ?? '',
      nik: map['nik'] ?? '',
      pekerjaan: map['pekerjaan'] ?? '',
      totalLatihan: map['totalLatihan']?.toInt() ?? 0,
      kategori: map['kategori'] ?? '',
      fotoProfilUrl: map['fotoProfilUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static Anggota? fromJson(String? source) => source != null ? Anggota.fromMap(json.decode(source)) : null;

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
