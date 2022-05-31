import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/data/preference/user_pref.dart';
import 'package:starter_d/helper/util/fun.dart';
import 'package:starter_d/helper/util/vdialog.dart';
import 'package:starter_d/helper/util/vtime.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Anggota {
  String? id;
  String? code;
  String? username;
  String? nama;
  String? nomorHp;
  String? email;
  String? alamat;
  Timestamp? tanggalLahir;
  Timestamp? tanggalBergabung;
  String? jenisKelamin;
  String? pekerjaan;
  int? totalLatihan;
  String? kategori;
  String? fotoProfilUrl;
  String? password;
  String? roles;
  Anggota({
    this.id = '',
    this.code = '',
    this.username = '',
    this.nama = '',
    this.nomorHp = '',
    this.email = '',
    this.alamat = '',
    this.tanggalLahir,
    this.tanggalBergabung,
    this.jenisKelamin = '',
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
      'code': code,
      'username': username,
      'nama': nama,
      'nomorHp': nomorHp,
      'email': email,
      'alamat': alamat,
      'tanggalLahir': tanggalLahir,
      'tanggalBergabung': tanggalBergabung,
      'jenisKelamin': jenisKelamin,
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
      'code': code,
      'username': username,
      'nama': nama,
      'nomorHp': nomorHp,
      'email': email,
      'alamat': alamat,
      'jenisKelamin': jenisKelamin,
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
      code: map['code'] ?? '',
      username: map['username'] ?? '',
      nama: map['nama'] ?? '',
      nomorHp: map['nomorHp'] ?? '',
      email: map['email'] ?? '',
      alamat: map['alamat'] ?? '',
      tanggalLahir: map['tanggalLahir'],
      tanggalBergabung: map['tanggalBergabung'],
      jenisKelamin: map['jenisKelamin'] ?? '',
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
      code: map['code'] ?? '',
      username: map['username'] ?? '',
      nama: map['nama'] ?? '',
      nomorHp: map['nomorHp'] ?? '',
      email: map['email'] ?? '',
      alamat: map['alamat'] ?? '',
      // tanggalLahir: map['tanggalLahir'],
      // tanggalBergabung: map['tanggalBergabung'],
      jenisKelamin: map['jenisKelamin'] ?? '',
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

  String tanggalBergabungISO() {
    if (tanggalBergabung == null) return '';
    return VTime.fromTimeStampToDefaultFormat(tanggalBergabung, format: 'yyyy-MM-dd');
  }

  String tanggalLahirISO() {
    if (tanggalLahir == null) return '';
    return VTime.fromTimeStampToDefaultFormat(tanggalLahir, format: 'yyyy-MM-dd');
  }

  String tanggalLahirString() {
    if (tanggalLahir == null) return '-';
    return VTime.fromTimeStampToDefaultFormat(tanggalLahir);
  }

  String umur() {
    int umurx = VTime.yearDurationFromTimeStamp(tanggalLahir);
    if (umurx > 0) return '$umurx tahun';
    return '(belum input tanggal lahir)';
  }

  static Future<bool> insert(BuildContext context, Anggota anggota) async {
    CollectionReference datas = FirebaseFirestore.instance.collection('anggotas');
    List<Anggota> anggotas = await Anggota.gets();
    for (Anggota item in anggotas) {
      if (item.username == anggota.username) {
        // await VDialog.createDialog(context, message: 'Username ${anggota.username} sudah didaftarkan', withBackButton: false);
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

  static Future downloadExcel() async {
    List<Anggota> anggotas = await Anggota.gets();
    int totalWorkSheet = 1;
    final Workbook workbook = Workbook(totalWorkSheet);
    int sheetIndex = 0;
    CellStyle contentStyle = CellStyle(workbook);
    contentStyle.fontSize = 12;
    contentStyle.hAlign = HAlignType.center;
    contentStyle.vAlign = VAlignType.center;
    contentStyle.bold = false;
    CellStyle headerStyle = CellStyle(workbook);
    headerStyle.bold = true;
    headerStyle.fontSize = 13;
    headerStyle.hAlign = HAlignType.center;
    headerStyle.vAlign = VAlignType.center;
    final Worksheet sheet = workbook.worksheets[sheetIndex];
    sheet.name = 'Data Anggota';
    int row = 1;
    sheet.setColumnWidthInPixels(1, 40);
    sheet.setColumnWidthInPixels(2, 60);
    sheet.setColumnWidthInPixels(3, 100);
    sheet.setColumnWidthInPixels(4, 300);
    sheet.setColumnWidthInPixels(5, 120);
    sheet.setColumnWidthInPixels(6, 150);
    sheet.setColumnWidthInPixels(7, 170);
    sheet.setColumnWidthInPixels(8, 150);
    sheet.setColumnWidthInPixels(9, 150);
    sheet.setColumnWidthInPixels(10, 150);
    sheet.setColumnWidthInPixels(11, 150);
    sheet.setColumnWidthInPixels(12, 500);
    sheet.setColumnWidthInPixels(13, 200);
    sheet.getRangeByIndex(row, 1).setText('No.');
    sheet.getRangeByIndex(row, 2).setText('Kode');
    sheet.getRangeByIndex(row, 3).setText('Username');
    sheet.getRangeByIndex(row, 4).setText('Nama Lengkap');
    sheet.getRangeByIndex(row, 5).setText('Jenis Kelamin');
    sheet.getRangeByIndex(row, 6).setText('Nomor HP');
    sheet.getRangeByIndex(row, 7).setText('Email');
    sheet.getRangeByIndex(row, 8).setText('Tanggal Lahir');
    sheet.getRangeByIndex(row, 9).setText('Status Keanggotaan');
    sheet.getRangeByIndex(row, 10).setText('Tanggal Bergabung');
    sheet.getRangeByIndex(row, 11).setText('Pekerjaan');
    sheet.getRangeByIndex(row, 12).setText('Alamat');
    sheet.getRangeByIndex(row, 13).setText('Foto Profil');
    sheet.getRangeByName('A1:Q1').cellStyle = headerStyle;
    sheet.getRangeByName('A2:Q300').cellStyle = contentStyle;
    for (Anggota anggota in anggotas) {
      row++;
      sheet.getRangeByIndex(row, 1).setText('${row - 1}');
      sheet.getRangeByIndex(row, 2).setText(anggota.code);
      sheet.getRangeByIndex(row, 3).setText(anggota.username);
      sheet.getRangeByIndex(row, 4).setText(anggota.nama);
      sheet.getRangeByIndex(row, 5).setText(anggota.jenisKelamin);
      sheet.getRangeByIndex(row, 6).setText(anggota.nomorHp);
      sheet.getRangeByIndex(row, 7).setText(anggota.email);
      sheet.getRangeByIndex(row, 8).setText(anggota.tanggalLahirISO());
      sheet.getRangeByIndex(row, 9).setText(anggota.roles);
      sheet.getRangeByIndex(row, 10).setText(anggota.tanggalBergabungISO());
      sheet.getRangeByIndex(row, 11).setText(anggota.pekerjaan);
      sheet.getRangeByIndex(row, 12).setText(anggota.alamat);
      sheet.getRangeByIndex(row, 13).setText(anggota.fotoProfilUrl);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/AnggotaAmanahArchery.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  static String numberToCode(int value) {
    if (value < 1000) {
      if (value < 100) {
        if (value < 10) {
          return '000$value';
        } else {
          return '00$value';
        }
      } else {
        return '0$value';
      }
    }
    return value.toString();
  }
}
