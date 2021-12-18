import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';

class Anggota {
  String? id;
  String? nama;
  String? nomorHp;
  String? email;
  String? alamat;
  Timestamp? tanggalLahir;
  Timestamp? tanggalBergabung;
  String? jenisKelamin;
  String? nik;
  String? pekerjaan;
  int? totalLatihan;
  String? kategori;
  String? fotoProfilUrl;
  String? password;
  String? roles;
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
    this.password = '',
    this.roles = '',
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
      'password': password,
      'roles': roles,
    };
  }

  Map<String, dynamic> toMapLogin() {
    return {
      'id': id,
      'nama': nama,
      'nomorHp': nomorHp,
      'email': email,
      'alamat': alamat,
      'jenisKelamin': jenisKelamin,
      'nik': nik,
      'pekerjaan': pekerjaan,
      'totalLatihan': totalLatihan,
      'kategori': kategori,
      'fotoProfilUrl': fotoProfilUrl,
      'password': password,
      'roles': roles,
    };
  }

  static Anggota? fromMap(Map<String, dynamic> map) {
    return Anggota(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      nomorHp: map['nomorHp'] ?? '',
      email: map['email'] ?? '',
      alamat: map['alamat'] ?? '',
      tanggalLahir: map['tanggalLahir'],
      tanggalBergabung: map['tanggalBergabung'],
      jenisKelamin: map['jenisKelamin'] ?? '',
      nik: map['nik'] ?? '',
      pekerjaan: map['pekerjaan'] ?? '',
      totalLatihan: map['totalLatihan']?.toInt() ?? 0,
      kategori: map['kategori'] ?? '',
      fotoProfilUrl: map['fotoProfilUrl'] ?? '',
      password: map['password'] ?? '',
      roles: map['roles'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  String toJsonLogin() => json.encode(toMapLogin());

  static Anggota? fromMapLogin(Map<String, dynamic> map) {
    return Anggota(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      nomorHp: map['nomorHp'] ?? '',
      email: map['email'] ?? '',
      alamat: map['alamat'] ?? '',
      // tanggalLahir: map['tanggalLahir'],
      // tanggalBergabung: map['tanggalBergabung'],
      jenisKelamin: map['jenisKelamin'] ?? '',
      nik: map['nik'] ?? '',
      pekerjaan: map['pekerjaan'] ?? '',
      totalLatihan: map['totalLatihan']?.toInt() ?? 0,
      kategori: map['kategori'] ?? '',
      fotoProfilUrl: map['fotoProfilUrl'] ?? '',
      password: map['password'] ?? '',
      roles: map['roles'] ?? '',
    );
  }

  static Anggota? fromJsonLogin(String? source) => source != null ? Anggota.fromMapLogin(json.decode(source)) : null;
  static Anggota? fromJson(String? source) => source != null ? Anggota.fromMap(json.decode(source)) : null;

  static String defaultPassword = 'amanah';

  bool isPengurus() {
    return Fun.replaceEmpty(roles).contains('pengurus') || Fun.replaceEmpty(roles).contains('super-admin');
  }

  bool isPengurusOnly() {
    return Fun.replaceEmpty(roles).contains('pengurus');
  }

  bool isAnggota() {
    return Fun.replaceEmpty(roles).contains('anggota');
  }

  bool isSuperAdmin() {
    return Fun.replaceEmpty(roles).contains('super-admin');
  }

  String tanggalBergabungString() {
    if (tanggalBergabung == null) return '-';
    return VTime.fromTimeStampToDefaultFormat(tanggalBergabung);
  }

  String tanggalLahirString() {
    if (tanggalLahir == null) return '-';
    return VTime.fromTimeStampToDefaultFormat(tanggalLahir);
  }

  int umur() {
    return VTime.yearDurationFromTimeStamp(tanggalLahir);
  }

  static Future<bool> insert(BuildContext context, Anggota anggota) async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    List<Anggota> anggotas = await Anggota.gets();
    for (Anggota item in anggotas) {
      if (item.nomorHp == anggota.nomorHp) {
        await VDialog.createDialog(context, message: 'Nomor hp sudah didaftarkan', withBackButton: false);
        return false;
      }
    }
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

  Future<bool> setAsPengurus() async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    this.roles = 'pengurus';
    Fun.showLog('setAsPengurus roles: ${this.toMap()}');
    await datas.doc(this.id).update(this.toMap());
    return true;
  }

  Future<bool> unsetAsPengurus() async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    this.roles = 'anggota';
    await datas.doc(this.id).update(this.toMap());
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

  static Future<bool> signin(BuildContext context, String nomorHp, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> datas = firestore.collection('anggotas');
    QuerySnapshot<Map<String, dynamic>?>? results = await datas.get();
    List<Anggota> lists = [];
    for (DocumentSnapshot ds in results.docs) {
      ds.data();
      Anggota? data = Anggota.fromMap(ds.data() as Map<String, dynamic>);
      if (data != null && nomorHp == data.nomorHp) {
        if (data.password != password) {
          await VDialog.createDialog(context, title: 'Gagal', message: 'Kata sandi tidak cocok');
          return false;
        } else {
          await UserPref.saveUser(data);
          return true;
        }
      }
    }
    return false;
  }
}
