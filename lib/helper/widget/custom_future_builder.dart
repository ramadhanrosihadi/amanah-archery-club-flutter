import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:starter_d/data/network/data/network_request_data.dart';
import 'package:starter_d/data/network/data/network_response_data.dart';
import 'package:starter_d/data/network/network_call.dart';

class CustomFutureBuilder extends StatelessWidget {
  const CustomFutureBuilder({Key? key, required this.url, required this.buildSuccess, required this.reload, this.method = Method.post}) : super(key: key);
  final String url;
  final Function(dynamic) buildSuccess;
  final Method method;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response<NetworkResponseData>>(
      future: NetworkCall.send(url: url, method: method),
      builder: (context, AsyncSnapshot<Response<NetworkResponseData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          NetworkResponseData responseData = snapshot.data!.data!;
          if (responseData.hasError()) {
            return GestureDetector(
              onTap: () => reload(),
              child: Center(
                child: Text(responseData.errors),
              ),
            );
          }
          String responseDataJson = snapshot.data!.data!.data;
          return buildSuccess(json.decode(responseDataJson));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Mohon tunggu...'));
        }
        return const Center(child: Text('KOSONG'));
      },
    );
  }
}
