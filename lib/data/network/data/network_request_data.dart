import 'package:dio/dio.dart';

enum Method { post, get }

class NetworkRequestData {
  final String url;
  final Method method;
  final Map<String, dynamic>? payload;
  final FormData? formData;

  NetworkRequestData({this.url = '', this.method = Method.post, this.payload, this.formData});

  dynamic getRequestBody() {
    if (formData != null) {
      return formData;
    } else if (payload != null) {
      return payload;
    }
    return null;
  }
}
