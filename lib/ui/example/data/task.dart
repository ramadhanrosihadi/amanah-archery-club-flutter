import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starter_d/data/model/berkas.dart';
import 'package:starter_d/data/network/data/network_request_data.dart';
import 'package:starter_d/data/network/network_call.dart';
import 'package:starter_d/helper/constant/urls.dart';

class Task {
  final int id;
  final String name;
  final String description;
  final int file_id;
  final String created_at;
  final String updated_at;
  final Berkas? file;
  Task({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.file_id = 0,
    this.created_at = '',
    this.updated_at = '',
    this.file,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'file_id': file_id,
      'created_at': created_at,
      'updated_at': updated_at,
      'file': file?.toMap(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      file_id: map['file_id']?.toInt() ?? 0,
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      file: Berkas.fromMap(map['file']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  static List<Task> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<Task>((e) => Task.fromMap(e)).toList();
  }
}
