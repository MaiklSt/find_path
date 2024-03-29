
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:webspark_test_task/configs/config.dart';
import 'package:webspark_test_task/utils/failure.dart';
class Api {
  
  static Api? _instance;

  Api._() {
    final options = BaseOptions(
      // baseUrl: Config.apiBaseUrl,
      connectTimeout: Config.apiConnectTimeout,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      }
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
            debugPrint('Full URL: ${error.requestOptions.uri}');
            return handler.next(error);
          },
        ),
      );
    }
  }

  factory Api() => _instance ??= Api._();

  late final Dio _dio;

  String? postUrl;

  Future<Response> getDataForProcessing(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      throw Failure(e.message ?? '', code: e.response?.statusCode ?? 0);
    } catch (e) {
      throw Failure('$e', code: 0);
    }
  }

  Future<Response> sendResultsToServer(List<Map<String, dynamic>> results) async {
    try {
      return await _dio.post(
        postUrl!,
        data: results,

        //response about an incorrect calculation
        // data: [
        //   {
        //     "id": "7d785c38-cd54-4a98-ab57-44e50ae646c1",
        //     "result": {
        //       "steps": [
        //         {
        //           "x": "0",
        //           "y": "0"
        //         },
        //         {
        //           "x": "0",
        //           "y": "1"
        //         }
        //       ],
        //       "path": "(0,0)->(0,1)"
        //     }
        //   }
        // ]
      );
    } on DioException catch (e) {
      throw Failure(e.message ?? '', code: e.response?.statusCode ?? 0, response: e.response);
    } catch (e) {
      throw Failure('$e', code: 0);
    }
  }
}
