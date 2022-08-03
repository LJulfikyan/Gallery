import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/networking/custom_dio_logger.dart';

class CallApi {
  static Future<dynamic>? call(
      {required String url,
      required BaseOptions options,
      dynamic body = const {}}) async {
    var dio = Dio(options);
    dio.interceptors.add(CustomDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));
    try {
      var response = await dio.request(
        url,
        data: body,
      );
      return response.data;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
