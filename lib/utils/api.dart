
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:webspark_test_task/configs/config.dart';
import 'package:webspark_test_task/configs/endpoints.dart';
import 'package:webspark_test_task/utils/failure.dart';

class Api {
  late final Dio _dio;
  Api() {
    final options = BaseOptions(
      baseUrl: Config.apiBaseUrl,
      connectTimeout: Config.apiConnectTimeout,
    );

    _dio = Dio(options);

    if (kDebugMode) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
            debugPrint('Request - [${options.method}] => URL: ${options.uri}');
            return handler.next(options);
          },
          onResponse: (Response response, ResponseInterceptorHandler handler) {
            debugPrint('Response - [${response.statusCode}] => DATA: ${response.data}');
            return handler.next(response);
          },
          onError: (DioException error, ErrorInterceptorHandler handler) {
            debugPrint('Error - [${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
            return handler.next(error);
          },
        ),
      );
    }
  }

  Future getDataForProcessing() async {
    try {
      // ignore: unused_local_variable
      var response = await _dio.get(Endpoints.flutterApi);
    } on DioException catch (e) {
      throw Failure(e.message ?? '', code: e.response?.statusCode ?? 0);
    } catch (e) {
      throw Failure('Something happened... please try again later.', code: 0);
    }
  }
}
