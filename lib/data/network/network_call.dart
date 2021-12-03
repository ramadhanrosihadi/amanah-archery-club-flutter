import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:starter_d/data/network/data/network_request_data.dart';
import 'package:starter_d/data/network/data/network_response_data.dart';
import 'package:starter_d/helper/constant/var.dart';
import 'package:starter_d/helper/util/fun.dart';

class NetworkCall {
  static Future<Response<NetworkResponseData>> send({url = '', method = Method.post, payload, formData}) async {
    final NetworkRequestData requestData = NetworkRequestData(url: url, method: method, payload: payload, formData: formData);
    NetworkResponseData responseData = NetworkResponseData();
    Dio dio = Dio();
    await addInterceptor(dio);
    try {
      Response<Map<String, dynamic>> response;
      if (method == Method.get) {
        response = await dio.get(requestData.url);
      } else {
        response =
            await dio.post(requestData.url, data: requestData.getRequestBody());
      }
      responseData = NetworkResponseData.fromMap(response.data)!;
    } catch (e) {
      responseData.errors = e.toString();
    }
    responseData.requestData = requestData;
    return Response(requestOptions: RequestOptions(path: requestData.url), data: responseData);
  }

  static Future addInterceptor(Dio dio) async {
    if (Var.isDebugMode) {
      dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 200));
    }
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['device-Info'] = await Fun.deviceInfo();
    dio.options.headers['version-Code'] = await Fun.currentVersionCode();
    dio.options.headers['version-Name'] = await Fun.currentVersionName();
    // dio.options.headers['token-Firebase'] = "-";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.followRedirects = false;
    // var user = await UserPref.loadUser();
    // if (user.access != null) {
    //   String authorization =
    //       "${user.access.token_type} ${user.access.access_token}";
    //   dio.options.headers['authorization'] = authorization;
    // }
  }
}
