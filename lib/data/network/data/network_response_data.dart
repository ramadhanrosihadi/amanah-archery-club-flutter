import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starter_d/data/network/data/network_request_data.dart';
import 'package:starter_d/helper/util/fun.dart';

import '../network_call.dart';

class NetworkResponseData {
  int responseCode;
  String message;
  String errors;
  String data;
  NetworkRequestData? requestData;
  NetworkResponseData({
    this.responseCode = 0,
    this.message = '',
    this.errors = '',
    this.data = '',
    this.requestData,
  });

  bool hasError() => errors != '';

  Map<String, dynamic> toMap() {
    return {
      'responseCode': responseCode,
      'message': message,
      'errors': errors,
      'data': data,
    };
  }

  static NetworkResponseData? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    String errorText = '';
    List<String>.from(map['errors'] ?? const []).forEach((e) => {errorText += e});
    return NetworkResponseData(
      responseCode: map['responseCode'] ?? 0,
      message: map['message'] ?? '',
      errors: errorText,
      data: jsonEncode(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  static NetworkResponseData? fromJson(String source) => NetworkResponseData.fromMap(json.decode(source));
}
