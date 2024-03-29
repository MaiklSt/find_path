
import 'package:dio/dio.dart';

class Failure {
  final int code;
  final String message;
  final Response? response;

  Failure(this.message, {required this.code, this.response});
}
